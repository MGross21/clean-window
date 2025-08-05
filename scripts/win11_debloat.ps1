# Confirm PowerShell 7+
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell 7+ is required. Exiting." -ForegroundColor Red
    exit 1
}

# Confirm Admin Privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Script must be run as Administrator." -ForegroundColor Red
    exit 1
}

# Debloat - Remove consumer apps
$appsToRemove = @(
    "Microsoft.3DBuilder",
    "Microsoft.XboxApp",
    "Microsoft.SkypeApp",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.BingWeather",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.Tips",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.People"
)

foreach ($app in $appsToRemove) {
    Write-Host "Removing: $app" -ForegroundColor Yellow
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# Disable telemetry and feedback
Write-Host "Disabling Telemetry..." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force

New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -Force

# Remove Cortana
Write-Host "Removing Cortana..." -ForegroundColor Cyan
Get-AppxPackage -Name Microsoft.549981C3F5F10 -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue

# Disable Windows Copilot
Write-Host "Disabling Copilot..." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Type DWord -Value 1

# Disable Start Menu ads and suggestions
Write-Host "Disabling Start Menu ads..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0

# Optional: Disable background apps via registry (safer than Stop-Process)
Write-Host "Disabling background apps in registry..." -ForegroundColor Cyan
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

# Restart Explorer to apply changes (optional)
$restart = Read-Host "Restart Explorer to apply changes now? (y/n)"
if ($restart -eq 'y') {
    Write-Host "Restarting Explorer..." -ForegroundColor Cyan
    Stop-Process -Name explorer -Force
}