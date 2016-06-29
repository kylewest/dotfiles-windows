# clone repo
git clone git@github.com:W4RH4WK/Debloat-Windows-10.git

# remove comments so all services are disabled.
(Get-Content .\Debloat-Windows-10\scripts\disable-services.ps1).replace('#"', '"') | Set-Content .\Debloat-Windows-10\scripts\disable-services.ps1

Write-Output "Blocking Telemetry..."
.\Debloat-Windows-10\scripts\block-telemetry.ps1
Write-Output "Disabling Services..."
.\Debloat-Windows-10\scripts\disable-services.ps1
Write-Output "Disabling Windows Defender..."
.\Debloat-Windows-10\scripts\disable-windows-defender.ps1
Write-Output "Fixing Privacy Settings..."
.\Debloat-Windows-10\scripts\fix-privacy-settings.ps1
Write-Output "Optimizing User Interface..."
.\Debloat-Windows-10\scripts\optimize-user-interface.ps1
Write-Output "Optimizing Windows Update..."
.\Debloat-Windows-10\scripts\optimize-windows-update.ps1
Write-Output "Removing Default Apps..."
.\Debloat-Windows-10\scripts\remove-default-apps.ps1
#Write-Output "Removing OneDrive..."
#.\Debloat-Windows-10\scripts\remove-onedrive.ps1
