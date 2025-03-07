#Requires -Version 3
function Set-RubrikSLA
{
  <#  
      .SYNOPSIS
      Updates an existing Rubrik SLA Domain

      .DESCRIPTION
      The Set-RubrikSLA cmdlet will update an existing SLA Domain with specified parameters.

      .NOTES
      Written by Pierre-François Guglielmi for community usage
      Twitter: @pfguglielmi
      GitHub: pfguglielmi

      .LINK
      http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Set-RubrikSLA.html

      .EXAMPLE
      Set-RubrikSLA -id e4d121af-5611-496a-bb8d-57ba46443e94 -Name Gold -HourlyFrequency 12 -HourlyRetention 5
      This will update the SLA Domain named "Gold" to take a snapshot every 12 hours and keep those for 5 days.
      All other existing parameters will be reset.
      
      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -HourlyFrequency 4 -HourlyRetention 3
      This will update the SLA Domain named "Gold" to take a snapshot every 4 hours and keep those hourly snapshots for 3 days,
      while keeping all other existing parameters.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set RubrikSLA -AdvancedConfig -HourlyFrequency 4 -HourlyRetention 3 -WeeklyFrequency 1 -WeeklyRetention 4 -DayOfWeek Friday
      This will update the SLA Domain named "Gold" to take a snapshot every 4 hours and keep those hourly snapshots for 3 days
      while also keeping one snapshot per week for 4 weeks, created on Fridays. All other existing parameters will remain as they were.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -BackupStartHour 22 -BackupStartMinute 00 -BackupWindowDuration 8
      This will update the SLA Domain named "Gold" to take snapshots between 22:00PM and 6:00AM, while keeping all other existing parameters.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -FirstFullBackupStartHour 21 -FirstFullBackupStartMinute 30 -FirstFullBackupWindowDuration 57 -FirstFullBackupDay Friday
      This will update the SLA Domain named "Gold" to take the first full snapshot between Friday 21:30PM and Monday 6:30AM, while keeping all other existing parameters.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -Archival -ArchivalLocationId 64e27685-f1d9-4243-a2d4-78dbf5e8b43d -LocalRetention 30
      This will update the SLA Domain named "Gold" to keep data locally for 30 days before sending it to the specified archival location.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -InstantArchive
      This will update the SLA Domain named "Gold" to enable Instant Archive, assuming that archival was already configured. Ommitting this parameter will disable Instant Archive.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -Replication -ReplicationTargetId eeece05e-980f-4d32-953e-d236b65ff6fd -RemoteRetention 7
      This will update the SLA Domain named "Gold" to replicate snapshots to the specified cluster and keep them for 7 days remotely.

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -AdvancedConfig
      This will update the SLA Domain named "Gold" to only enable Advanced Configuration

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -Archival:$false
      This will update the SLA Domain named "Gold" to only disable archival

      .EXAMPLE
      Get-RubrikSLA -Name Gold | Set-RubrikSLA -Replication:$false
      This will update the SLA Domain named "Gold" to only disable replication
  #>

  [CmdletBinding(SupportsShouldProcess = $true,ConfirmImpact = 'High')]
  Param(
    # SLA id value from the Rubrik Cluster
    [Parameter(
      ValueFromPipelineByPropertyName = $true,
      Mandatory = $true )]
    [ValidateNotNullOrEmpty()]
    [String]$id,
    # SLA Domain Name
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [Alias('SLA')]
    [ValidateNotNullOrEmpty()]
    [String]$Name,
    # Hourly frequency to take snapshots
    [int]$HourlyFrequency,
    # Number of days or weeks to retain the hourly snapshots. For CDM versions prior to 5.0 this value must be set in days
    [int]$HourlyRetention,
    # Retention type to apply to hourly snapshots when advanced configuration is enabled. Does not apply to CDM versions prior to 5.0
    [ValidateSet('Daily','Weekly')]
    [String]$HourlyRetentionType='Daily',
    # Daily frequency to take snapshots
    [int]$DailyFrequency,
    # Number of days or weeks to retain the daily snapshots. For CDM versions prior to 5.0 this value must be set in days
    [int]$DailyRetention,
    # Retention type to apply to daily snapshots when advanced configuration is enabled. Does not apply to CDM versions prior to 5.0
    [ValidateSet('Daily','Weekly')]
    [String]$DailyRetentionType='Daily',
    # Weekly frequency to take snapshots
    [int]$WeeklyFrequency,
    # Number of weeks to retain the weekly snapshots
    [int]$WeeklyRetention,
    # Day of week for the weekly snapshots when advanced configuration is enabled. The default is Saturday. Does not apply to CDM versions prior to 5.0
    [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')]
    [String]$DayOfWeek='Saturday',
    # Monthly frequency to take snapshots
    [int]$MonthlyFrequency,
    # Number of months, quarters or years to retain the monthly backups. For CDM versions prior to 5.0, this value must be set in years
    [int]$MonthlyRetention,
    # Day of month for the monthly snapshots when advanced configuration is enabled. The default is the last day of the month. Does not apply to CDM versions prior to 5.0
    [ValidateSet('FirstDay','Fifteenth','LastDay')]
    [String]$DayOfMonth='LastDay',
    # Retention type to apply to monthly snapshots. Does not apply to CDM versions prior to 5.0
    [ValidateSet('Monthly','Quarterly','Yearly')]
    [String]$MonthlyRetentionType='Monthly',
    # Quarterly frequency to take snapshots. Does not apply to CDM versions prior to 5.0
    [int]$QuarterlyFrequency,
    # Number of quarters or years to retain the monthly snapshots. Does not apply to CDM versions prior to 5.0
    [int]$QuarterlyRetention,
    # Day of quarter for the quarterly snapshots when advanced configuration is enabled. The default is the last day of the quarter. Does not apply to CDM versions prior to 5.0
    [ValidateSet('FirstDay','LastDay')]
    [String]$DayOfQuarter='LastDay',
    # Month that starts the first quarter of the year for the quarterly snapshots when advanced configuration is enabled. The default is January. Does not apply to CDM versions prior to 5.0
    [ValidateSet('January','February','March','April','May','June','July','August','September','October','November','December')]
    [String]$FirstQuarterStartMonth='January',
    # Retention type to apply to quarterly snapshots. The default is Quarterly. Does not apply to CDM versions prior to 5.0
    [ValidateSet('Quarterly','Yearly')]
    [String]$QuarterlyRetentionType='Quarterly',
    # Yearly frequency to take snapshots
    [int]$YearlyFrequency,
    # Number of years to retain the yearly snapshots
    [int]$YearlyRetention,
    # Day of year for the yearly snapshots when advanced configuration is enabled. The default is the last day of the year. Does not apply to CDM versions prior to 5.0
    [ValidateSet('FirstDay','LastDay')]
    [String]$DayOfYear='LastDay',
    # Month that starts the first quarter of the year for the quarterly snapshots when advanced configuration is enabled. The default is January. Does not apply to CDM versions prior to 5.0
    [ValidateSet('January','February','March','April','May','June','July','August','September','October','November','December')]
    [String]$YearStartMonth='January',
    # Whether to turn advanced SLA configuration on or off. Does not apply to CDM versions prior to 5.0
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [alias('showAdvancedUi')]
    [switch]$AdvancedConfig,
    # Hour from which backups are allowed to run. Uses the 24-hour clock
    [ValidateRange(0,23)]
    [int]$BackupStartHour,
    # Minute of hour from which backups are allowed to run
    [ValidateRange(0,59)]
    [int]$BackupStartMinute,
    # Number of hours during which backups are allowed to run
    [ValidateRange(1,23)]
    [int]$BackupWindowDuration,
    # Hour from which the first full backup is allowed to run. Uses the 24-hour clock
    [ValidateRange(0,23)]
    [int]$FirstFullBackupStartHour,
    # Minute of hour from which the first full backup is allowed to run
    [ValidateRange(0,59)]
    [int]$FirstFullBackupStartMinute,
    [ValidateSet('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','1','2','3','4','5','6','7')]
    [String]$FirstFullBackupDay,
    # Number of hours during which the first full backup is allowed to run
    [int]$FirstFullBackupWindowDuration,
    # Whether to enable archival
    [switch]$Archival,
    # Time in days to keep backup data locally on the cluster.
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [alias('localRetentionLimit')]
    [int]$LocalRetention,
    # ID of the archival location
    [ValidateNotNullOrEmpty()]
    [String]$ArchivalLocationId,
    # Polaris Managed ID
    [ValidateNotNullOrEmpty()]
    [String]$PolarisID,
    # Whether to enable Instant Archive
    [switch]$InstantArchive,
    # Whether to enable replication
    [switch]$Replication,
    # ID of the replication target
    [ValidateNotNullOrEmpty()]
    [String]$ReplicationTargetId,
    # Time in days to keep data on the replication target.
    [int]$RemoteRetention,
    # Retrieves frequencies from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [object[]] $Frequencies,
    # Retrieves the advanced UI configuration parameters from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [alias('advancedUiConfig')]
    [object[]] $AdvancedFreq,    
    # Retrieves the allowed backup windows from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [alias('allowedBackupWindows')]
    [object[]] $BackupWindows,
    # Retrieves the allowed backup windows for the first full backup from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [alias('firstFullAllowedBackupWindows')]
    [object[]] $FirstFullBackupWindows,
    # Retrieves the archical specifications from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [object[]] $ArchivalSpecs,
    # Retrieves the replication specifications from Get-RubrikSLA via the pipeline
    [Parameter(
      ValueFromPipelineByPropertyName = $true)]
    [object[]] $ReplicationSpecs,
    # Rubrik server IP or FQDN
    [String]$Server = $global:RubrikConnection.server,
    # API version
    [String]$api = $global:RubrikConnection.api
  )

    Begin {

    # The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
    # If a command needs to be run with each iteration or pipeline input, place it in the Process section
    
    # Check to ensure that a session to the Rubrik cluster exists and load the needed header data for authentication
    Test-RubrikConnection
    
    # API data references the name of the function
    # For convenience, that name is saved here to $function
    $function = $MyInvocation.MyCommand.Name
        
    # Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
    Write-Verbose -Message "Gather API Data for $function"
    $resources = Get-RubrikAPIData -endpoint $function
    Write-Verbose -Message "Load API data for $($resources.Function)"
    Write-Verbose -Message "Description: $($resources.Description)"
  
  }

  Process {
    $uri = New-URIString -server $Server -endpoint ($resources.URI) -id $id
    $uri = Test-QueryParam -querykeys ($resources.Query.Keys) -parameters ((Get-Command $function).Parameters.Values) -uri $uri

    #region One-off
    Write-Verbose -Message 'Build the body'
    # Build the body for CDM versions 5 and above when the advanced SLA configuration is turned on
    if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
      $body = @{
        $resources.Body.name = $Name
        allowedBackupWindows = @()
        firstFullAllowedBackupWindows = @()
        archivalSpecs = @()
        replicationSpecs = @()
        showAdvancedUi = $true
        advancedUiConfig = @()
     }
    # Build the body for CDM versions 5 and above when the advanced SLA configuration is turned off
    } elseif ($uri.contains('v2')) {
      $body = @{
        $resources.Body.name = $Name
        allowedBackupWindows = @()
        firstFullAllowedBackupWindows = @()
        archivalSpecs = @()
        replicationSpecs = @()
        showAdvancedUi = $false
      }
    # Build the body for CDM versions prior to 5.0
    } else {
      $body = @{
        $resources.Body.name = $Name
        frequencies = @()
        allowedBackupWindows = @()
        firstFullAllowedBackupWindows =@()
        archivalSpecs = @()
        replicationSpecs = @()
      }
    }

    Write-Verbose -Message 'Setting ParamValidation flag to $false to check if user set any params'
    [bool]$ParamValidation = $false

    # Retrieve snapshot frequencies from pipeline for CDM versions 5 and above when advanced SLA configuration is turned on
    if (($uri.contains('v2')) -and ($Frequencies) -and ($AdvancedConfig -eq $true)) {
      $Frequencies[0].psobject.properties.name | ForEach-Object {
        if ($_ -eq 'Hourly') {
          if (($Frequencies.$_.frequency) -and (-not $HourlyFrequency)) {
            $HourlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $HourlyRetention)) {
            # Convert hourly retention in days when the value retrieved from pipeline is in hours because advanced SLA configuration was previously turned off
            if ($AdvancedFreq.Count -eq 0) {
              $HourlyRetention = ($Frequencies.$_.retention) / 24
            } else {
              $HourlyRetention = $Frequencies.$_.retention
            }
          }
        } elseif ($_ -eq 'Daily') {
          if (($Frequencies.$_.frequency) -and (-not $DailyFrequency)) {
            $DailyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $DailyRetention)) {
            $DailyRetention = $Frequencies.$_.retention
          }
        } elseif ($_ -eq 'Weekly') {
          if (($Frequencies.$_.frequency) -and (-not $WeeklyFrequency)) {
            $WeeklyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $WeeklyRetention)) {
            $WeeklyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.dayOfWeek) -and (-not $PSBoundParameters.ContainsKey('dayOfWeek'))) {
            $DayOfWeek = $Frequencies.$_.dayOfWeek
          }
        } elseif ($_ -eq 'Monthly') {
          if (($Frequencies.$_.frequency) -and (-not $MonthlyFrequency)) {
            $MonthlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $MonthlyRetention)) {
            $MonthlyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.dayOfMonth) -and (-not $PSBoundParameters.ContainsKey('dayOfMonth'))) {
            $DayofMonth = $Frequencies.$_.dayOfMonth
          }
        } elseif ($_ -eq 'Quarterly') {
          if (($Frequencies.$_.frequency) -and (-not $QuarterlyFrequency)) {
            $QuarterlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $QuarterlyRetention)) {
            $QuarterlyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.firstQuarterStartMonth) -and (-not $PSBoundParameters.ContainsKey('firstQuarterStartMonth'))) {
            $FirstQuarterStartMonth = $Frequencies.$_.firstQuarterStartMonth
          }
          if (($Frequencies.$_.dayOfQuarter) -and (-not $PSBoundParameters.ContainsKey('dayOfQuarter'))) {
            $DayOfQuarter = $Frequencies.$_.dayOfQuarter
          }
        } elseif ($_ -eq 'Yearly') {
          if (($Frequencies.$_.frequency) -and (-not $YearlyFrequency)) {
            $YearlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $YearlyRetention)) {
            $YearlyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.yearStartMonth) -and (-not $PSBoundParameters.ContainsKey('yearStartMonth'))) {
            $YearStartMonth = $Frequencies.$_.yearStartMonth
          }
          if (($Frequencies.$_.dayOfYear) -and (-not $PSBoundParameters.ContainsKey('dayOfYear'))) {
            $DayOfYear = $Frequencies.$_.dayOfYear
          }
        }
      }
    # Retrieve snapshot frequencies from pipeline for CDM versions 5 and above when advanced SLA configuration is turned off
    } elseif ($uri.contains('v2') -and ($Frequencies)) {
      $Frequencies[0].psobject.properties.name | ForEach-Object {
        if ($_ -eq 'Hourly') {
          if (($Frequencies.$_.frequency) -and (-not $HourlyFrequency)) {
            $HourlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $HourlyRetention)) {
            # Convert hourly retention in hours when the value retrieved from pipeline is in days because advanced SLA configuration was previously turned on
            if ($AdvancedFreq.Count -eq 0) {
              $HourlyRetention = $Frequencies.$_.retention
            } else {
              $HourlyRetention = ($Frequencies.$_.retention) * 24
            }
          # Convert hourly retention in hours when the value set explicitly with the parameter is in days, like in the UI
          } elseif ($HourlyRetention) {
            $HourlyRetention = ($HourlyRetention * 24)
          }
        } elseif ($_ -eq 'Daily') {
          if (($Frequencies.$_.frequency) -and (-not $DailyFrequency)) {
            $DailyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $DailyRetention)) {
            $DailyRetention = $Frequencies.$_.retention
          }
        } elseif ($_ -eq 'Monthly') {
          if (($Frequencies.$_.frequency) -and (-not $MonthlyFrequency)) {
            $MonthlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $MonthlyRetention)) {
            $MonthlyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.dayOfMonth) -and (-not $PSBoundParameters.ContainsKey('dayOfMonth'))) {
            $DayofMonth = $Frequencies.$_.dayOfMonth
          }
        } elseif ($_ -eq 'Yearly') {
          if (($Frequencies.$_.frequency) -and (-not $YearlyFrequency)) {
            $YearlyFrequency = $Frequencies.$_.frequency
          }
          if (($Frequencies.$_.retention) -and (-not $YearlyRetention)) {
            $YearlyRetention = $Frequencies.$_.retention
          }
          if (($Frequencies.$_.yearStartMonth) -and (-not $PSBoundParameters.ContainsKey('yearStartMonth'))) {
            $YearStartMonth = $Frequencies.$_.yearStartMonth
          }
          if (($Frequencies.$_.dayOfYear) -and (-not $PSBoundParameters.ContainsKey('dayOfYear'))) {
            $DayOfYear = $Frequencies.$_.dayOfYear
          }
        }
      }
    # Retrieve snapshot frequencies from pipeline for CDM versions prior to 5.0
    } elseif ($Frequencies) {
      $Frequencies | ForEach-Object {
        if ($_.timeUnit -eq 'Hourly') {
          if (($_.frequency) -and (-not $HourlyFrequency)) {
            $HourlyFrequency = $_.frequency
          }
          if (($_.retention) -and (-not $HourlyRetention)) {
            $HourlyRetention = $_.retention
          # Convert hourly retention in hours when the parameter is explicitly specified because the default unit is days, like in the UI
          } elseif ($HourlyRetention) {
            $HourlyRetention = $HourlyRetention * 24
          }
        } elseif ($_.timeUnit -eq 'Daily') {
          if (($_.frequency) -and (-not $DailyFrequency)) {
            $DailyFrequency = $_.frequency
          }
          if (($_.retention) -and (-not $DailyRetention)) {
            $DailyRetention = $_.retention
          }
        } elseif ($_.timeUnit -eq 'Monthly') {
          if (($_.frequency) -and (-not $MonthlyFrequency)) {
            $MonthlyFrequency = $_.frequency
          }
          if (($_.retention) -and (-not $MonthlyRetention)) {
            $MonthlyRetention = $_.retention
          # Convert monthly retention in months when the parameter is explicitly specified because the default unit is in years, like in the UI
          } elseif ($MonthlyRetention) {
            $MonthlyRetention = $MonthlyRetention * 12
          }
        } elseif ($_.timeUnit -eq 'Yearly') {
          if (($_.frequency) -and (-not $YearlyFrequency)) {
            $YearlyFrequency = $_.frequency
          }
          if (($_.retention) -and (-not $YearlyRetention)) {
            $YearlyRetention = $_.retention
          }
        }
      }
      # Ensure the hourly retention set via the cli parameter is converted to hours if frequencies were retrieved from the pipeline but hourly retention was empty
      if (($Frequencies.timeUnit -notcontains 'Hourly') -and $HourlyRetention) {
        $HourlyRetention = $HourlyRetention * 24
      }
      # Ensure the monthly retention set via the cli parameter is converted to months if frequencies were retrieved from the pipeline but monthly retention was empty
      if (($Frequencies.timeUnit -notcontains 'Monthly') -and $MonthlyRetention) {
        $MonthlyRetention = $MonthlyRetention * 12
      }
    } elseif ($HourlyRetention -or $MonthlyRetention) {
      # Ensure the hourly retention set via the cli parameter is converted to hours for CDM versions prior to 5.0, and 5.x when advanced SLA configuration is disabled
      if ($HourlyRetention -and $PSBoundParameters.ContainsKey('AdvancedConfig') -and ($AdvancedConfig -eq $false)) {
        $HourlyRetention = $HourlyRetention * 24
        }
      # Ensure the monthly retention set via the cli parameter is converted to months for CDM versions prior to 5.0
      if ($MonthlyRetention -and (-not ($uri.contains('v2')))) {
        $MonthlyRetention = $MonthlyRetention * 12
      }
    }

    # Retrieve advanced retention unit parameters from pipeline for CDM 5.0
    if ($AdvancedFreq) {
      $AdvancedFreq | ForEach-Object {
        if (($_.timeUnit -eq 'Hourly') -and ($_.retentionType) -and (-not $PSBoundParameters.ContainsKey('HourlyRetentionType'))) {
          $HourlyRetentionType = $_.retentionType
        } elseif (($_.timeUnit -eq 'Daily') -and ($_.retentionType) -and (-not $PSBoundParameters.ContainsKey('DailyRetentionType'))) {
          $DailyRetentionType = $_.retentionType
        } elseif (($_.timeUnit -eq 'Monthly') -and ($_.retentionType) -and (-not $PSBoundParameters.ContainsKey('MonthlyRetentionType'))) {
          $MonthlyRetentionType = $_.retentionType
        } elseif (($_.timeUnit -eq 'Quarterly') -and ($_.retentionType) -and (-not $PSBoundParameters.ContainsKey('QuarterlyRetentionType'))) {
          $QuarterlyRetentionType = $_.retentionType
        }
      }
    }
    
    # Retrieve the allowed backup window settings from pipeline
    if ($BackupWindows) {
      if (($BackupWindows.startTimeAttributes.hour -ge 0) -and (-not $PSBoundParameters.ContainsKey('BackupStartHour'))) {
        $BackupStartHour = $BackupWindows.startTimeAttributes.hour
      }
      if (($BackupWindows.startTimeAttributes.minutes -ge 0) -and (-not $PSBoundParameters.ContainsKey('BackupStartMinute'))) {
        $BackupStartMinute = $BackupWindows.startTimeAttributes.minutes
      }
      if (($BackupWindows.durationInHours) -and (-not $BackupWindowDuration)) {
        $BackupWindowDuration = $BackupWindows.durationInHours
      }
    }

    # Retrieve the allowed backup window settings for the first full from pipeline
    if ($FirstFullBackupWindows) {
      if (($FirstFullBackupWindows.startTimeAttributes.hour -ge 0) -and (-not $PSBoundParameters.ContainsKey('FirstFullBackupStartHour'))) {
        $FirstFullBackupStartHour = $FirstFullBackupWindows.startTimeAttributes.hour
      }
      if (($FirstFullBackupWindows.startTimeAttributes.minutes -ge 0) -and (-not $PSBoundParameters.ContainsKey('FirstFullBackupStartMinute'))) {
        $FirstFullBackupStartMinute = $FirstFullBackupWindows.startTimeAttributes.minutes
      }
      if (($FirstFullBackupWindows.startTimeAttributes.dayOfWeek) -and (-not $PSBoundParameters.ContainsKey('FirstFullBackupDay'))) {
        [int]$FirstFullBackupDay = $FirstFullBackupWindows.startTimeAttributes.dayOfWeek
      }
      if (($FirstFullBackupWindows.durationInHours) -and (-not $FirstFullBackupWindowDuration)) {
        $FirstFullBackupWindowDuration = $FirstFullBackupWindows.durationInHours
      }
    }

    # Retrieve the archival specifications from pipeline
    if ($ArchivalSpecs) {
      if ($ArchivalSpecs.locationId -and (-not $ArchivalLocationId)) {
        $ArchivalLocationId = $ArchivalSpecs.locationId
      }
      if ($ArchivalSpecs.polarisManagedId -and (-not $PolarisID)) {
        $PolarisID = $ArchivalSpecs.polarisManagedId
      }
      if (-not ($PSBoundParameters.ContainsKey('Archival'))) {
        $Archival = $true
      }
    }
    # If LocalRetention is set directly, convert its value in seconds
    if ($LocalRetention -lt 86400) {
      $LocalRetention = $LocalRetention * 86400
    }

    # Retrieve the replication specifications from pipeline
    if ($ReplicationSpecs) {
      if ($ReplicationSpecs.locationId -and (-not $ReplicationTargetId)) {
        $ReplicationTargetId = $ReplicationSpecs.locationId
      }
      if ($ReplicationSpecs.retentionLimit -and (-not $RemoteRetention)) {
        $RemoteRetention = $ReplicationSpecs.retentionLimit
      }
      if (-not ($PSBoundParameters.ContainsKey('Replication'))) {
        $Replication = $true
      }
    }
    # If RemoteRetention is set directly, convert its value in seconds
    if ($RemoteRetention -lt 86400) {
      $RemoteRetention = $RemoteRetention * 86400
    }

    # Populate the body with the allowed backup window settings
    if (($BackupStartHour -ge 0) -and ($BackupStartMinute -ge 0) -and $BackupWindowDuration) {
      $body.allowedBackupWindows += @{
          startTimeAttributes = @{hour=$BackupStartHour;minutes=$BackupStartMinute};
          durationInHours = $BackupWindowDuration
      }
    }

    # Populate the body with the allowed backup window settings fort the first full
    if (($FirstFullBackupStartHour -ge 0) -and ($FirstFullBackupStartMinute -ge 0) -and $FirstFullBackupDay -and $FirstFullBackupWindowDuration) {
      if ($FirstFullBackupDay -eq 'Sunday') {
        [int]$FirstFullBackupDay = 1
      } elseif ($FirstFullBackupDay -eq 'Monday') {
        [int]$FirstFullBackupDay = 2
      } elseif ($FirstFullBackupDay -eq 'Tuesday') {
        [int]$FirstFullBackupDay = 3
      } elseif ($FirstFullBackupDay -eq 'Wednesday') {
        [int]$FirstFullBackupDay = 4
      } elseif ($FirstFullBackupDay -eq 'Thursday') {
        [int]$FirstFullBackupDay = 5
      } elseif ($FirstFullBackupDay -eq 'Friday') {
        [int]$FirstFullBackupDay = 6
      } elseif ($FirstFullBackupDay -eq 'Saturday') {
        [int]$FirstFullBackupDay = 7
      }          
      $body.FirstFullAllowedBackupWindows += @{
          startTimeAttributes = @{hour=$FirstFullBackupStartHour;minutes=$FirstFullBackupStartMinute;dayOfWeek=$FirstFullBackupDay};
          durationInHours = $FirstFullBackupWindowDuration
      }
    }

    # Populate the body with archival specifications
    if ($uri.contains('v2') -and $Archival) {
      if ($ArchivalLocationId -and $PolarisID -and ($InstantArchive.IsPresent -eq $true)) {
        $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=1;polarisManagedId=$PolarisID}
        $body.localRetentionLimit = $LocalRetention
      } elseif ($ArchivalLocationId -and ($InstantArchive.IsPresent -eq $true)) {
        $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=1}
        $body.localRetentionLimit = $LocalRetention
      } elseif ($ArchivalLocationId -and $PolarisID -and ($InstantArchive.IsPresent -eq $false)) {
        $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=$LocalRetention;polarisManagedId=$PolarisID}
        $body.localRetentionLimit = $LocalRetention
      } elseif ($ArchivalLocationId -and ($InstantArchive.IsPresent -eq $false)) {
        $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=$LocalRetention}
        $body.localRetentionLimit = $LocalRetention
      }
    } elseif ($Archival) {
        if ($ArchivalLocationId -and ($InstantArchive.IsPresent -eq $true)) {
          $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=1}
          $body.localRetentionLimit = $LocalRetention
        } elseif ($ArchivalLocationId -and ($InstantArchive.IsPresent -eq $false)) {
          $body.archivalSpecs += @{locationId=$ArchivalLocationId;archivalThreshold=$LocalRetention}
          $body.localRetentionLimit = $LocalRetention
        }
    }

    # Populate the body with replication specifications
    if ($Replication -and $ReplicationTargetId -and $RemoteRetention) {
      $body.replicationSpecs += @{locationId=$ReplicationTargetId;retentionLimit=$RemoteRetention}
    }

    # Populate the body with frequencies according to the version of CDM and to whether the advanced SLA configuration is enabled in 5.x
    if ($HourlyFrequency -and $HourlyRetention) {
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'hourly'=@{frequency=$HourlyFrequency;retention=$HourlyRetention}}
        $body.advancedUiConfig += @{timeUnit='Hourly';retentionType=$HourlyRetentionType}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'hourly'=@{frequency=$HourlyFrequency;retention=$HourlyRetention}}
      } else {
        $body.frequencies += @{
          $resources.Body.frequencies.timeUnit = 'Hourly'
          $resources.Body.frequencies.frequency = $HourlyFrequency
          $resources.Body.frequencies.retention = $HourlyRetention
        }
      }
      [bool]$ParamValidation = $true
    }
    
    if ($DailyFrequency -and $DailyRetention) {
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'daily'=@{frequency=$DailyFrequency;retention=$DailyRetention}}
        $body.advancedUiConfig += @{timeUnit='Daily';retentionType=$DailyRetentionType}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'daily'=@{frequency=$DailyFrequency;retention=$DailyRetention}}
      } else { 
        $body.frequencies += @{
          $resources.Body.frequencies.timeUnit = 'Daily'
          $resources.Body.frequencies.frequency = $DailyFrequency
          $resources.Body.frequencies.retention = $DailyRetention
        }
      }
      [bool]$ParamValidation = $true
    }    

    if ($WeeklyFrequency -and $WeeklyRetention) { 
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'weekly'=@{frequency=$WeeklyFrequency;retention=$WeeklyRetention;dayOfWeek=$DayOfWeek}}
        $body.advancedUiConfig += @{timeUnit='Weekly';retentionType='Weekly'}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'weekly'=@{frequency=$WeeklyFrequency;retention=$WeeklyRetention;dayOfWeek=$DayOfWeek}}
      } else {
        Write-Warning -Message 'Weekly SLA configurations are not supported in this version of Rubrik CDM.'
        $body.frequencies += @{
          $resources.Body.frequencies.timeUnit = 'Weekly'
          $resources.Body.frequencies.frequency = $WeeklyFrequency
          $resources.Body.frequencies.retention = $WeeklyRetention
        }
      }
      [bool]$ParamValidation = $true
    }    

    if ($MonthlyFrequency -and $MonthlyRetention) {
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'monthly'=@{frequency=$MonthlyFrequency;retention=$MonthlyRetention;dayOfMonth=$DayOfMonth}}
        $body.advancedUiConfig += @{timeUnit='Monthly';retentionType=$MonthlyRetentionType}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'monthly'=@{frequency=$MonthlyFrequency;retention=$MonthlyRetention;dayOfMonth=$DayOfMonth}}
      } else { 
        $body.frequencies += @{
          $resources.Body.frequencies.timeUnit = 'Monthly'
          $resources.Body.frequencies.frequency = $MonthlyFrequency
          $resources.Body.frequencies.retention = $MonthlyRetention
        }
      }
      [bool]$ParamValidation = $true
    }  

    if ($QuarterlyFrequency -and $QuarterlyRetention) {
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'quarterly'=@{frequency=$QuarterlyFrequency;retention=$QuarterlyRetention;firstQuarterStartMonth=$FirstQuarterStartMonth;dayOfQuarter=$DayOfQuarter}}
        $body.advancedUiConfig += @{timeUnit='Quarterly';retentionType=$QuarterlyRetentionType}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'quarterly'=@{frequency=$QuarterlyFrequency;retention=$QuarterlyRetention;firstQuarterStartMonth=$FirstQuarterStartMonth;dayOfQuarter=$DayOfQuarter}}
      } else { 
        Write-Warning -Message 'Quarterly SLA configurations are not supported in this version of Rubrik CDM.'
      }
      [bool]$ParamValidation = $true
    }  

    if ($YearlyFrequency -and $YearlyRetention) {
      if (($uri.contains('v2')) -and ($AdvancedConfig -eq $true)) {
        $body.frequencies += @{'yearly'=@{frequency=$YearlyFrequency;retention=$YearlyRetention;yearStartMonth=$YearStartMonth;dayOfYear=$DayOfYear}}
        $body.advancedUiConfig += @{timeUnit='Yearly';retentionType='Yearly'}
      } elseif ($uri.contains('v2')) {
        $body.frequencies += @{'yearly'=@{frequency=$YearlyFrequency;retention=$YearlyRetention;yearStartMonth=$YearStartMonth;dayOfYear=$DayOfYear}}
      } else {  
          $body.frequencies += @{
          $resources.Body.frequencies.timeUnit = 'Yearly'
          $resources.Body.frequencies.frequency = $YearlyFrequency
          $resources.Body.frequencies.retention = $YearlyRetention
        }
      }
      [bool]$ParamValidation = $true
    } 
    
    Write-Verbose -Message 'Checking for the $ParamValidation flag' 
    if ($ParamValidation -ne $true) 
    {
      throw 'You did not specify any frequency and retention values'
    }    
    
    $body = ConvertTo-Json $body -Depth 10
    
    # Remove bearer or basic auth info from verbose information
    Write-Verbose -Message "Header = $(
        (ConvertTo-Json -InputObject $header -Compress) -replace '(Bearer\s.*?")|(Basic\s.*?")'
      )"
    Write-Verbose -Message "Body = $body"
    #endregion

    $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
    $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
    $result = Test-FilterObject -filter ($resources.Filter) -result $result

    return $result

  } # End of process
} # End of function