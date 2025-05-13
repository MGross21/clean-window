# Clear Temp Files
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue # USER/APPDATA/LOCAL/TEMP
Remove-Item "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue # SYSTEM TEMP

# Clear Windows Update Cache
Remove-Item "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue

# Delivery Optimization Cache
Remove-Item "$env:SystemRoot\DeliveryOptimization\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue

# Windows Error Reporting Cache
Remove-Item "$env:ProgramData\Microsoft\Windows\WER\ReportQueue\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\Microsoft\Windows\WER\ReportArchive\*" -Recurse -Force -ErrorAction SilentlyContinue

# Log Files
Remove-Item "$env:SystemRoot\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:SystemRoot\System32\LogFiles\*" -Recurse -Force -ErrorAction SilentlyContinue

# Browser Cache (INET Cache)
Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

# All Users Temp Files (skips system profiles)
Get-ChildItem "$env:SystemDrive\Users" -Directory | Where-Object {
    $_.Name -notin @('Public', 'Default', 'Default User', 'All Users')
} | ForEach-Object {
    $userTemp = "$($_.FullName)\AppData\Local\Temp"
    if (Test-Path $userTemp) {
        Remove-Item "$userTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Disk Cleanup (requires prior configuration via cleanmgr /sageset:1)
cleanmgr /sagerun:1

# Flush DNS Cache
Clear-DnsClientCache