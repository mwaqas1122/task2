Connect-AzureRmAccount

Get-AzLocation | select Location
$location = "eastus"

$resourceGroup = "myResourceGroup"
New-AzResourceGroup -Name $resourceGroup -Location $location


$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name "blogarticles" `
  -SkuName Standard_LRS `
  -Location $location `

$ctx = $storageAccount.Context





$containerName = "quickstartblobs"
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob


Set-AzStorageBlobContent -File "C:\DevOpsTask2\text1.txt" `
  -Container $containerName `
  -Blob "text1.txt" `
  -Context $ctx 