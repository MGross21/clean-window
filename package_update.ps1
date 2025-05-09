# Get list of upgradable packages using structured JSON output
$upgradeList = winget upgrade --accept-source-agreements --output json | ConvertFrom-Json

# Upgrade each package safely using Start-Process
foreach ($pkg in $upgradeList) {
    if ($pkg.Id -and $pkg.Name) {
        Write-Host "`nUpgrading: $($pkg.Name)" -ForegroundColor Cyan

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
    }
}