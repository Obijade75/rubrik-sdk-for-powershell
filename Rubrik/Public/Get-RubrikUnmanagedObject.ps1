﻿#requires -Version 3
function Get-RubrikUnmanagedObject
{
  <#  
      .SYNOPSIS
      Retrieves details on one or more unmanaged objects known to a Rubrik cluster

      .DESCRIPTION
      The Get-RubrikUnmanagedObject cmdlet is used to pull details on any unmanaged objects that has been stored in the cluster
      In most cases, this will be on-demand snapshots that are associated with an object (virtual machine, fileset, database, etc.)

      .NOTES
      Written by Chris Wahl for community usage
      Twitter: @ChrisWahl
      GitHub: chriswahl

      .LINK
      http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Get-RubrikUnmanagedObject.html

      .EXAMPLE
      Get-RubrikUnmanagedObject -Type 'WindowsFileset'
      This will return details on any filesets applied to Windows Servers that have unmanaged snapshots associated

      .EXAMPLE
      Get-RubrikUnmanagedObject -Status 'Unprotected' -Name 'Server1'
      This will return details on any objects named "Server1" that are currently unprotected and have unmanaged snapshots associated
  #>

  [CmdletBinding()]
  Param(
    # Search object by object name.
    [Alias('search_value')]
    [String]$Name,
    # Filter by the type of the object. If not specified, will return all objects. Valid attributes are Protected, Relic and Unprotected
    [Alias('unmanaged_status')]
    [ValidateSet('Protected','Relic','Unprotected')]
    [String]$Status,
    # The type of the unmanaged object. This may be VirtualMachine, MssqlDatabase, LinuxFileset, or WindowsFileset.
    [Alias('object_type')]
    [ValidateSet('VirtualMachine','MssqlDatabase','LinuxFileset','WindowsFileset')]
    [String]$Type,
    # Rubrik server IP or FQDN
    [String]$Server = $global:RubrikConnection.server,
    # API version
    [ValidateNotNullorEmpty()]
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
    $body = New-BodyString -bodykeys ($resources.Body.Keys) -parameters ((Get-Command $function).Parameters.Values)
    $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
    $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
    $result = Test-FilterObject -filter ($resources.Filter) -result $result
    $result = Set-ObjectTypeName -TypeName $resources.ObjectTName -result $result

    return $result

  } # End of process
} # End of function