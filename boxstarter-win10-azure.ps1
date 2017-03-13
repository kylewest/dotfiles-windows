Disable-InternetExplorerESC
Disable-UAC

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-CornerNavigationOptions -DisableUpperRightCornerShowCharms -DisableUpperLeftCornerSwitchApps

# temporarily enable/disable features to bypass checksums
# http://blog.zerosharp.com/boxstarter-and-checksums/
choco feature disable -n=checksumFiles
choco feature enable -n=allowEmptyChecksums
choco feature enable -n=allowEmptyChecksumsSecure
try {
  #-- Chocolatey ---------

  #-- Dependencies ---------
  cinst -y dotnet3.5
  cinst -y SourceCodePro

  #-- Apps ---------
  cinst -y googlechrome
  cinst -y firefox
  cinst -y 7zip
  cinst -y atom
  cinst -y cmder
  cinst -y notepadplusplus
  cinst -y sourcetree
  cinst -y fiddler4
  cinst -y linqpad

  #-- Development ---------
  cinst -y mssqlservermanagementstudio2014express
  cinst -y redis-desktop-manager
  cinst -y resharper
  cinst -y nuget.commandline
  cinst -y ruby
  cinst -y nodejs
  cinst -y kdiff3
  cinst -y git -params "/GitAndUnixToolsOnPath"
  cinst -y prefix
}
finally {
  choco feature enable -n=checksumFiles
  choco feature disable -n=allowEmptyChecksums
  choco feature disable -n=allowEmptyChecksumsSecure
}

#-- Manual Installs ------
Write-BoxstarterMessage "Downloading manual installs.."
Get-ChocolateyWebFile 'AWSToolkit' "$env:USERPROFILE\Desktop\AWSToolkit.msi" 'http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi'


#-- Configuration ------
Write-BoxstarterMessage "Setting up bash profile and prompt.."
Get-ChocolateyWebFile 'setup-environment.cmd' "$env:USERPROFILE\setup-environment.cmd" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/setup-environment.cmd'
Get-ChocolateyWebFile 'windows10-cleanup.ps1' "$env:USERPROFILE\windows10-cleanup.ps1" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/windows10-cleanup.ps1'
Get-ChocolateyWebFile '.gitconfig' "$env:USERPROFILE\.gitconfig" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/.gitconfig'

Get-ChocolateyWebFile 'ConEmu.xml' "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/ConEmu.xml'
Get-ChocolateyWebFile 'aliases' "C:\tools\cmder\config\aliases" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/aliases'
Get-ChocolateyWebFile 'git.lua' "C:\tools\cmder\config\git.lua" 'https://raw.githubusercontent.com/kylewest/dotfiles-windows/master/config/cmder/git.lua'

# Write-BoxstarterMessage "Creating projects folder in root"
New-Item -path "C:\code" -type directory -force


#-- POST install touches -------

#taskbar pins
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "c:\tools\cmder\cmder.exe"
