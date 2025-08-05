# Get plain-text list of upgradeable packages
$rawOutput = winget upgrade --accept-source-agreements

# Skip header lines and parse remaining ones
$parsedList = $rawOutput |
    Where-Object { $_ -match '^\S' -and $_ -notmatch '^Name\s+Id\s+Version' } |
    ForEach-Object {
        $parts = ($_ -replace '\s{2,}', '|') -split '\|'
        if ($parts.Length -ge 2) {
            [PSCustomObject]@{
                Name = $parts[0].Trim()
                Id   = $parts[1].Trim()
            }
        }
    }

# Get total count
$total = $parsedList.Count
$index = 1

# Upgrade each package
foreach ($pkg in $parsedList) {
    Write-Host "`nUpgrading ($index/$total): $($pkg.Name)" -ForegroundColor Cyan
    $wingetArgs = @(
        "upgrade",
        "$($pkg.Id)",
        "--include-unknown",
        "--disable-interactivity",
        "--nowarn",
        "--accept-package-agreements",
        "--accept-source-agreements",
        "--force"
    )
    try {
        Start-Process -FilePath "winget" -ArgumentList $wingetArgs -NoNewWindow -Wait
        Write-Host "Success: $($pkg.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $($pkg.Name)" -ForegroundColor Red
    }
    $index++
}