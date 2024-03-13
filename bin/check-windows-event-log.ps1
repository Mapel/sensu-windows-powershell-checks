<#
.SYNOPSIS
    Returns all occurances of events based on given filter parameter in a event log
.DESCRIPTION
    Checks Event log for pattern and returns the number criticals and warnings that match that pattern.
.Notes
    FileName    : check-windows-event-log.ps1
    Author      : Patrice White - patrice.white@ge.com
.LINK
    https://github.com/sensu-plugins/sensu-plugins-windows
.PARAMETER LogName
    Required. The name of the log file. Allows wildcard.
    Example -LogName Application
.PARAMETER ProviderName
    Optional. Filter on Providername. Allows wildcard.
.PARAMETER Pattern
    Optional. The pattern you want to search for.
    Example -LogName Application -Pattern error
.PARAMETER TimeIntervall
    Optional. Set filter on Startdate depending on the time when the script runs in minutes.
    Example -LogName Application -TimeIntervall 2
.PARAMETER additionalFilter
    Optional. Add custom "where" filter as a scriptblock
    Example -LogName Application -additionalFilter {$_.Id -eq 1234}
.PARAMETER CriticalLevel
    Optional. Integer Event Log Level to trigger Critical return status. Defaults to 2 = Error. Set to greater than 5 to disable. Error if both CriticalLevel and WarningLevel are disabled!
    Example -LogName Application -Pattern error -CriticalLevel 2
.PARAMETER WarningLevel
    Optional. Integer Event Log Level to trigger Warning return status.  Defaults to 3 = Warning. Set to greater than 5 to disable. Error if both CriticalLevel and WarningLevel are disabled!
    Example -LogName Application -Pattern error -WarningLevel 3
.EXAMPLE
    powershell.exe -file check-windows-log.ps1 -LogName Application -Pattern error
#>

[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)]
  [string]$LogName,
  [Parameter(Mandatory = $False)]
  [string]$ProviderName,
  [Parameter(Mandatory = $False)]
  [string]$Pattern,
  [Parameter(Mandatory = $False)]
  [int]$TimeIntervall = 0,
  [Parameter(Mandatory = $False)]
  [scriptblock]$additionalFilter = {$true},
  [Parameter(Mandatory = $False)]
  [int]$CriticalLevel = 2,
  [Parameter(Mandatory = $False)]
  [int]$WarningLevel = 3
)

if ($CriticalLevel -in 0..5 -or $WarningLevel -in 0..5){
  $Levels = (0..(($CriticalLevel,$WarningLevel) | Measure-Object -maximum).Maximum)
}else{
  throw "CriticalLevel or WarningLevel have to be between 0-5"
}

$HashFilter = @{LogName = $LogName; Level= $Levels}

if ($ProviderName.Length -gt 0)
{
  $HashFilter.Add("ProviderName",$ProviderName)
}

if ($TimeIntervall -gt 0 ){
  $Date = (Get-Date).AddMinutes(-$TimeIntervall)
  $HashFilter.Add("StartTime",$Date)
}

$ThisEvent = Get-WinEvent -FilterHashtable $HashFilter -ErrorAction SilentlyContinue

if ($Pattern.Length -gt 0){
  $ThisEvent = $ThisEvent | Where-Object {$_.Message -like "*$($Pattern)*"}
}

$ThisEvent = $ThisEvent | Where-Object $additionalFilter

If ($null -ne $ThisEvent ){
  $ThisEvent
}

$CountCrits = 0
$CountWarns = 0
if ($CriticalLevel -le 5){
  $CountCrits=($ThisEvent | Where-Object{$_.Level -le $CriticalLevel}).count
}
if ($WarningLevel -le 5){
  $CountWarns=($ThisEvent | Where-Object{$_.Level -le $WarningLevel}).count
}

if($CountCrits -eq 0 -And $CountWarns -eq 0){
  "CheckLog OK"
  exit 0
}
elseIF ($CountCrits -gt 0) {
  "CheckLog CRITICAL: $CountCrits criticals"
  exit 2
}
else {
  "CheckLog WARNING: $CountWarns warnings"
  exit 1
}