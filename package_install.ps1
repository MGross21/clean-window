$apps = @(
    "Notepad++.Notepad++",
    "Microsoft.VisualStudioCode",
    "7zip.7zip",
    "VideoLAN.VLC",
    "Valve.Steam",
    "OBSProject.OBSStudio",
    "Discord.Discord"
)
foreach ($app in $apps) {
    winget install $app --accept-package-agreements --accept-source-agreements -h
}