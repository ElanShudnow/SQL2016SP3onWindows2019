# CreateVMs.ps1
## Description
This script creates VMs using an array list of VMs and executes an ARM Template per VM

## PowerShell Versions Tested
- PowerShell 7.3.2

## AZ PowerShell Module Version Tested
- [9.3.0](https://github.com/Azure/azure-powershell/releases)

## Instructions
1. Download CreateVMs.ps1, parameters.json, and SQL2016SP2onServer2019.json
      
2. Open parameters.json and modify all parameters accordingly

3. Open CreateVMs.ps1 and modify the list of VMs that must be created

4. Execute CreateVMs.ps1