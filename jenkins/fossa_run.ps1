#Requires -Version 5

[CmdletBinding()]
Param()

. $env:ALLUSERSPROFILE\fossa-cli\fossa.exe

$FOSSA_FAIL_BUILD_TOGGLE = $env:FOSSA_FAIL_BUILD.toLower()
if ($env:FOSSA_FAIL_BUILD_TOGGLE == "true") {
    . $env:ALLUSERSPROFILE\fossa-cli\fossa.exe test
    exit $LastExitCode
}
