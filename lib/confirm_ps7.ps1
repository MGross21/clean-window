# Ensure PowerShell 7+
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7+. Please run it in PowerShell 7." -ForegroundColor Red
    exit 1
}

# Relaunch as Administrator if not already
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host "Restarting as Administrator in PowerShell 7..." -ForegroundColor Yellow

    $scriptPath = $MyInvocation.MyCommand.Definition
    $ps7Path = (Get-Command pwsh).Source  # Path to PowerShell 7 executable

    Start-Process -FilePath $ps7Path -ArgumentList "-NoProfile", "-ExecutionPolicy Bypass", "-File `"$scriptPath`"" -Verb RunAs
    exit
}