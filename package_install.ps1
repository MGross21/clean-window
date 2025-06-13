# Read and install from a YAML winget config file
$remoteUrl = "https://raw.githubusercontent.com/MGross21/clean-window/main/packages.yaml"
$tempFile = [IO.Path]::GetTempFileName()

try {
    winget settings --enable LocalManifestFiles # Ensure LocalManifestFiles feature is enabled
    Invoke-WebRequest $remoteUrl -OutFile $tempFile -UseBasicParsing
    winget install --manifest $tempFile --accept-package-agreements --accept-source-agreements -h
} catch {
    Write-Error "Install failed: $_"
    exit 1
} finally {
    Remove-Item $tempFile -ErrorAction SilentlyContinue
}