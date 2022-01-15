<#
Function name: DisplayDialogWindowFolder
Description: Displays a dialog window to set the input folder path
Function calls: 
Input:  -
Output: $InputFolder
#>

function DisplayDialogWindowFolder() {
	
   Add-Type -AssemblyName System.Windows.Forms
   $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
   $null = $FolderBrowser.ShowDialog()
   $InputFolder = $FolderBrowser.SelectedPath
   
  return $InputFolder	
	
}

<#
Function name: UpdateReport
Description: Inserts a value on a HTML data structure  
Function calls: -
Input: $Position, $Value
Output: -   
#>

function  UpdateReport( ) {
param(
	[Parameter(Mandatory = $True)] $Position , 
	[Parameter(Mandatory = $True)] $Value
    )


$global:Template = $global:Template.replace( $Position , $Value )

return
}

<#
Function name: GenerateReport
Description: Generates a HTML report file  
Function calls: -
Input: $OutputFile
Output: -   
#>

function  GenerateReport( ) {
param(
	[Parameter(Mandatory = $True)] $OutputFile 
    )





$global:Template = $global:Template.replace("###site_name###",$global:InputUrl )
$FinalScore =  ($global:NormalizedScore| Out-String)+"/100"
$global:Template = $global:Template.replace("###compliance_score###",$FinalScore )
$global:Template | Out-File $OutputFile 

Write-Host "Template saved on " $OutputFile  -ForegroundColor green

return
}