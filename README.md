# UKG
Scripts and resources related to connecting to UltiPro's SOAP API via PowerShell.

Get-UKGReport.ps1
Import this module into PS or into a PS script.

Prerequisites for this to operate as desired:
1. You need an account in UltiPro with sufficient rights to query and view BI Reports.
2. You need to have a report created in UltiPro, and identify the Report ID.
3. You need to have internet access from the machine executing this script.

When calling the main function:

get-ukgreport -username [username] -password [password] -clientaccesskey [clientaccesskey] -useraccesskey [useraccesskey] -reportid [reportid]

Overview of what this does once executed:
1. Logon to the UKG API using the username, password, CAK, and UAK provided.
2. Execute the report based on the Report ID provided.
3. Retrieves the report stream and decodes it from Base64.
4. Logs off of the UKG API to ensure the session does not become orphaned.
5. returns the results of the stream in a powershell array.


While the 'Get-UKGReport' function executes these in the correct order for you, you can also call the subordinate functions individually for testing purposes:

Logon-UKGAPI -username [username] -password [password] -clientaccesskey [CAK] -useraccesskey [UAK]

Execute-UKGReport -serviceid [ServiceId] -token [Token] -clientaccesskey [CAK] -reportid [ReportId] -instancekey [InstanceKey]
  NOTE: The serviceId, Token, and InstanceKey are returned in the response from the Logon-UKGAPI function.
  
Retrieve-UKGReport -reportkey [ReportKey]
  NOTE: The ReportKey is returned in the response from the Execute-UKGReport function.

Logoff-UKGAPI -serviceid [ServiceId] -token [Token] -clientaccesskey [CAK] -instancekey [InstanceKey]
  NOTE: The ServiceId, Token, and InstanceKey are returned in the response from the Logon-UKGAPI function.
