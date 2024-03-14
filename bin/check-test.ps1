<#
.SYNOPSIS
    Testcheck that returns status depending on parameter input.
.DESCRIPTION
    Only for testing purpose. Default Exits with status 0 / Ok.
.Notes
    FileName    : check-test.ps1
    Author      : Michael Diesen - diesen@dk-ds.de
.LINK
    https://github.com/Mapel/sensu-windows-powershell-checks
.PARAMETER Warning
    Optional. Switch for status 1
    Example -Warning
.PARAMETER Critical
    Optional. Switch for status 2. Overrides Warning.
    Example -Critical
.EXAMPLE
    powershell.exe -file check-windows-directory.ps1 -Dir C:\Users\dir
#>

[CmdletBinding()]
Param(
  [Parameter(Mandatory = $false)]
  [switch]$Warning,

  [Parameter(Mandatory = $false)]
  [switch]$Critical
)

if ($Critical) {
    "Testcheck: Critical"
    exit 2
}

if ($Warning) {
    "Testcheck: Warning"
    exit 1
}

"Testcheck: Ok"
exit 0