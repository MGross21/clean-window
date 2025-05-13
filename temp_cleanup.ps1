# Define static cleanup locations
$cleanupPaths = @(
    "$env:TEMP",
    "$env:SystemRoot\Temp",
    "$env:SystemRoot\SoftwareDistribution\Download",
    "$env:SystemRoot\DeliveryOptimization\Cache",
    "$env:ProgramData\Microsoft\Windows\WER\ReportQueue",
    "$env:ProgramData\Microsoft\Windows\WER\ReportArchive",
    "$env:SystemRoot\Logs",
    "$env:SystemRoot\System32\LogFiles",
    "$env:LOCALAPPDATA\Microsoft\Windows\INetCache"
)

# Add user-specific temp folders (skipping system profiles)
$cleanupPaths += Get-ChildItem "$env:SystemDrive\Users" -Directory | Where-Object {
    $_.Name -notin @('Public', 'Default', 'Default User', 'All Users')
} | ForEach-Object {
    "$($_.FullName)\AppData\Local\Temp"
}

# Cleanup loop
foreach ($path in $cleanupPaths) {
    if (Test-Path $path) {
        try {
            Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
        } catch {
            Write-Host "Failed to clean: $path"
        }
    }
}

# Run Disk Cleanup (requires configuration with /sageset:1)
cleanmgr /sagerun:1

# Flush DNS Cache
Clear-DnsClientCache