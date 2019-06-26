﻿#Requires -Version 3
function Get-RubrikSLA 
{
  <#  
      .SYNOPSIS
      Connects to Rubrik and retrieves details on SLA Domain(s)
            
      .DESCRIPTION
      The Get-RubrikSLA cmdlet will query the Rubrik API for details on all available SLA Domains.
      Information on each domain will be reported to the console.
            
      .NOTES
      Written by Chris Wahl for community usage
      Twitter: @ChrisWahl
      GitHub: chriswahl
            
      .LINK
      http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/Get-RubrikSLA.html
            
      .EXAMPLE
      Get-RubrikSLA
      Will return all known SLA Domains
            
      .EXAMPLE
      Get-RubrikSLA -Name 'Gold'
      Will return details on the SLA Domain named Gold
  #>

  [CmdletBinding()]
  Param(
    # Name of the SLA Domain
    [Alias('SLA')]
    [String]$Name,
    # Filter the summary information based on the primarycluster_id of the primary Rubrik cluster. Use **_local** as the primary_cluster_id of the Rubrik cluster that is hosting the current REST API session.
    [Alias('primary_cluster_id')]
    [String]$PrimaryClusterID,    
    # SLA Domain id
    [Parameter(ValueFromPipelineByPropertyName = $true)]    
    [String]$id, 
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
    $body = New-BodyString -bodykeys ($resources.Body.Keys) -parameters ((Get-Command $function).Parameters.Values)    
    $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
    $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
    $result = Test-FilterObject -filter ($resources.Filter) -result $result

    $result.ForEach{$_.PSObject.TypeNames.Insert(0,'Rubrik.SLAObject')}
    return $result

  } # End of process
} # End of function