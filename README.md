# Windows Cleanup Utilies

Uses `Powershell 7+`

```bash
winget install --id=Microsoft.Powershell
```

Open `Powershell` as Administrator, then:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force
```

## Script Testing

> [!WARNING]  
> Please note that regardless of the status table, all scripts are executed at your own risk. It is strongly recommended to save and close any critical applications beforehand.

| Script Name           | Tested Date | State          |
|-----------------------|-------------|----------------|
| [Temp Cleanup](temp_cleanup.ps1)      |             | ❌ Not Tested  |
| [Win11 Debloat](win11_debloat.ps1)     | 2025-05-28  | ✅ Working     |
| [Package Updater](package_update.ps1) | 2025-05-28  | ✅ Working     |
| [Package Installer](package_install.ps1) |             | ❌ Not Tested  |
