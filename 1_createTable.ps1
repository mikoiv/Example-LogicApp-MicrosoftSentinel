# Variables for Azure Subscription ID, Log Analytics Resource Group and Log Analytics Workspace name.
$TenantId = ""
$SubscriptionId = ""
$LogAnalyticsRG = ""
$LogAnalyticsWorkspace = ""

# Connect to Azure
Connect-AzAccount -Tenant $TenantId
Set-AzContext -Subscription $SubscriptionId 

# Create the table
$tableParams = @'
{
   "properties": {
       "schema": {
              "name": "LogicAppExample_CL",
              "columns": [
                {
                    "name": "TimeGenerated",
                    "type": "datetime"
                },
                {
                    "name": "CustomColumn1",
                    "type": "string"
                },
                {
                    "name": "CustomColumn2",
                    "type": "string"
                },
                {
                    "name": "CustomColumn3",
                    "type": "string"
                }
             ]
       }
   }
}
'@

Invoke-AzRestMethod -Path "/subscriptions/$SubscriptionID/resourcegroups/$LogAnalyticsRG/providers/microsoft.operationalinsights/workspaces/$LogAnalyticsWorkspace/tables/LogicAppExample_CL?api-version=2021-12-01-preview" -Method PUT -payload $tableParams
