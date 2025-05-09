# Windows Cleanup Utilies

Uses `Powershell 7+`

```bash
winget install --id=Microsoft.Powershell
```

Open `Powershell` as Administrator, then:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force
```

## Confirmed Tested

| Script Name           | Tested Date | State          |
|-----------------------|-------------|----------------|
| [Temp Cleanup](temp_cleanup.ps1)      |             | ❌ Not Tested  |
| [Win11 Debloat](win11_debloat.ps1)     | 2025-05-28  | ✅ Working     |
| [Package Updater](package_update.ps1) | 2025-05-28  | ✅ Working     |
| [Package Installer](package_install.ps1) |             | ❌ Not Tested  |
