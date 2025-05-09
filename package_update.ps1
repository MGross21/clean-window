# Get list of upgradable packages with IDs
$upgradeList = winget upgrade --accept-source-agreements | Where-Object { $_ -match '^\S' } | ForEach-Object {
    $parts = ($_ -replace '\s{2,}', '|') -split '\|'
    if ($parts.Count -ge 2) {
        [PSCustomObject]@{
            Name = $parts[0].Trim()
            Id   = $parts[1].Trim()
        }
    }
} | Where-Object { $_.Id -ne $null }

# Upgrade each package
foreach ($pkg in $upgradeList) {
    Write-Host "`nUpgrading: $($pkg.Name)" -ForegroundColor Cyan
    $cmd = "winget upgrade `"$($pkg.Id)`" --include-unknown --disable-interactivity --nowarn --accept-package-agreements --accept-source-agreements --force"
    try {
        iex $cmd | Out-Null
        Write-Host "Success: $($pkg.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $($pkg.Name)" -ForegroundColor Red
    }
}