# Wrapper file for mass deployment of ARM templates

$VMarray = (
    'testvm14',
    'testvm15'
)

Write-Host "Executing CreateVMs.ps1 PowerShell Script" -ForegroundColor Yellow

foreach ($VM in $VMarray)
{
    # Create Resource Group with VMName
    Write-Host "Creating Resource Group for VM: $VM" -ForegroundColor Green
    az group create --name $VM --location southcentralus

    # Import Root Parameters File and convert from JSON into PowerShell Object
    $ParameterJSON = (Get-Content parameters.json | ConvertFrom-Json).parameters

    # Replace Virtual Machine Name in Parameters PowerShell Object
    $ParameterJSON.virtualMachineName.Value = $VM

    # Convert modified PowerShell Object into JSON
    $ModifiedJSON = $ParameterJSON | ConvertTo-Json 

    # Write new JSON file for new VM
    $VMParameterFileName = "parameters-$VM.json"
    $VMParametersFileData | New-Item $VMParameterFileName -type file -Force | Out-Null
    Set-Content -Path $VMParameterFileName -Value $ModifiedJSON -PassThru -Force | Out-Null

    # Create Deployment using ARM Template
    Write-Host "Creating VM Deployment for VM: $VM" -ForegroundColor Green
    az deployment group create --name $VM --resource-group $VM --template-file SQL2016SP2onServer2019.json --parameters $VMParameterFileName
    Remove-Item -Path $VMParameterFileName
}