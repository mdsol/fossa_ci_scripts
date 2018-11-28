#Requires -Version 5

[CmdletBinding()]
Param()

Write-Output "Installing FOSSA CLI..."
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/fossas/fossa-cli/master/install.ps1'))
Write-Output "FOSSA CLI Installed Successfully!"
