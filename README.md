<div align="center">
    <h1><img src="assets/clean-window-logo.png" alt="Clean Window" width="300px"></h1>
</div>

*Windows Cleanup Utilies*

## Instructions

Uses `Powershell 7+`

```bash
winget install --id=Microsoft.Powershell
```

Open `Powershell` as Administrator, then:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force
```

## Script Testing

> [!Caution]  
> Please note that regardless of the status table, all scripts are executed at your own risk. It is strongly recommended to save and close any critical applications beforehand. Avoid running scripts that directly execute content from unknown or untrusted URLs. This practice bypasses confirmation interactions and can pose significant security risks. Always review the script's content before execution to ensure it is safe and trustworthy.

| Script Name              | State          | Execute     |
|--------------------------|-----------|-----------------------|
| [Temp Cleanup](temp_cleanup.ps1)      | ❌ Not Tested  | `iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/temp_cleanup.ps1").Content`      |
| [Win11 Debloat](win11_debloat.ps1)     | ✅ Working     | `iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/win11_debloat.ps1").Content`     |
| [Package Updater](package_update.ps1) | ✅ Working     | `iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/package_update.ps1").Content` |
| [Package Installer](package_install.ps1) | ❌ Not Tested  | `iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/package_install.ps1").Content` |