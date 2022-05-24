#Requires -Version 5

[CmdletBinding()]
Param()

if ($env:FOSSA_CLI_VERSION) {
    $env:FOSSA_RELEASE = "v${env:FOSSA_CLI_VERSION}"
    Write-Output "Installing FOSSA CLI v${FOSSA_CLI_VERSION}..."
}
else {
    Write-Output "Installing latest FOSSA CLI version..."
}
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.ps1'))
Write-Output "FOSSA CLI Installed Successfully!"
