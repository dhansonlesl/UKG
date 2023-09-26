function Logon-UKGAPI {
param(
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$username,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$password,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$clientaccesskey,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$useraccesskey
)
Process {
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/soap+xml")
$endpoint = "https://service5.ultipro.com/services/BIDataService"
$logon_body = "<s:Envelope xmlns:s=`"http://www.w3.org/2003/05/soap-envelope`" xmlns:a=`"http://www.w3.org/2005/08/addressing`">
`n    <s:Header>
`n        <a:Action s:mustUnderstand=`"1`">http://www.ultipro.com/dataservices/bidata/2/IBIDataService/LogOn</a:Action>
`n        <a:To s:mustUnderstand=`"1`">https://servicehost/services/BIDataService</a:To>
`n    </s:Header>
`n    <s:Body>
`n        <LogOn xmlns=`"http://www.ultipro.com/dataservices/bidata/2`">
`n            <logOnRequest xmlns:i=`"http://www.w3.org/2001/XMLSchema-instance`">
`n                <UserName>$($username)</UserName>
`n                <Password>$($password)</Password>
`n                <ClientAccessKey>$($clientaccesskey)</ClientAccessKey>
`n                <UserAccessKey>$($useraccesskey)</UserAccessKey>
`n            </logOnRequest>
`n        </LogOn>
`n    </s:Body>
`n</s:Envelope>"
$response = Invoke-RestMethod $endpoint -Method 'POST' -Headers $headers -Body $logon_body
return $response
} # LOGON-UKGAPI.Process
} # LOGON-UKGAPI.Function

function Execute-UKGReport {
param(
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$serviceid,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$token,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$instancekey,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$clientaccesskey,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$reportid
)
Process {
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/soap+xml")
$headers.Add("US-DELIMITER", ",")
$endpoint = "https://service5.ultipro.com/services/BIDataService"
$reportpath = 'storeID("' + $reportid + '")'
$reportpath
$executereport_body = "<s:Envelope xmlns:s=`"http://www.w3.org/2003/05/soap-envelope`"  xmlns:ns=`"http://www.ultipro.com/dataservices/bidata/2`">
`n    <s:Header xmlns:a=`"http://www.w3.org/2005/08/addressing`">
`n        <a:Action s:mustUnderstand=`"1`">http://www.ultipro.com/dataservices/bidata/2/IBIDataService/ExecuteReport</a:Action>
`n        <a:To s:mustUnderstand=`"1`">https://servicehost/services/BiDataService</a:To>
`n    </s:Header>
`n    <s:Body>
`n        <ns:ExecuteReport xmlns=`"http://www.ultipro.com/dataservices/bidata/2`">
`n            <ns:request xmlns:i=`"http://www.w3.org/2001/XMLSchema-instance`">
`n                <ns:ReportPath>$($reportpath)</ns:ReportPath>
`n            </ns:request>
`n            <ns:context xmlns:i=`"http://www.w3.org/2001/XMLSchema-instance`">
`n                <ns:ServiceId>$($serviceid)</ns:ServiceId>
`n                <ns:ClientAccessKey>$($clientaccesskey)</ns:ClientAccessKey>
`n                <ns:Token>$($token)</ns:Token>
`n                <ns:Status>Ok</ns:Status>
`n                <ns:StatusMessage i:nil=`"true`"/>
`n                <ns:InstanceKey>$($instancekey)</ns:InstanceKey>
`n            </ns:context>
`n        </ns:ExecuteReport>
`n    </s:Body>
`n</s:Envelope>"
$response = Invoke-RestMethod $endpoint -Method 'POST' -Headers $headers -Body $executereport_body
return $response
} # EXECUTE-UKGREPORT.Process
} # EXECUTE-UKGREPORT.Function

function Retrieve-UKGReport {
param(
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$reportkey
)
Process {
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/soap+xml")
$endpoint = "https://service5.ultipro.com/services/BIStreamingService"
$retrievereport_body = "<s:Envelope xmlns:s=`"http://www.w3.org/2003/05/soap-envelope`" xmlns:a=`"http://www.w3.org/2005/08/addressing`"> 
`n  <s:Header> 
`n    <a:Action s:mustUnderstand=`"1`">http://www.ultipro.com/dataservices/bistream/2/IBIStreamService/RetrieveReport</a:Action>  
`n    <h:ReportKey xmlns:h=`"http://www.ultipro.com/dataservices/bistream/2`" xmlns=`"http://www.ultipro.com/dataservices/bistream/2`">$($reportkey)</h:ReportKey>  
`n    <a:To s:mustUnderstand=`"1`">https://servicehost/services/BIStreamingService</a:To>   
`n  </s:Header> 
`n  <s:Body xmlns:xsi=`"http://www.w3.org/2001/XMLSchema-instance`" xmlns:xsd=`"http://www.w3.org/2001/XMLSchema`"> 
`n    <RetrieveReportRequest xmlns=`"http://www.ultipro.com/dataservices/bistream/2`"/>   
`n  </s:Body> 
`n</s:Envelope>"
$response = Invoke-RestMethod $endpoint -Method 'POST' -Headers $headers -Body $retrievereport_body
return $response
} # RETRIEVE-UKGREPORT.Process
} # RETRIEVE-UKGREPORT.Function

function Logoff-UKGAPI {
param(
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$serviceid,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$token,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$clientaccesskey,
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][string[]]$instancekey
)
Process {
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/soap+xml")
$endpoint = "https://service5.ultipro.com/services/BIDataService"
$logoff_body = "<s:Envelope xmlns:s=`"http://www.w3.org/2003/05/soap-envelope`" xmlns:ns=`"http://www.ultipro.com/dataservices/bidata/2`">
`n    <s:Header xmlns:a=`"http://www.w3.org/2005/08/addressing`">
`n        <a:Action s:mustUnderstand=`"1`">http://www.ultipro.com/dataservices/bidata/2/IBIDataService/LogOff</a:Action>
`n        <a:To s:mustUnderstand=`"1`">https://servicehost/services/BIDataService</a:To>
`n    </s:Header>
`n    <s:Body>
`n        <ns:LogOff>
`n            <ns:context>
`n                <ns:ServiceId>$($serviceid)</ns:ServiceId>
`n                <ns:ClientAccessKey>$($clientaccesskey)</ns:ClientAccessKey>
`n                <ns:Token>$($token)</ns:Token>
`n                <ns:InstanceKey>$($instancekey)</ns:InstanceKey>
`n            </ns:context>
`n        </ns:LogOff>
`n    </s:Body>
`n</s:Envelope>"
$response = Invoke-RestMethod $endpoint -Method 'POST' -Headers $headers -Body $logoff_body
return $response
} # LOGOFF-UKGAPI.Process
} # LOGOFF-UKGAPI.Function

function get-UKGReport {
param(
    [string]$username,
    [string]$password,
    [string]$clientaccesskey,
    [string]$useraccesskey,
    [string]$reportid,
    [switch]$help = $false
)
begin {
if ($help -eq $true) {
    throw "Get-UKGReport Usage:
    get-ukgreport -username [username] -password [password] -clientaccesskey [clientaccesskey] -useraccesskey [useraccesskey] -reportid [reportid]"
}
$logon_response = $execute_response = $retrieve_response = $logoff_response = $null
if (!($username)) { $username = read-host -prompt "Username:"}
if (!($password)) { $password = read-host -prompt "Password:"}
if (!($clientaccesskey)) { $clientaccesskey = read-host -prompt "Client Access Key:"}
if (!($useraccesskey)) { $useraccesskey = read-host -prompt "User Access Key:"}
if (!($reportid))  { $reportid = read-host -prompt "Report ID:" }
}
process {
if ($help -eq $true) {
    throw "CLOSE"
}
    $logon_response = Logon-UKGAPI `
        -username $username `
        -password $password `
        -clientaccesskey $clientaccesskey `
        -useraccesskey $useraccesskey
    write-host "LOGON: $($logon_response.envelope.body.logonresponse.logonresult.Status)"

    $execute_response = Execute-UKGReport `
        -serviceid $logon_response.envelope.body.LogOnResponse.LogOnResult.serviceid `
        -token $logon_response.envelope.body.logonresponse.logonresult.token `
        -clientaccesskey 'WJ532' -reportid $reportid `
        -instancekey $logon_response.envelope.body.logonresponse.logonresult.instancekey
    write-host "EXECUTE: $($execute_response.envelope.body.executereportresponse.executereportresult.Status)"

    $retrieve_response = Retrieve-UKGReport `
        -reportkey $execute_response.envelope.body.executereportresponse.executereportresult.reportkey
    write-host "REPORTSTREAM: $($retrieve_response.envelope.header.Status.'#text')"

    $logoff_response = Logoff-UKGAPI `
        -serviceid $logon_response.envelope.body.logonresponse.logonresult.serviceid `
        -token $logon_response.envelope.body.logonresponse.logonresult.token `
        -clientaccesskey $clientaccesskey `
        -instancekey $logon_response.envelope.body.logonresponse.logonresult.instancekey
    write-host "LOGOFF: $($logoff_response.envelope.body.logoffresponse.logoffresult.Status)"
} #CORE.Process
end {
if ($help -eq $true) {
    throw "CLOSE"
}
$result = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($retrieve_response.envelope.body.StreamReportResponse.ReportStream))
$array = $result.split([Environment]::Newline)
return $array
}
}
#get-ukgreport