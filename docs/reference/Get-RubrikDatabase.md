---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Get-RubrikDatabase.html
schema: 2.0.0
---

# Get-RubrikDatabase

## SYNOPSIS
Retrieves details on one or more databases known to a Rubrik cluster

## SYNTAX

### ID
```
Get-RubrikDatabase [-id] <String> [-Relic] [-SLA <String>] [-Instance <String>] [-Hostname <String>]
 [-ServerInstance <String>] [-InstanceID <String>] [-PrimaryClusterID <String>] [-SLAID <String>]
 [-DetailedObject] [-Server <String>] [-api <String>] [<CommonParameters>]
```

### Query
```
Get-RubrikDatabase [-Name <String>] [-Relic] [-SLA <String>] [-Instance <String>] [-Hostname <String>]
 [-ServerInstance <String>] [-InstanceID <String>] [-PrimaryClusterID <String>] [-SLAID <String>]
 [-DetailedObject] [-Server <String>] [-api <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-RubrikDatabase cmdlet is used to pull a detailed data set from a Rubrik cluster on any number of databases.
To narrow down the results, use the host and instance parameters to limit your search to a smaller group of objects.
Alternatively, supply the Rubrik database ID to return only one specific database.

## EXAMPLES

### EXAMPLE 1
```
Get-RubrikDatabase -Name 'DB1' -SLA Gold
```

This will return details on all databases named DB1 protected by the Gold SLA Domain on any known host or instance.

### EXAMPLE 2
```
Get-RubrikDatabase -Name 'DB1' -DetailedObject
```

This will return the Database object with all properties, including additional details such as snapshots taken of the database and recovery point date/time information.
Using this switch parameter negatively affects performance

### EXAMPLE 3
```
Get-RubrikDatabase -Name 'DB1' -Host 'Host1' -Instance 'MSSQLSERVER'
```

This will return details on a database named "DB1" living on an instance named "MSSQLSERVER" on the host named "Host1".

### EXAMPLE 4
```
Get-RubrikDatabase -Relic
```

This will return all removed databases that were formerly protected by Rubrik.

### EXAMPLE 5
```
Get-RubrikDatabase -Relic:$false
```

This will return all databases that are currently protected by Rubrik.

### EXAMPLE 6
```
Get-RubrikDatabase
```

This will return all databases that are currently or formerly protected by Rubrik.

### EXAMPLE 7
```
Get-RubrikDatabase -id 'MssqlDatabase:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee'
```

This will return details on a single database matching the Rubrik ID of "MssqlDatabase:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
Note that the database ID is globally unique and is often handy to know if tracking a specific database for longer workflows,
whereas some values are not unique (such as nearly all hosts having one or more databases named "model") and more difficult to track by name.

### EXAMPLE 8
```
Get-RubrikDatabase -InstanceID MssqlInstance:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
```

This will return details on a single SQL instance matching the Rubrik ID of "MssqlInstance:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"

## PARAMETERS

### -id
Rubrik's database id value

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Name of the database

```yaml
Type: String
Parameter Sets: Query
Aliases: Database

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Relic
Filter results to include only relic (removed) databases

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is_relic

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SLA
SLA Domain policy assigned to the database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Instance
Name of the database instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hostname
Name of the database host

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServerInstance
ServerInstance name (combined hostname\instancename)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceID
SQL InstanceID, used as a unique identifier

```yaml
Type: String
Parameter Sets: (All)
Aliases: instance_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryClusterID
Filter the summary information based on the primarycluster_id of the primary Rubrik cluster.
Use **_local** as the primary_cluster_id of the Rubrik cluster that is hosting the current REST API session.

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_cluster_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SLAID
SLA id value

```yaml
Type: String
Parameter Sets: (All)
Aliases: effective_sla_domain_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DetailedObject
DetailedObject will retrieved the detailed database object, the default behavior of the API is to only retrieve a subset of the database object unless we query directly by ID.
Using this parameter does affect performance as more data will be retrieved and more API-queries will be performed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Rubrik server IP or FQDN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $global:RubrikConnection.server
Accept pipeline input: False
Accept wildcard characters: False
```

### -api
API version

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $global:RubrikConnection.api
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by Chris Wahl for community usage
Twitter: @ChrisWahl
GitHub: chriswahl

## RELATED LINKS

[http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Get-RubrikDatabase.html](http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Get-RubrikDatabase.html)

