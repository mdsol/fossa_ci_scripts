#Requires -Version 5

[CmdletBinding()]
Param()

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
