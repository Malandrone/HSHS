#MAIN MENU
function DisplayMainMenu {
    param( )

do {
	
#Initialize score
$global:Score = 0 
$global:MaxScore = 0

#Initialize data structure
$Compliance = New-Object System.Collections.Generic.List[System.Object]
$Conf = Get-Content package\conf.txt
$global:Template = get-content package\report_template.html

#Load Strict-Transport-Security compliant value
$StrictTransportSecurity = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[0]=$Conf[0].replace("Strict-Transport-Security:","")
UpdateReport "#a1#" $Conf[0] 
$global:MaxScore = $global:MaxScore +5
while ($i -lt (($Conf[0].split(";")).length ) ){    $StrictTransportSecurity.add(  ($Conf[0].split(";"))[$i] ) ; $i++; $global:MaxScore= $global:MaxScore +5 }
$Compliance.add($StrictTransportSecurity )

#Load X-Frame-Options compliant value
$XFrameOptions = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[1]=$Conf[1].replace("X-Frame-Options:","")
UpdateReport "#b1#" $Conf[1] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[1].split(";")).length) ){    $XFrameOptions.add(  ($Conf[1].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +5 }
$Compliance.add($XFrameOptions )

#Load X-Content-Type-Options compliant value
$XContentType =  New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[2]=$Conf[2].replace("X-Content-Type-Options:","")
UpdateReport "#c1#" $Conf[2] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[2].split(";")).length ) ){    $XContentType.add(  ($Conf[2].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +5 }
$Compliance.add($XContentType  )

#Load Content-Security-Policy compliant value
$XContentSecurityPolicy =  New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[3]=$Conf[3].replace("Content-Security-Policy:","")
UpdateReport "#d1#" $Conf[3] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[3].split(";")).length ) ){    $XContentSecurityPolicy.add(  ($Conf[3].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($XContentSecurityPolicy )

#Load X-Permitted-Cross-Domain-Policies compliant value
$XPermittedCrossDomainPolicies = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[4]=$Conf[4].replace("X-Permitted-Cross-Domain-Policies:","")
UpdateReport "#e1#" $Conf[4] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[4].split(";")).length ) ){    $XPermittedCrossDomainPolicies.add(  ($Conf[4].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +5}
$Compliance.add($XPermittedCrossDomainPolicies )

#Load Referrer-Policy compliant value
$ReferrerPolicy =  New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[5]=$Conf[5].replace("Referrer-Policy:","")
UpdateReport "#f1#" $Conf[5] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[5].split(";")).length ) ){    $ReferrerPolicy.add(  ($Conf[5].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +5}
$Compliance.add($ReferrerPolicy )

#Load Clear-Site-Data compliant value
$ClearSiteData = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[6]=$Conf[6].replace("Clear-Site-Data:","")
UpdateReport "#g1#" $Conf[6] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[6].split(",")).length -1) ){    $ClearSiteData.add(  ($Conf[6].split(","))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($ClearSiteData)

#Load Cross-Origin-Embedder-Policy compliant value 
$CrossOriginEmbedderPolicy = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[7]=$Conf[7].replace("Cross-Origin-Embedder-Policy:","")
UpdateReport "#h1#" $Conf[7] 
$global:MaxScore= $global:MaxScore +1
while ($i -lt (($Conf[7].split(";")).length ) ){    $CrossOriginEmbedderPolicy.add(  ($Conf[7].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($CrossOriginEmbedderPolicy )

#Load Cross-Origin-Opener-Policy compliant value
$CrossOriginOpenerPolicy = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[8]=$Conf[8].replace("Cross-Origin-Opener-Policy:","")
UpdateReport "#i1#" $Conf[8] 
$global:MaxScore= $global:MaxScore +1
while ($i -lt (($Conf[8].split(";")).length ) ){    $CrossOriginOpenerPolicy.add(  ($Conf[8].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($CrossOriginOpenerPolicy )

#Load Cross-Origin-Resource-Policy compliant value
$CrossOriginResourcePolicy = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[9]=$Conf[9].replace("Cross-Origin-Resource-Policy:","")
UpdateReport "#j1#" $Conf[9] 
$global:MaxScore= $global:MaxScore +1
while ($i -lt (($Conf[9].split(";")).length ) ){    $CrossOriginResourcePolicy.add(  ($Conf[9].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($CrossOriginResourcePolicy )

#Load Permissions-Policy compliant value
$PermissionsPolicy = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[10]=$Conf[10].replace("Permissions-Policy:","")
UpdateReport "#k1#" $Conf[10] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[10].split(",")).length ) ){    $PermissionsPolicy.add(  ($Conf[10].split(","))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +0.1 }
$Compliance.add($PermissionsPolicy )

#Load Cache-Control compliant value 
$CacheControl = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[11]=$Conf[11].replace("Cache-Control:","")
UpdateReport "#l1#" $Conf[11] 
$global:MaxScore= $global:MaxScore +5
while ($i -lt (($Conf[11].split(",")).length ) ){    $CacheControl.add(  ($Conf[11].split(","))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +2.5 }
$Compliance.add($CacheControl)

#Load Pragma compliant value
$Pragma = New-Object System.Collections.Generic.List[System.Object]
$i=0
$Conf[12]=$Conf[12].replace("Pragma:","")
UpdateReport "#m1#" $Conf[12] 
$global:MaxScore= $global:MaxScore +1
while ($i -lt (($Conf[12].split(";")).length ) ){    $Pragma.add(  ($Conf[12].split(";"))[$i] ) ; $i++ ; $global:MaxScore= $global:MaxScore +1 }
$Compliance.add($Pragma )



 $Choice = "NONE"
 Clear-Host
 PrintLogo
 Write-Host "[1]-Analyze HTTP Headers "
 Write-Host "[2]-View compliant configuration " 
 Write-Host "[3]-Set proxy credentials " 
 Write-Host "[0]-Exit " 

 $Choice = Read-Host -Prompt 'Insert your choice'
 
 switch ( $Choice ) {
     1  { AnalyzeHTTPHeaders $Compliance }
	 2  { ViewCompliantConfiguration $Compliance }
	 3  { $global:WebClient = SetProxyCredentials   }
 }

}

until($Choice -eq "0")

return  
}


#ANALYZE HTTP HEADERS
function AnalyzeHTTPHeaders {
    param( 
	[Parameter(Mandatory = $true)][PSObject[]] $Compliance
	)


  Clear-Host
  PrintLogo
  
  $Url = Read-Host -Prompt 'Insert Url to scan'
  $global:Score = 0 
  $HTTPResponse = GetHTTPResponse $Url
  
  Clear-Host
  PrintLogo
  
  Write-Host "HTTP response info:" -ForegroundColor yellow
  Write-Output $HTTPResponse
  Write-Host "HTTP headers:" -ForegroundColor yellow 
  
  $HttpHeaders = $HttpResponse.Headers
	

  $i=0
  foreach ( $header in $HttpHeaders) {
	
	Write-Host ""
	Write-Host $header -nonewline 
 
	Write-Host " : " $HttpHeaders[$i]	
    $i++
  }
  
  Write-Host "`n"
  Write-Host "Compliance status:" -ForegroundColor yellow 
  Write-Host "`n"
  
  CheckStrictTransportSecurity $HttpHeaders $Compliance
  CheckXFrameOptions $HttpHeaders $Compliance
  CheckXContentTypeOptions $HttpHeaders $Compliance
  CheckContentSecurityPolicy $HttpHeaders $Compliance
  CheckXPermittedCrossDomainPolicies $HttpHeaders $Compliance
  CheckReferrerPolicy $HttpHeaders $Compliance
  CheckClearSiteData $HttpHeaders $Compliance
  CheckCrossOriginEmbedderPolicy $HttpHeaders $Compliance
  CheckCrossOriginOpenerPolicy $HttpHeaders $Compliance
  CheckCrossOriginResourcePolicy $HttpHeaders $Compliance
  CheckPermissionsPolicy $HttpHeaders $Compliance
  CheckCacheControl $HttpHeaders $Compliance
  CheckPragma $HttpHeaders $Compliance
  
  Write-Host "`n"
  Write-Host "Compliance score:" -ForegroundColor yellow 
  Write-Host "`n"
  
  $global:NormalizedScore = [Math]::Round(100*( $global:Score / $global:MaxScore ))
  
  Write-Host  $global:NormalizedScore "/100"
  Write-Host "`n"
  
  Write-Host "Do you want to generate a report file? [Y/N]"
  $ChoiceReport =  Read-Host
  
  $OutputFolder = ""
  $FileName = $global:InputUrl.toLower().replace("http//:","").replace("https://","").replace("/","_").replace("\","_").replace(".","_").replace(":","").replace("&","").replace("%","").replace("?","").replace("=","")
  if ($FileName.length -gt 50 ) {   $Filename = $Filename.Substring(0,49) }
  if($ChoiceReport -eq "Y") { 
    
	$OutputFolder = DisplayDialogWindowFolder
	if ($OutputFolder -ne "" ){
	 $OutputFile = $OutputFolder +"\HSHS_report_"+$FileName+".html"
	GenerateReport $OutputFile
	}
	}
  pause

return  
}



#COMPLIANT CONFIGURATION
function ViewCompliantConfiguration {
    param( 
	[Parameter(Mandatory = $true)]$Compliance
	)

 Clear-Host
 PrintLogo
 
 Write-Host "Compliant configuration: " -ForegroundColor yellow
 Write-Host "`n"
 
 
 Write-Host "HTTP Strict Transport Security:  " -nonewline 
 WriteCompliantValue1 $Compliance[0]
 Write-Host "X-Frame-Options:  " -nonewline
 WriteCompliantValue1 $Compliance[1]
 Write-Host "X-Content-Type-Options: :  " -nonewline
 WriteCompliantValue1 $Compliance[2]
 Write-Host "Content-Security-Policy:  " -nonewline
 WriteCompliantValue1 $Compliance[3]
 Write-Host "X-Permitted-Cross-Domain-Policies:  " -nonewline
 WriteCompliantValue1 $Compliance[4]
 Write-Host "Referrer-Policy:  " -nonewline
 WriteCompliantValue1 $Compliance[5]
 Write-Host "Clear-Site-Data:  " -nonewline
 WriteCompliantValue2 $Compliance[6]
 Write-Host "Cross-Origin-Embedder-Policy:  " -nonewline
 WriteCompliantValue1 $Compliance[7]
 Write-Host "Cross-Origin-Opener-Policy:  " -nonewline
 WriteCompliantValue1 $Compliance[8]
 Write-Host "Cross-Origin-Resource-Policy:  " -nonewline
 WriteCompliantValue1 $Compliance[9]
 Write-Host "Permissions-Policy:  " -nonewline
 WriteCompliantValue2 $Compliance[10]
 Write-Host "Cache-Control:  " -nonewline
 WriteCompliantValue2 $Compliance[11]
 Write-Host "Pragma:  " -nonewline
 WriteCompliantValue1 $Compliance[12]
 
 pause 

return
}

#PROXY AUTHENTICATION
function SetProxyCredentials {
    param( )

Clear-Host
PrintLogo

$WebClient = New-Object System.Net.WebClient
$Credentials = Get-Credential
$WebClient.Proxy.Credentials = $Credentials

	
return	$WebClient
}	

#HSHS module import
Import-Module ./package\HSHS.psd1

#START GUI
DisplayMainMenu