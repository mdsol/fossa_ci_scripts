#Requires -Version 5

[CmdletBinding()]
Param()

# DEPRECATION NOTICE
Write-Output "******************************************************************"
Write-Output "  NOTICE : THIS SCRIPT HAS BEEN PULLED FROM A DEPRECATED SOURCE"
Write-Output "           PLEASE SEE :"
Write-Output "  https://github.com/mdsol/fossa_ci_scripts/blob/main/jenkins/SETUP.md"
Write-Output "******************************************************************"

Write-Output "Installing FOSSA CLI..."
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/fossas/fossa-cli/master/install.ps1'))
Write-Output "FOSSA CLI Installed Successfully!"
