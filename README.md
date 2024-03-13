# sensu-windows-powershell-checks
Collection of Windows Powershell checks for Sensu

### check-windows-http.ps1

#### Help
```
> check-windows-http.ps1 -?
NAME
    check-windows-http.ps1

SYNOPSIS
    This plugin checks availability of url provided as param. Optionally checks if substring exists in url content

SYNTAX
    check-windows-http.ps1 [-CheckAddress] <String> [[-ContentSubstring] <String>] [<CommonParameters>]
```

#### Param 1: CheckAddress
Required. Use valid http or https URL ex:  `https://sensu.io`

#### Param 2: ContentSubString
Optional. Substring to match inside returned URL content.

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-http.ps1  https://sensu.io monitoring
```

### check-windows-disk.ps1

#### Help
```
> check-windows-disk.ps1 -?
NAME
    check-windows-disk.ps1

SYNOPSIS
    This plugin collects the Disk Usage and and compares against the WARNING and CRITICAL thresholds.


SYNTAX
    check-windows-disk.ps1 [-WARNING] <Int32> [-CRITICAL] <Int32> [[-IGNORE] <String>] [<CommonParameters>]


DESCRIPTION
    This plugin collects the Disk Usage and and compares against the WARNING and CRITICAL thresholds.

```

#### Param 1: Warning
    Optional. Warning disk usage percentage threshold.
    Example -Warning 90

#### Param 2: Critical
    Optional. Critical disk usage percentage threshold.
    Example -Critical 95

#### Param 3: Ignore
    Optional. DeviceID regular expression to ignore.

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-disk.ps1 90 95
```

### check-windows-event-log.ps1

#### Help
```
> check-windows-event-log.ps1 -?

NAME
    check-windows-event-log.ps1

SYNOPSIS
    Returns all occurances of events based on given filter parameter in a event log

SYNTAX
    check-windows-event-log.ps1 [-LogName] <String> [[-ProviderName] <String>]
    [[-Pattern] <String>] [[-TimeIntervall] <Int32>] [[-additionalFilter] <ScriptBlock>]
    [[-CriticalLevel] <Int32>] [[-WarningLevel] <Int32>] [<CommonParameters>]

DESCRIPTION
    Checks Event log for pattern and returns the number criticals and warnings that match that pattern.
```

#### Param 1: LogName
    Required. The name of the log file. Allows wildcard.
    Example -LogName Application

#### Paran 2: ProviderName
    Optional. Filter on Providername. Allows wildcard.

#### Param 3: Pattern
    Required. The pattern you want to search for.
    Example -LogName Application -Pattern error

#### Param 4 TimeIntervall
    Optional. Set filter on Startdate depending on the time when the script runs in minutes.
    Example -LogName Application -TimeIntervall 2

#### Param 5 additionalFilter
    Optional. Add custom "where" filter as a scriptblock
    Example -LogName Application -additionalFilter {$_.Id -eq 1234}

#### Param 6: CriticalLevel
    Optional. Integer Event Log Level to trigger Critical return status. Defaults to 2 = Error. Set to greater than 5 to disable. Error if both CriticalLevel and WarningLevel are disabled!
    Example -LogName Application -Pattern error -CriticalLevel 2

#### Param 7: WarningLevel
    Optional. Integer Event Log Level to trigger Warning return status.  Defaults to 3 = Warning. Set to greater than 5 to disable. Error if both CriticalLevel and WarningLevel are disabled!
    Example -LogName Application -Pattern error -WarningLevel 3

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-event-log.ps1 -LogName Application -Pattern error
```

### check-windows-disk-writeable.ps1

#### Help
```
> check-windows-disk-writeable.ps1 -?
NAME
    check-windows-disk-writeable.ps1

SYNOPSIS
    This plugin collects the mounted logical disks and tests they are writeable.


SYNTAX
    check-windows-disk-writeable.ps1 [[-DriveType] <String>] [[-Ignore] <String>]
      [[-TestFile] <String>] [<CommonParameters>]


DESCRIPTION
    This plugin collects the mounted logical disks and tests they are writeable.

```

#### Param 1: DriveType
    Optional. DriveType,
    see available options at https://msdn.microsoft.com/en-us/library/windows/desktop/aa364939(v=vs.85).aspx
    Specify multiple values as a comma separated string, e.g. "3,5"
#### Param 2: Ignore
    Optional. Disk letters to ignore
    Specify multiple values as a comma separated string, e.g. "C,D"
#### Param 3: TestFile
    Optional. Test file to create on each disk to test it is writeable

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-disk-writeable.ps1 -DriveType '3,5' -Ignore 'A,B' -TestFile '\test.txt'
```

### check-windows-directory.ps1

#### Help
```
> check-windows-disk-directory.ps1 -?
NAME
    check-windows-directory.ps1

SYNOPSIS
    Checks if  directory exist


SYNTAX
    check-windows-directory.ps1 [-Dir]
    <String> [<CommonParameters>]


DESCRIPTION
    Checks if directory exist

```

#### Param 1: Dir
    Required. The name of the directory.
    Example -Dir C:\Users\dir


#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-directory.ps1 -Dir C:\Users\dir
```

### check-windows-ram.ps1

#### Help
```
> check-windows-ram.ps1 -?
NAME
    check-windows-ram.ps1

SYNOPSIS
    This plugin collects the RAM Usage and compares against the WARNING and CRITICAL thresholds.

SYNTAX
    check-windows-ram.ps1 [-WARNING]
    <Int32> [-CRITICAL] <Int32> [<CommonParameters>]

```

#### Param 1: Warning
    Optional. Warning ram usage percentage threshold

#### Param 1: Critical
    Optional. Critical rame usage percentage threshold


#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-ram.ps1 90 95
```

### check-windows-process.ps1

#### Help
```
> check-windows-process.ps1 -?
NAME
    check-windows-process.ps1

SYNOPSIS
    This plugin checks whether a User-inputted process is running with too many or too few instances.


SYNTAX
    check-windows-process.ps1 [-ProcessName] <String> [-WarnUnder <Int>] [-CritUnder <Int>] [-WarnOver <Int>] [-CritOver <Int>] [<CommonParameters>]

```

#### Param 1: ProcessName
    Required. Name of user process to check

#### Param 2:
    Optional.  Warn if matching process count is over specified amount. Set to 0 to disable

#### Param 3: CritOver
    Optional.  Crit if matching process count is over specified amount. Set to 0 to disable

#### Param 4: WarnUnder
    Optional.  Warn if matching process count is under specified amount. Set to 0 to disable

#### Param 5: CritUnder
    Optional.  Crit if matching process count is under specified amount. Set to 0 to disable

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-process.ps1 powershell
```

### check-windows-cpu-load.ps1

#### Help
```
> check-windows-cpu-load.ps1 -?
NAME
    check-windows-cpu-load.ps1

SYNOPSIS
    This plugin collects the CPU Usage and compares against the WARNING and CRITICAL thresholds.


SYNTAX
    check-windows-cpu-load.ps1 [-WARNING]
    <Int32> [-CRITICAL] <Int32> [<CommonParameters>]

```

#### Param 1: Warning
    Optional. Warning cpu load percentage threshold

#### Param 1: Critical
    Optional. Critical cpu load percentage threshold


#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-cpu-load.ps1 90 95
```


### check-windows-processor-queue-length.ps1

#### Help
```
> check-windows-processor-queue-length.ps1 -?
NAME
    check-windows-processor-queue-length.ps1

SYNOPSIS
    This plugin collects the Processor Queue Length and compares against the WARNING and CRITICAL thresholds.


SYNTAX
    check-windows-processor-queue-length.ps1 [-WARNING]
    <Int32> [-CRITICAL] <Int32> [<CommonParameters>]

```

#### Param 1: Warning
    Optional. Warning processor queue length threshold

#### Param 1: Critical
    Optional. Critical processor queue length threshold


#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-processor-queue-length.ps1 5 10
```

### check-windows-pagefile.ps1

#### Help
```
> check-windows-pagefile.ps1 -?
NAME
    check-windows-pagefile.ps1

SYNOPSIS
    This plugin collects the Pagefile Usage and compares against the WARNING and CRITICAL thresholds.

SYNTAX
    check-windows-pagefile.ps1 [-WARNING]
    <Int32> [-CRITICAL] <Int32> [<CommonParameters>]

```

#### Param 1: Warning
    Optional. Warning pagefile usage percentage threshold

#### Param 1: Critical
    Optional. Critical pagefile usage percentage threshold


#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-pagefile.ps1 75 85
```

### check-windows-log.ps1

#### Help
```
> check-windows-log.ps1 -?

NAME
    check-windows-log.ps1

SYNOPSIS
    Returns all occurances of pattern in log file

SYNTAX
    check-windows-log.ps1 [-LogPath] <String> [-Pattern] <String> [<CommonParameters>]

DESCRIPTION
    Checks log file for pattern and returns line(s) containing pattern

```

#### Param 1: LogPath
    Required. The path of the log file.
    Example -LogPath example.log

#### Param 2: Pattern
    Required. The pattern you want to search for.
    Example -LogPath example.log -Pattern error

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-log.ps1 -LogPath example.log -Pattern error
```

### check-windows-logstream.ps1

#### Help
```
> check-windows-log.ps1 -?

NAME
    check-windows-log.ps1

SYNOPSIS
    Returns all occurrences of pattern in log file, using a StreamReader

    This check only loads a single line of text at a time into the memory.
    This makes the script way less memory intense, and faster on large logs.
    It also keeps track of where the log was last read, to not re-read logs.

SYNTAX
    check-windows-log.ps1 [-LogPath] <String> [-Pattern] <String> [[-MetadataFile] <string>] [-Regex] [-CaseSensitive] [<CommonParameters>]

DESCRIPTION
    Checks log file for pattern and returns the number of times the pattern was found.

```

#### Param 1: LogPath
    Required. The path of the log file.
    Example -LogPath example.log

#### Param 2: Pattern
    Required. The pattern you want to search for.
    Example -LogPath example.log -Pattern error

#### Param 3: MetadataFile
    Optional. The metadata file where to store read bytes. Must be unique per check
    Example -MetadataFile C:\Program Data\sensu\cache\my_file.txt"

#### Param 4: Regex
    Optional. Indicates that the pattern (-Pattern) is a regex pattern
    Example -Regex

#### Param 4: CaseSenstive
    Optional. Indicates that the pattern (-Pattern) is a case sensitive
    Example -CaseSenstive

#### Asset command usage
```
powershell.exe -file check-windows-logstream.ps1 -LogPath C:\ProgramData\Logs\example2.log -Pattern "Exception\[\w*\]$" -Regex
```


### check-windows-service.ps1

#### Help
```
> check-windows-service.ps1 -?
NAME
    check-windows-service.ps1

SYNOPSIS
    This plugin checks whether a User-inputted Windows service is running or not.


SYNTAX
    check-windows-service.ps1 [-ServiceName] <String> [<CommonParameters>]

```

#### Param 1: ServiceName
    Required.  Service name to check.

#### Asset command usage
```
Powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -NoLogo -Command check-windows-service.ps1 sshd
```
