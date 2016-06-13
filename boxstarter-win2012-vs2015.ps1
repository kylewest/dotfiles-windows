Disable-InternetExplorerESC
Disable-UAC

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-CornerNavigationOptions -DisableUpperRightCornerShowCharms -DisableUpperLeftCornerSwitchApps

#-- Chocolatey ---------

#-- Dependencies ---------
cinst -y dotnet3.5
cinst -y SourceCodePro

#-- Apps ---------
cinst -y googlechrome
cinst -y 7zip
cinst -y atom
cinst -y notepadplusplus
cinst -y sourcetree
cinst -y fiddler4
cinst -y linqpad5

#-- Development ---------
cinst -y mssqlservermanagementstudio2014express
cinst -y visualstudio2015community
cinst -y redis-desktop-manager
cinst -y resharper
cinst -y nuget.commandline
cinst -y ruby
cinst -y nodejs
# cinst -y cmder -pre     # enable once chocolately 0.9.10+ comes out
cinst -y kdiff3
cinst -y git -params "/GitAndUnixToolsOnPath"
cinst -y prefix

#-- VS Extensions ------
Install-ChocolateyVsixPackage "EditorConfig" "http://visualstudiogallery.msdn.microsoft.com/c8bccfe2-650c-4b42-bc5c-845e21f96328/file/75539/12/EditorConfigPlugin.vsix"


#-- Manual Installs ------
Write-BoxstarterMessage "Downloading manual installs.."
Get-ChocolateyWebFile 'AWSToolkit' "$env:USERPROFILE\Desktop\AWSToolkit.msi" 'http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi'
Get-ChocolateyWebFile 'cmder' "$env:USERPROFILE\Desktop\cmder.7z" 'https://github.com/cmderdev/cmder/releases/download/v1.3.0-pre/cmder.7z'

#-- Configuration ------
Write-BoxstarterMessage "Setting up bash profile and prompt.."
Get-ChocolateyWebFile 'setup-git.cmd' "$env:USERPROFILE\setup-git.cmd" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/setup-git.cmd'
Get-ChocolateyWebFile '.gitconfig' "$env:USERPROFILE\.gitconfig" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/.gitconfig'

Get-ChocolateyWebFile 'ConEmu.xml' "C:\tools\cmder\config\ConEmu.xml" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/ConEmu.xml'
Get-ChocolateyWebFile 'aliases' "C:\tools\cmder\config\aliases" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/aliases'
Get-ChocolateyWebFile 'git.lua' "C:\tools\cmder\config\git.lua" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/git.lua'

# Write-BoxstarterMessage "Creating projects folder in root"
New-Item -path "C:\code" -type directory -force

#-- POST install touches -------

#taskbar pins
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"
#Install-ChocolateyPinnedTaskBarItem "c:\tools\cmder\cmder.exe"