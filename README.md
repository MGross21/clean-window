<div align="center">
    <h1><img src="assets/clean-window-logo.png" alt="Clean Window" width="300px"></h1>
</div>

*Windows Cleanup Utilies*

## Instructions

### Install PowerShell 7

`Win`+`R`, type `cmd`, then open as admin (`ctrl`+`shift`+`enter`)

```bash
winget install --id=Microsoft.Powershell
```

### Open `Powershell` as Administrator

```bash
powershell -Command "Start-Process pwsh -Verb RunAs"
```

### Change Execution Permissions

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force
```

### Running Scripts

> [!Caution]  
> Please note that regardless of the listed status, all scripts are executed at your own risk. It is strongly recommended to save and close any critical applications beforehand. Generally, avoid running scripts that directly execute content from unknown or untrusted URLs. This practice bypasses confirmation interactions and can pose significant security risks. Always review the script's content before execution to ensure it is safe and trustworthy.

#### Package Updater

**State:** ✅ Working  (Windows 11 | Ver. 24H2)

```powershell
iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/package_update.ps1").Content
```

#### Win11 Debloat

**State:** ✅ Working (Windows 11 | Ver. 24H2)

```powershell
iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/win11_debloat.ps1").Content
```

#### Temp Cleanup

**State:** ❌ Not Tested  

```powershell
iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/temp_cleanup.ps1").Content
```

#### Package Installer

**State:** ❌ Not Tested  

```powershell
iex (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MGross21/clean-window/main/package_install.ps1").Content
```
