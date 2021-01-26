#Requires -Version 5

[CmdletBinding()]
Param()

# DEPRECATION NOTICE
Write-Output "******************************************************************"
Write-Output "  NOTICE : THIS SCRIPT HAS BEEN PULLED FROM A DEPRECATED SOURCE"
Write-Output "           PLEASE SEE :"
Write-Output "  https://github.com/mdsol/fossa_ci_scripts/blob/main/jenkins/SETUP.md"
Write-Output "******************************************************************"

# Randomly Fail the Build to enforce adoption of new branch name
#$FAIL_BUILD = Get-Random -Maximum 10
#if ($FAIL_BUILD < 1) {
#    exit 1
#}

Write-Output "Queuing FOSSA Checks..."
. $env:ALLUSERSPROFILE\fossa-cli\fossa.exe --debug
Write-Output "FOSSA Checks Queued Successfully!"

$FOSSA_FAIL_BUILD_TOGGLE = $false
if (Test-Path env:FOSSA_FAIL_BUILD) {
    $FOSSA_FAIL_BUILD_TOGGLE = [System.Convert]::ToBoolean($env:FOSSA_FAIL_BUILD)
}

if ($FOSSA_FAIL_BUILD_TOGGLE) {
    Write-Output "FOSSA Fail Build Flag Enabled.  Checking for Policy Violations..."
    . $env:ALLUSERSPROFILE\fossa-cli\fossa.exe test --debug
    $FOSSA_EXIT_CODE = $LASTEXITCODE
    
    Write-Output "FOSSA Policy Violations check returned : $FOSSA_EXIT_CODE (non-zero codes are failures)"
    exit $FOSSA_EXIT_CODE
}
