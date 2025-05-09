& "$PSScriptRoot\lib\confirm_ps7.ps1"

# Clear Temp Files
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Disk Cleanup (Default Options)
cleanmgr /sagerun:1

# Flush DNS Cache
Clear-DnsClientCache

