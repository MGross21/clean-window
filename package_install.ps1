# Read package list from external configuration file
$packageFile = "./packages.conf"
if (Test-Path $packageFile) {
    $apps = Get-Content $packageFile
} else {
    Write-Error "Package configuration file not found: $packageFile"
    exit 1
}

foreach ($app in $apps) {
    winget install $app --accept-package-agreements --accept-source-agreements -h
}