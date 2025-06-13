# Check if running as administrator
if (-not ([bool](New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Error "This script must be run as an administrator."
    exit 1
}

# Check if running in PowerShell 7 or higher
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Error "This script requires PowerShell 7 or higher."
    exit 1
}

# Read and install from a YAML winget config file
$remoteUrl = "https://raw.githubusercontent.com/MGross21/clean-window/main/packages.yaml"
$tempFile = [IO.Path]::GetTempFileName()

try {
    winget settings --enable LocalManifestFiles # Ensure LocalManifestFiles feature is enabled
    Invoke-WebRequest $remoteUrl -OutFile $tempFile -UseBasicParsing
    winget install --manifest $tempFile --accept-package-agreements --accept-source-agreements --silent
} catch {
    Write-Error "Install failed: $_"
    exit 1
} finally {
    Remove-Item $tempFile -ErrorAction SilentlyContinue
}