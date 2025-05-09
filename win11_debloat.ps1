# Debloat: Remove consumer apps
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
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# Disable Telemetry & Feedback
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -Force

# Kill Cortana
Get-AppxPackage -Name Microsoft.549981C3F5F10 | Remove-AppxPackage -AllUsers

# Disable background apps
Get-AppxPackage | ForEach-Object {
    $packageName = $_.Name
    Stop-Process -Name $packageName -ErrorAction SilentlyContinue
}

# Disable Start Menu ads and suggestions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0
