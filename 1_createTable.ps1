# Variables for Azure Subscription ID, Log Analytics Resource Group and Log Analytics Workspace name.
$TenantId = "4a5d1d90-5ce3-4b97-9b81-028dee0c72dc"
$SubscriptionId = "d0f4f21b-3cee-4c8e-8514-04f2c3786b4b"
$LogAnalyticsRG = "rg-logs-sec-001"
$LogAnalyticsWorkspace = "law-secopslab-sec-001"

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
