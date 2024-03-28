<#
.SYNOPSIS
   This plugin uses smartctl to get the health of each disk
.DESCRIPTION
   This plugin uses smartctl to get the health of each disk
   Smartctl has to be installed and exe has to be in PATH
.Notes
    FileName    : check-windows-smart.ps1
.PARAMETER EXCLUDEPATTERN
    Optional. Regular expressions of disks (e.g. "/dev/sda" ) to ignore.
.PARAMETER PATHTOSMARTCTL
    Optional. Override path to smartctl.exe.
.EXAMPLE 
    powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-smart.ps1 90 95
#>

#
#   check-windows-smart.ps1
#
# DESCRIPTION:
#   This plugin uses smartctl to get the health of each disk.
#
# OUTPUT:
#   0 if everything is ok
#   1 if warning
#   2 if critical
#
# PLATFORMS:
#   Windows
#
# DEPENDENCIES:
#   Powershell 3.0 or above
#
# USAGE:
#   Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -File C:\\etc\\sensu\\plugins\\check-windows-smart.ps1
#
# NOTES:
#
# LICENSE:
#   Copyright 2016 sensu-plugins
#   Released under the same terms as Sensu (the MIT license); see LICENSE for details.
#

#Requires -Version 3.0

[CmdletBinding()]
Param(
  # Example "\/dev\/sd."
  [Parameter(Mandatory = $False, Position = 1)]
  [string[]]$EXCLUDEPATTERN,

  [Parameter(Mandatory = $False, Position = 2)]
  [string]$PATHTOSMARTCTL = "C:\Program Files\smartmontools\bin\smartctl.exe"
)

$PATHTOSMARTCTL = "& '$PATHTOSMARTCTL'"

$ThisProcess = Get-Process -Id $pid
$ThisProcess.PriorityClass = "BelowNormal"

$scan_result = Invoke-Expression "$PATHTOSMARTCTL --scan --json" | ConvertFrom-Json 

$devices = $scan_result.devices | Where-Object { $_.name -notmatch $EXCLUDEPATTERN }

$exit_code = 0

foreach ($device in $devices){
    $smart_result = Invoke-Expression "$PATHTOSMARTCTL -H --json $($device.name)" | ConvertFrom-Json
    
    if (-Not ($smart_result.PSObject.Properties.Name -Contains "smart_status")){
        "Smartctl failed: $($smart_result.smartctl.messages.string)"
        $exit_code = 1
    }elseif (-Not $smart_result.smart_status.passed){
        "Disk Smart_Status not passed: $($smart_result.device) - $($smart_result.smart_status) "
        $exit_code = 2
    }

    $ud = Get-Disk | Where-Object { $_.HealthStatus -ne "Healthy" }
    if ($ud.Count -gt 0){
        $ud
        $exit_code = 2
    }
}

exit $exit_code