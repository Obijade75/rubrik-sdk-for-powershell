# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## Types of changes

* **Added** for new features.
* **Changed** for changes in existing functionality.
* **Deprecated** for soon-to-be removed features.
* **Removed** for now removed features.
* **Fixed** for any bug fixes.
* **Security** in case of vulnerabilities.

## [Unreleased]

## 2019-10-17

### Changed [Added Nutanix/Hyper-V support to New-RubrikSnapshot]
* Modified URI list in Get-RubrikAPIData for New-RubrikSnapshot to include support for Nutanix and Hyper-V
* Addresses [Issue 466](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/466)

## 2019-10-11

### Changed [Added documentation to all private functions]
* Added documentation in all private functions including synopsis, description, parameter help and examples where appropriate
* Addresses [Issue 378](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/378)

## 2019-10-08

### Added [cmdlets to add and remove organizations]
* Added Add-RubrikOrganization and Remove-RubrikOrganization to add and remove organizations, and associated unit tests
* Addresses [Issue 338](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/338)

## 2019-10-01

### Added [cmdlets to set and delete user roles and permissions]

* Added Get-RubrikUserRole and Set-RubrikUserRole in order to get and configure user roles and permissions.
* Added private function Update-RubrikuserRole to handle the addition and removal of permissions for the various roles.
* Addresses [Issue 108](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/108)

## 2019-09-26

### Added initial support for VMware vCloud Director (vCD) API endpoints in CDM

* Added cmdlets `Update-RubrikVCD`, `Set-RubrikVCD`, `Restore-RubrikVApp`, `Protect-RubrikVApp`, `Get-RubrikVcdTemplateExportOptions`, `Get-RubrikVCD`, `Get-RubrikVappSnapshot`, `RubrikVAppRecoverOptions`, `Get-RubrikVAppExportOptions`, `Get-RubrikVApp`, `Export-RubrikVCDTemplate`, `Export-RubrikVApp` and related tests as requested in [Issue 273](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/273)
* Updated `Get-RubrikSnapshot` to support vCD vApps
* Misc bug fixes and typos corrected

## 2019-09-24

### Added [Private Function to apply TypeName information to objects]

* Functionality created in order to make display of return results for certain objects more user friendly.
* Added private function Set-ObjectTypeName which applies a given TypeName definition to cmdlet results.
* Added ObjectTName parameter within Get-RubrikAPIData to the listed objects below
* Added ps1xml files to a newly created ObjectDefinitions folder definining the listed objects below
* Imported all ps1xml files from within the psd1 manifest for the listed objects below
* TypeName format files created for Rubrik.APIToken, Rubrik.AvailabilityGroup, Rubrik.Event, Rubrik.Fileset, Rubrik.FilesetTemplate, Rubrik.Host, Rubrik.HyperVVM, Rubrik.LDAP, Rubrik.LogShipping, Rubrik.ManagedVolume, Rubrik.MSSQLDatabase, Rubrik.MSSQLDatabaseFiles, Rubrik.MSSQLDatabaseMount, Rubrik.NASShare, Rubrik.NutanixVM, Rubrik.OracleDatabase, Rubrik.Report, RubrikSLADomain, Rubrik.SLADomainv1, Rubrik.UnmanagedObject, Rubrik.User, Rubrik.vCenter, Rubrik.VMwareDatastore, Rubrik.VMwareHost, Rubrik.VMwareVM, and Rubrik.VolumeGroup
* Addresses [Issue 323](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/323)

## 2019-09-19

### Added [Cmdlets to manage Rubrik users]

* Added Get-RubrikUser, New-RubrikUser, Remove-RubrikUser and Set-RubrikUser and respective unit tests to manage user accounts.
* Addresses [Issue 244](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/244)

## 2019-09-12

### Changed [Added ability to rename Managed Volumes]

* Added -Name parameter to Set-RubrikManagedVolume.  Name already existed within the body definition in Get-RubrikAPIData
* Addresses [Issue 447](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/447)

## 2019-09-10

### Added [Unit test for Invoke-RubrikRestCall]

* Created unit test for Invoke-RubrikRestCall
* Addresses [Issue 348](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/348)

## 2019-09-09

### Added [Get-RubrikObject]

* Created Get-RubrikObject cmdlet and respective Unit test.
* Addresses [Issue 349](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/349)

### Added [Various Unit Tests]

* Created unit tests for Get-RubrikAvailabilityGroup, Get-RubrikOrganization, Get-RubrikRequest, Get-RubrikUnmanagedObject, Remove-RubrikUnmanagedObject, Set-RubrikAvailabilityGroup, and Sync-RubrikTag.  Get-RubrikSnapshot was already present.
* Resolves [Issue 347](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/347)

## 2019-09-02

### Added [-RubrikBootStrap] unit tests

* Created unit tests for both `Get-RubrikBootStrap` and `New-RubrikBootStrap` as requested in [Issue 383](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/383)
* Updated documentation

### Changed [New-RubrikBootstrap]

* Enhanced validation of strings and validatescript block

## 2019-08-30

### Changed [New-RubrikLogShipping.Tests]

* Changed functionality of `New-RubrikLogShipping.Tests` to use inModuleScope

## 2019-08-28

### Changed [New-RubrikLogShipping]

* Changed `New-RubrikLogShipping` If-statement validation to check based on object instead of string

## 2019-08-23

### Added [Various Unit Tests]

* Added unit tests for `New-RubrikLogShipping`, `New-RubrikLogBackup`, `Get-RubrikLogShipping`, `Set-RubrikLogShipping`, `Reset-RubrikLogShipping`, and `Remove-RubrikLogShipping`
* Set `IgnoreCase` on state parameter for `Set-RubrikLogShipping` as parameters must be uppercase to process in API call.
* Addresses [Issue 344](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/344)

### Fixed [Get-RubrikDatabaseFiles]

* Updated Api information for function in `Get-RubrikApiData` [Issue 430](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/430)

## 2019-08-14

### Changed [Test-ReturnFormat] private function

* Improved detection of empty strings

### Changed [Get-RubrikEvent]

* Added validation for `time` field, if `time` field does not exist it will not add `date` property [Issue 428](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/428)

## 2019-08-13

### Added [Convert-ApiDateTime] private function

* Function is used to convert API time strings to date time objects
* Created associated unit tests to validate behavior of function

### Changed [Get-RubrikEvent]

* Added new `date` property to output, uses new Convert-APIDateTime function for conversion [Issue 426](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/426)
* Added additional unit tests to validate proper date time conversion

## 2019-08-12

### Added [Select-ExactMatch] private function

* As requested in issue [Issue 419](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/419)

### Changed [Get-RubrikFileset]

* Now uses new private function instead of the custom code in the function

## 2019-08-08

### Changed [Get-RubrikManagedVolume]

* Changed behavior of `-Relic` switch, by default now retrieves both relic and non-relics. `-Relic` or `-Relic:$false` in addition to that
* Added additional unit test
* Created parameter sets and improved parameter validation [Issue 351](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/351)

## 2019-08-06

### Changed [Get-RubrikSnapshot]

* Added `-Latest` parameter to return latest snapshot data
* Added `-Range` to use with `-Date`. This specifies how many days away from the given date to search for the closest matching snapshot. Defaults to one day.
* Added `-ExactMatch` to use with `-Date`. This causes no results to be returned if a matching date isn't found. Otherwise, all snapshots are returned if no match is made.
* Added unit tests for `Get-RubrikSnapshot`
* Updated `Test-DateDifference`, a private function used by `Get-RubrikSnapshot`, to support the `-Range` parameter

## 2019-07-31

### Changed [Get-RubrikFileset]

* Behavior of `-Name` and `-Hostname` changed to only do an exact match as reported in [Issue 384](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/384)
* Added new `-NameFilter` and `-HostNameFilter` parameters to allow for in-fix matching
* Added new tests for `Get-RubrikFileSet`

### Fixed [Get-RubrikSQLInstance]

* The Get-RubrikSQLInstance PrimaryClusterID had a bug as reported in issue [Issue 399](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/399)
* Updated parameter help to correctly suggest `local` to be used
* Added additional examples that describe usage of the -PrimaryClusterID parameter

### Changed [Get-RubrikReportData]

* Default behavior of Get-RubrikReportData updated to reflect default behavior of other parameters, setting limit to maximum amount unless specified. [Issue 408](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/408)

## 2019-07-30

### Changed [readme.md]

* Removed references to the completed refactor branch [Issue 411](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/411)

## 2019-07-26

### Changed [Set-RubrikSLA]

* Added ability to configure archival and replication settings to address [Issue 368](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/368)
* Changed logic for $AdvancedConfig. It's not required anymore to set this parameter directly when piping from Get-RubrikSLA and advanced configuration was already enabled.

### Added [Various Unit Tests]

* Added Unit Tests for Get-RubrikFileset, Get-RubrikFilesetTemplate, New-RubrikFileset, New-RubrikFilesetTemplate, Protect-RubrikFilset, and Remove-RubrikFileset
* Addresses [Issue 343](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/343)

## 2019-07-25

### Fixed [Restore-RubrikDatabase]

* Fixed bug in example, added additional example

### Added [Various Unit Tests]

* Added unit tests for Get-RubrikReport, Get-RubrikReportData, New-RubrikReport, and Remove-RubrikReport.  Export-RubrikReport unit test already existed.
* Addresses [Issue 342](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/342)

## 2019-07-24

### Fixed [Submit-Request]

* Now populating the $WebResult variable in order to show HTTP Status Codes/Descriptions as well as proper status messages for PowerShell versions prior to 6.
* Address [Issue 402](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/402)

## 2019-07-23

### Changed [New-RubrikSLA]

* Added support for archival and replication settings to New-RubrikSLA to address [Issue 367](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/367)

### Changed [Set-RubrikSLA]

* Removed unnecessary braces for the frequencies array in the request body when using API v2 to address [Issue 391](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/391)
* Fixed the $FirstFullBackupDay variable to be an integer when the value is retrieved from the pipeline with Get-RubrikSLA

### Fixed [Get-RubrikEvent]

* Multiple limit flags were added to the GET query as reported in [Issue 353](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/353), this has been fixed

## 2019-07-22

### Fixed [Get-RubrikSnapshot]

* No endpoint is available for FileSet snapshots, working has been created [Issue 393](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/394)
 
### Added [Get-RubrikFileSet - DetailedObject parameter]
 
* DetailedObject parameter has been added to Get-RubrikFileSet function to retrieve all object properties

### Fixed [Get-RubrikSnapshot]

* Incorrect endpoint was used for Oracle database in combination Get-RubrikSnapshot [Issue 394](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/394)

### Changed [New-RubrikSLA]

* Added ability to specify allowed backup window settings, both for the first full backup and subsequent incremental backups in New-RubrikSLA to address [Issue 365](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/365)

## 2019-07-20

### Changed [Set-RubrikSLA]

* Added ability to specify allowed backup window settings, both for the first full backup and subsequent incremental backups in Set-RubrikSLA to address [Issue 366](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/366)

## 2019-07-19

### Added [Various Unit Tests]

* Added Unit Tests for Get-RubrikMount, Set-RubrikMount, New-RubrikMount, Remove-RubrikMount, Set-RubrikBlackout, Get-RubrikSupportTunnel, Set-RubrikSupportTunnel, Get-RubrikVersion, Get-RubrikAPIVersion and Get-RubrikSoftwareVersion
* Added filtering abilities in Get-RubrikAPIData to support id and vmid filtering in the Get-RubrikMount cmdlet
* Resolves [Issue 346](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/346)

## 2019-07-18 [Unit Tests]

* Added unit tests for Get-RubrikDatabase, Get-RubrikDatabaseFiles, Get-RubrikDatabaseMount, Get-RubrikDatabaseRecoverableRange, New-RubrikDatabaseMount, Protect-RubrikDatabase, Remove-RubrikDatabaseMount, Restore-RubrikDatabase, Set-RubrikDatabase, Get-RubrikSQLInstance, Set-RubrikSQLInstace
* Minor changes to the cmdlets listed above so they will pass new unit tests
* Added unit tests for Get-RubrikSLA, New-RubrikSLA, Remove-RubrikSLA

## 2019-07-17

### Changed [Connect-Rubrik]

* Added Userid to RubrikConnection variable when connecting using an API-token
* Resolves [Issue 381](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/381)

## 2019-07-16

### Changed [New-RubrikSLA]

* Added ability to specify advanced SLA configuration settings introduced in 5.0 on New-RubrikSLA to address [Issue 304](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/354)
* Changed -HourlyFrequency to take input in days or weeks instead of hours

## 2019-07-15

### Added [Register-RubrikBackupService]

* Added new `Register-RubrikBackupService`cmdlet to register the Rubrik Backup Service installed on the specified VM with the Rubrik cluster. This addresses issue [219](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/219). Like in the UI, there is a delay between the successful execution of the command and the actual registration of RBS.

### Added [*-Bootstrap] functions

* Added new `New-RubrikBootstrap` function to send a Rubrik Bootstrap Request
* Added new `Get-RubrikBootstrap` function that Connects to the Rubrik cluster and retrieves the bootstrap process progress
* Created a templates folder with examples of Rubrik bootstrap

## 2019-07-14

### Changed [Connect-Rubrik] - Will validate if token is correct

* Added validation step for token, a query is executed against the cluster endpoint to validate the token
* Get-RubrikAPIToken pwsh 5 bug fixed

## 2019-07-13

### Changed [Submit-Request] private function

* Changed output type for http status codes and errors to PSCustomObject

### Added [Set-RubrikSLA]

* Added new `Set-RubrikSLA` cmdlet to update an existing SLA Domain. This addresses issue [283](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/283)

## 2019-07-12

### Fixed issues with parsing of complex JSON payloads

* Get-RubrikReportData now correctly returns all data
* Performance of JSON parsing improved for PowerShell 6 and later

## 2019-07-11

### Added [Various Unit Tests]

* Added unit tests for Get-RubrikManagedVolume, Get-RubrikManagedVolumeExport, Get-RubrikVolumeGroup, Get-RubrikVolumeGroupMount, New-RubrikManagedVolume, New-RubrikManagedVolumeExport, New-RubrikVolumeGroupMount, Remove-RubrikManagedVolume, Remove-RubrikManagedVolumeExport, Remove-RubrikVolumeGroupMount, Set-RubrikManagedVolume, Start-RubrikManagedVolumeSnapshot, Start-RubrikManagedVolumeSnapshot to address [Issue 340](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/340)
* Note - Set-RubrikVolumeFilterDriver already contained a unit test.

## 2019-07-10

### Fixed [Disconnect-Rubrik & Connect-Rubrik]

* Added global attribute 'authType' to $rubrikconnection to remove reliance on userId.
* Added logic to disconnect to address the deletion of tokens when using token based authenticaion as per [Issue 363](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/363)

## 2019-07-08

### Added [Unit Tests]

* Added unit tests for Update-RubrikHost and Update-RubrikvCenter to address [Issue 339](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/339)

### Changed [Get-RubrikDatabase]

* Added ability to specify -DetailedObject on Get-RubrikDatabase to address [Issue 354](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/354)

## 2019-07-03

### Added [Unit tests]

* Added unit tests for Get-RubrikHyperVVM, Get-RubrikNutanixVM, Move-RubrikMountVMDK, New-RubrikVMDKMount, Protect-RubrikHyperVVM ,Protect-RubrikNutanixVM. Protect-RubrikVM, Set-RubrikHyperVVM, Set-RubrikNutanixVM, Set-RubrikVM

### Changed [Fixes for unit tests]

* Minor updates to parameter configurations of Get-RubrikHyperVVM, Get-RubrikNutanixVM, Move-RubrikMountVMDK, New-RubrikVMDKMount, Protect-RubrikHyperVVM ,Protect-RubrikNutanixVM. Protect-RubrikVM, Set-RubrikHyperVVM, Set-RubrikNutanixVM, Set-RubrikVM so they pass associated unit tests

### Changed [Get-RubrikDatabase] - Relic parameter

* Parameter now has 3 states -Relic -Relic:$false or not specified

## 2019-07-02

### Added Unit Tests [Export-RubrikReport & Export-RubrikDatabase]

* Added Unit Tests for Export-RubrikReport & Export-RubrikDatabase to address [Issue 333](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/333)

## 2019-06-29

### Changed Standardized usage of Out-Null over the module

* To improve PowerShell 6, and onwards compatibility we have standardized on using | Out-Null

### Added [New-RubrikSnapshot] Additional help examples in

* Added examples of how to do Full backups of Oracle and MSSQL databases

## 2019-06-28

### Changed [quick-start.md] - Additional download instructions

* Added a 4th option for downloading and distributing the Rubrik SDK for PowerShell

## 2019-06-27

### Changed [Sync-RubrikAnnotation]

* Added -DetailedObject to Get-RubrikVM in order to return the snapshots
* Added a third annotation to store the date of the latest Rubrik snapshot.
* Added associated unit tests for Sync-RubrikAnnotation

### Changed [New-RubrikSnapshot]

* Cmdlet will now display a warning if -ForceFull is set on any other protected object other than Oracle or SQL databases.
* This is just a warning and the cmdlet will continue to run, performing an incremental backup.
* This addresses [315](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/315)

### Fixed [Protect-RubrikTag]

* modified Protect-RubrikTag in order to ignore relic's when retrieving the vCenter UUID.
* Addresses [Issue 311](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/311)
* added associated Unit test for the cmdlet.

## 2019-06-26

### Added [Tests for Get-RubrikHost]

* Added unit test for Get-RubrikHost cmdlet

### Added [Get-RubrikAPIToken cmdlet]

* Added Get-RubrikAPIToken cmdlet to address [321](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/321) and associated unit test.

### Modified [New-RubrikSnapshot cmdlet]

* Added support for Oracle to New-RubrikSnapshot
* Added tests for New-RubrikSnapshot

### Fixed [Get-RubrikHost, Get-RubrikVM, Get-RubrikOracleDB]

* Added formating around $result to convert to an array in order to support -DetailedObject with older versions of Powershell.  Addresses [319](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/319)

## 2019-06-25

### Added [New New-RubrikAPIToken cmdlet]

* Added New-RubrikAPIToken cmdlet to address [316](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/316) and associated unit test.

### Added [New Remove-RubrikAPIToken cmdlet]

* Added Remove-RubrikAPIToken cmdlet to address [316](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/316) and associated unit test.

## 2019-06-24

### Added [New Get-RubrikOracleDB cmdlet]

* Added Get-RubrikOracleDB cmdlet to address [255](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/255) and associated unit test

## 2019-06-20

### Added [New Remove-RubrikVMSnapshot cmdlet]

* Added Remove-RubrikVMSnapshot cmdlet to address [148](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/148) and associated unit test

### Changed [Additional logging and info]

* Updated Invoke-RubrikWebRequest so the HTTP status code returned from the API call is displayed when verbose logging is enabled
* Updated Submit-Request to handle `Delete` API calls differently than other calls. Previously `Delete` operations did not surface any status to the user. With this change, the HTTP response code is checked to verify it matches the expected response. If so, it returns a PSObject with the HTTP code and Status = 'Success'.

## 2019-06-18

### Added [Update-RubrikVMwareVM]

* Added new `Update-RubrikVMwareVM` cmdlet to refresh a single VMware VM's metadata. This addresses issue [305](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/305)

## 2019-06-04

### Added [Resolving Issues]

* Added Export-RubrikVM cmdlet to address [Issue 239](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/239). Since the cmdlet requires IDs for both a VMware datastore and a VMware host, 2 other cmdlets were developed, Get-RubrikVMwareDatastore and Get-RubrikVMwareHost to make the whole process easier.

### Changed [Resolved issues]

* Resolved bug in New-RubrikVMDKMount, thanks @Pierre-PvF

## 2019-06-03

### Added [Resolving issues, new cmdlet]

* Added Set-RubrikVolumeFilterDriver cmdlet to support the installation/uninstallation of the Rubrik VFD on registered Windows hosts as per reported in [Issue 291](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/291).  Set-RubrikVolumeFilterDriver takes an array of string (hostIds) and an installed (true/false) parameter to determine whether to install or uninstall the VFD on the given hosts.

### Added [ DetailedObject Support for Get-RubrikHost ]

* Added a DetailedObject switch (similar to that on Get-RubrikVM) to the Get-RubrikHost cmdlet in order to grab more information when not querying by hostID.  This allows for more information to be returned by the API (IE hostVfdDriverState, hostVfdEnabled). This way users could query Rubrik hosts by name, check installation status, and pipe id's to the new Set-RubrikVolumeFilterDriver cmdlet for VFD installation.

## 2019-05-31

### Added [New-RubrikManagedVolume update]

* Added `-ApplicationTag` parameter support to New-RubrikManagedVolume so users can specify which application the managed volume will be used for. This addresses issue [285](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/285).

## 2019-05-30

### Changed [Resolving issues]

* Updated Move-RubrikMountVMDK and Test-DateDifference to resolve bugs reported in [250](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/250). Move-RubrikMountVMDK will try to find the snapshot closest to the date specified, within one day. Any valid PowerShell `datetime` formatted string will be accepted as an input, but greater specificity will lead to a much better chance of matching the intended snapshot.

## 2019-05-27

### Changed [Added functionality and resolved issues]

* Added -name parameter to Get-RubrikOrganization
* Updated Get-RubrikDatabase, Get-RubrikFileset, Get-RubrikHyperVVM, GetRubrikNutanixVM and Get-RubrikVolumeGroup to address issue [223](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/223). Calls to Test-RubrikSLA were inadvertently overwriting the $SLAID variable, causing the paramater to be ignored.
* Added Custom User Agent value to HTTP headers in Connect-Rubrik function

## 2019-05-22

### Changed [Resolving issues]

 * Get-RubrikOrganization will only return an exact match as per [224](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/224)
 * Updated documentation to fix errors on Protect-RubrikVM entry as per [162](https://github.com/rubrikinc/rubrik-sdk-for-powershell/issues/162)

## 2019-03-27 [Quickstart Documentation Update]

### Changed

* Updated Typo in Quickstart Documentation

## 2019-03-24 [Parameter validation for Get-RubrikVM]

### Added

* Added parameter sets and parameter validation to Get-RubrikVM
* Added ValidateNullNotEmpty to selected parameters in Get-RubrikVM
* Added additional 5 tests to validate parameters sets and validation work as intended

## 2019-03-17 [Added new functionality and fixed help]

### Added

* Updated example 2 in comment-based help of Invoke-RubrikRESTCall
* Added -DetailedObject parameter for Get-RubrikVM

### Fixed

* Prevent Get-RubrikVM $SLAID parameter value overwrite when it has a value as per [165](https://github.com/rubrikinc/PowerShell-Module/issues/165)

## [4.0.0] - 2017-07-07

### Added

* `Set-RubrikSupportTunnel` - Modifies the configuration of the Support Tunnel.
* `Get-RubrikSupportTunnel` - Checks the status of the Support Tunnel.
* This Changelog - moving forward, related changes will be documented here in an easy to read format for human eyeballs.
* Dynamic documentation creation via GitBook.
* [GitHub Pull Request Template](https://github.com/rubrikinc/PowerShell-Module/pull/135).
* [GitHub Issue Template](https://github.com/rubrikinc/PowerShell-Module/commit/ca0a7fc1864c42162236b4e68af6f44d07f0a164).
* [Invoke-RubrikRESTCall](https://github.com/rubrikinc/PowerShell-Module/pull/118).
* TLS v1.2 support triggered during the usage of `Connect-Rubrik`.
* `Get-RubrikLDAPSettings` - Checks all LDAP server settings
* `Get-RubrikSettings` - Checks cluster settings
* `Get-RubrikVCenter` - Checks all vCenter server settings
* `New-RubrikLDAPSettings` - Creates new LDAP server connection
* `New-RubrikVCenter` - Creates new vCenter server connection
* `Remove-RubrikVCenter` - Removes vCenter server connection
* `Set-RubrikSettings` - Modifes cluster settings
* `Set-RubrikVCenter` - Modifies vCenter server connection settings

### Changed

* Track `user_error` responses in the `Submit-Request` private function
* The `Get-RubrikSnapshot` function supports HyperV VMs.
* Updated API Data for 4.1 against `Get-RubrikReport` and `Get-RubrikReportData`.
* Modified `Get-RubrikAPIData` to use RCDM versions instead of API versions.

### Deprecated

* Dynamic documentation using ReadTheDocs and reStructuredText.
* Removed old session endpoint data from `Connect-Rubrik` used by RCDM versions 1.x and 2.x.
