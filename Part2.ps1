Connect-AzureRmAccount

New-AzureRmResourceGroup -Name waqas-RG -Location eastus

New-AzureRmSqlServer -ServerName waqassqlserver -ResourceGroupName waqas-RG -Location eastus -SqlAdministratorCredentials (Get-Credential)

New-AzureRmStorageAccount -ResourceGroupName waqas-RG -Name waqasdb2 -SkuName Standard_GRS -Location eastus

$serverInstance = (Get-AzureRmSqlServer -ResourceGroupName waqas-RG -ServerName waqassqlserver)

$databases = "db1" , "db2" , "db3"

$sqlserver = Get-AzureRmSqlServer -ResourceGroupName waqas-RG -ServerName waqassqlserver

foreach($database in $databases)
{
New-AzureRmSqlDatabase `
-ServerName waqassqlserver `
-DatabaseName $database `
-ResourceGroupName waqas-RG

}

foreach($database in $databases)
{

 Invoke-Sqlcmd `
-ServerInstance $serverInstance.FullyQualifiedDomainName `
-Database $database `
-Username $sqlserver.SqlAdministratorLogin `
-Password "7]yU5Dm`'WD}xH<>"`
-Query $ct 
}

$ct= "CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);"

$sqlPath = (Get-AzureRmSqlServer -ResourceGroupName waqas-RG -ServerName waqassqlserver)

$storageURi = (Get-AzureRmStorageAccount -ResourceGroupName waqas-RG -Name waqassqlserver)        

$storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName waqas-RG -Name waqassqlserver).Value

foreach ($database in $databases) {
        try {

            Write-Host "...starting backup: " $databasePath
            New-AzureRmSqlDatabaseExport -Database $database -BackupContainer$storageURi.Context.BlobEndPoint -SqlCredential (Get-Credential)
            Write-Host "...backup complete."  }
        catch { Write-Host $_.Exception.Message } }


foreach ($database in $databases) {New-AzureRmSqlDatabaseExport -ResourceGroupName "waqas-RG" -ServerName "waqassqlserver" `
       -DatabaseName $DbName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri `
       -AdministratorLogin $creds.UserName -AdministratorLoginPassword $creds.Password }
        
        
