<#
Function name: GetHTTPResponse
Description: Sends a http GET request to an input URL and returns the http response
Function calls: -
Input:  $Url 
Output: $HttpResponse

#>

function GetHTTPResponse() {
	param([Parameter(Mandatory = $True)] [string]$Url)
	
	
	$global:InputUrl = $Url
	$HttpRequest = [System.Net.WebRequest]::Create($Url)
	
	
	try {
		$HttpResponse = $HttpRequest.GetResponse()
	}
	catch [Net.WebException] {
     $HttpResponse = $_.Exception.Response
     $HttpStatus = [int]$HttpResponse.StatusCode       
		
	}
	
	
	return  $HttpResponse
	
}

<#
Function name: CheckStrictTransportSecurity
Description: Checks Strict-Transport-Security header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -
#>

function CheckStrictTransportSecurity () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Strict-Transport-Security*******" -ForegroundColor White -Backgroundcolor DarkGreen
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Strict-Transport-Security" ) {
	   $detected = $true 
	   Write-Host " Strict-Transport-Security Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i] ; UpdateReport "#a#" $DetectedValue ; 	
	   $CompliantValue = $Compliance[0]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
       $Annotations = "" 
	   
	   try{
	  
	     foreach ($directive in $CompliantValue){
			  if( $DetectedValue.replace(" ","") -match $directive.replace(" ","") ) { 
		      $global:Score = $global:Score +5
			  Write-Host " directive" $directive  " it is compliant! " -ForegroundColor green
		      } 
		   else {
			  Write-Host " directive" $directive  " not found! " -ForegroundColor red
			  $Annotations += Write-Output "Missing directive '"$directive"'!</p><p>"

		   }
			
		
			
	     }

	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}

if($detected -eq $true) {

if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#a2#</span
"@
UpdateReport "#a2#"  $Green
UpdateReport "#a2#"  "Compliant!"	
}
else {
$Red = @"
<span style="color: #ff0000;">#a2#</span
"@
UpdateReport "#a2#" $Red
UpdateReport "#a2#"  $Annotations
}
	
}

else {
	Write-Host " Strict-Transport-Security Header not found!" -ForegroundColor red
	UpdateReport "#a#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#a2#"  $Missing
	
   }
   

   
Write-Host "`n"
return
	
}

<#
Function name: CheckXFrameOptions
Description: Checks X-Frame-Options header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckXFrameOptions () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******X-Frame-Options*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	 
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "X-Frame-Options" ) {
		 $detected = $true 
	     Write-Host " X-Frame-Options Header detected!" -ForegroundColor green
	     $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#b#" $DetectedValue ; 
	   $CompliantValue = $Compliance[1]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " X-Frame-Options Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +5
		   
		   } 
		   
		   else {
			  
			  Write-Host " X-Frame-Options Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{}
	   
	
	
	
	 }
	$i++
	}
	  
if($detected -eq $true) {
if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#b2#</span
"@
UpdateReport "#b2#"  $Green
UpdateReport "#b2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#b2#</span
"@
UpdateReport "#b2#" $Red
UpdateReport "#b2#"  $Annotations
}
	
}

else {
	Write-Host " X-Frame-Options Header not found!" -ForegroundColor red
	UpdateReport "#b#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#b2#"  $Missing
	
   }
   
Write-Host "`n"	
return
	
}

<#
Function name: CheckXContentTypeOptions
Description: Checks X-Content-Type-Options header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckXContentTypeOptions () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******X-Content-Type-Options*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "X-Content-Type-Options" ) {
	   $detected = $true 
	   Write-Host " X-Content-Type-Options Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#c#" $DetectedValue ; 
	   $CompliantValue = $Compliance[2]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " X-Content-Type-Options Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +5
		   
		   } 
		   
		   else {
			  
			  Write-Host " X-Content-Type-Options Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#c2#</span
"@
UpdateReport "#c2#"  $Green
UpdateReport "#c2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#c2#</span
"@
UpdateReport "#c2#" $Red
UpdateReport "#c2#"  $Annotations
}
	
}

else {
	Write-Host "X-Content-Type-Options Header not found!" -ForegroundColor red 
	UpdateReport "#c#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#c2#"  $Missing
	
   }
   
Write-Host "`n"	
return
	
}

<#
Function name: CheckContentSecurityPolicy
Description: Checks Content-Security-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckContentSecurityPolicy () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Content-Security-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Content-Security-Policy" ) {
	   $detected = $true 
	   Write-Host " Content-Security-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#d#" $DetectedValue ; 
	   $CompliantValue = $Compliance[3]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	     foreach ($directive in $CompliantValue){
			  if( $DetectedValue.replace(" ","") -match $directive.replace(" ","") ) { 
		      $global:Score = $global:Score +1
			  Write-Host " directive" $directive  " it is compliant! " -ForegroundColor green
		      } 
		   else {
			  Write-Host " directive" $directive  " not found! " -ForegroundColor red
			  $Annotations += Write-Output "Missing directive '"$directive"'!</p><p>"
		   }
			
		
			
	     }

	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#d2#</span
"@
UpdateReport "#d2#"  $Green
UpdateReport "#d2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#d2#</span
"@
UpdateReport "#d2#" $Red
UpdateReport "#d2#"  $Annotations
}
	
}

else {
	Write-Host " X-Content-Type-Options Header not found!" -ForegroundColor red
	UpdateReport "#d#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#d2#"  $Missing
	
   }
	
	
Write-Host "`n"
return
	
}

<#
Function name: CheckXPermittedCrossDomainPolicies
Description: Checks X-Permitted-Cross-Domain-Policies header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckXPermittedCrossDomainPolicies () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******X-Permitted-Cross-Domain-Policies*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "X-Permitted-Cross-Domain-Policies" ) {
	   $detected = $true 
	   Write-Host " X-Permitted-Cross-Domain-Policies Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#e#" $DetectedValue ; 
	   $CompliantValue = $Compliance[4]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " X-Permitted-Cross-Domain-Policies Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +5
		   
		   } 
		   
		   else {
			  
			  Write-Host " X-Permitted-Cross-Domain-Policies Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#e2#</span
"@
UpdateReport "#e2#"  $Green
UpdateReport "#e2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#e2#</span
"@
UpdateReport "#e2#" $Red
UpdateReport "#e2#"  $Annotations
}
	
}

else {
	Write-Host " X-Permitted-Cross-Domain-Policies Header not found!" -ForegroundColor red
	UpdateReport "#e#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#e2#"  $Missing
	
   }
	
	
Write-Host "`n"	
return
	
}

<#
Function name: CheckReferrerPolicy
Description: Checks Referrer-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckReferrerPolicy () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Referrer-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Referrer-Policy" ) {
	   $detected = $true 
	   Write-Host " Referrer-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#f#" $DetectedValue ; 
	   $CompliantValue = $Compliance[5]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " Referrer-Policy Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +5
		   
		   } 
		   
		   else {
			  
			  Write-Host " Referrer-Policy Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#f2#</span
"@
UpdateReport "#f2#"  $Green
UpdateReport "#f2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#f2#</span
"@
UpdateReport "#f2#" $Red
UpdateReport "#f2#"  $Annotations
}
	
}

else {
	Write-Host "Referrer-Policy Header not found!" -ForegroundColor red
	UpdateReport "#f#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#f2#"  $Missing
	
   }	
	
	
Write-Host "`n"	
return
	
}

<#
Function name: CheckClearSiteData
Description: Checks Clear-Site-Data header compliance status
Function calls: UpdateReport , WriteCompliantValue2
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckClearSiteData () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Clear-Site-Data*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Clear-Site-Data" ) {
	   $detected = $true 
	   Write-Host " Clear-Site-Data Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#g#" $DetectedValue ; 
	   $CompliantValue = $Compliance[6]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue2 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	     foreach ($directive in $CompliantValue){
			  if( $DetectedValue.replace(" ","") -match $directive.replace(" ","") ) { 
		      $global:Score = $global:Score +1
			  Write-Host " directive" $directive  " it is compliant! " -ForegroundColor green
		      } 
		   else {
			  Write-Host " directive" $directive  " not found! " -ForegroundColor red
			  $Annotations += Write-Output "Missing directive '"$directive"'!</p><p>"
		   }
			
		
			
	     }

	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#g2#</span
"@
UpdateReport "#g2#"  $Green
UpdateReport "#g2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#g2#</span
"@
UpdateReport "#g2#" $Red
UpdateReport "#g2#"  $Annotations
}
	
}

else {
	Write-Host " Clear-Site-Data Header not found!" -ForegroundColor red
    UpdateReport "#g#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#g2#"  $Missing
	
   } 	
	
	
Write-Host "`n"	
return
	
}

<#
Function name: CheckCrossOriginEmbedderPolicy
Description: Checks Cross-Origin-Embedder-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckCrossOriginEmbedderPolicy () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Cross-Origin-Embedder-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match " Cross-Origin-Embedder-Policy" ) {
	   $detected = $true 
	   Write-Host "Cross-Origin-Embedder-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +1
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#h#" $DetectedValue ; 
	   $CompliantValue = $Compliance[7]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " Cross-Origin-Embedder-Policy Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +1
		   
		   } 
		   
		   else {
			  
			  Write-Host " Cross-Origin-Embedder-Policy Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#h2#</span
"@
UpdateReport "#h2#"  $Green
UpdateReport "#h2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#h2#</span
"@
UpdateReport "#h2#" $Red
UpdateReport "#h2#"  $Annotations
}
	
}

else {
	Write-Host " Cross-Origin-Embedder-Policy Header not found!" -ForegroundColor red
    UpdateReport "#h#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#h2#"  $Missing
	
   }
	
	
Write-Host "`n"	
return
	
}

<#
Function name: CheckCrossOriginOpenerPolicy
Description: Checks Cross-Origin-Opener-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckCrossOriginOpenerPolicy() {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Cross-Origin-Opener-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Cross-Origin-Opener-Policy" ) {
	   $detected = $true 
	   Write-Host " Cross-Origin-Opener-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +1
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#i#" $DetectedValue ; 
	   $CompliantValue = $Compliance[8]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " Cross-Origin-Opener-Policy Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +1
		   
		   } 
		   
		   else {
			  
			  Write-Host " Cross-Origin-Opener-Policy Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#i2#</span
"@
UpdateReport "#i2#"  $Green
UpdateReport "#i2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#i2#</span
"@
UpdateReport "#i2#" $Red
UpdateReport "#i2#"  $Annotations
}
	
}

else {
	Write-Host " Cross-Origin-Opener-Policy Header not found!" -ForegroundColor red
    UpdateReport "#i#" "-" 	
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#i2#"  $Missing
	
   
 }
 
Write-Host "`n"	
return
	
}

<#
Function name: CheckCrossOriginResourcePolicy
Description: Checks Cross-Origin-Resource-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckCrossOriginResourcePolicy() {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Cross-Origin-Resource-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Cross-Origin-Resource-Policy" ) {
	   $detected = $true 
	   Write-Host " Cross-Origin-Resource-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +1
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#j#" $DetectedValue ; 
	   $CompliantValue = $Compliance[9]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " Cross-Origin-Resource-Policy Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +1
		   
		   } 
		   
		   else {
			  
			  Write-Host " Cross-Origin-Resource-Policy Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#j2#</span
"@
UpdateReport "#j2#"  $Green
UpdateReport "#j2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#j2#</span
"@
UpdateReport "#j2#" $Red
UpdateReport "#j2#"  $Annotations
}
	
}

else {
	Write-Host " Cross-Origin-Resource-Policy Header not found!" -ForegroundColor red
    UpdateReport "#j#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#j2#"  $Missing
	
   }


Write-Host "`n"
return
	
}

<#
Function name: CheckPermissionsPolicy
Description: Checks Permissions-Policy header compliance status
Function calls: UpdateReport , WriteCompliantValue2
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckPermissionsPolicy () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Permissions-Policy*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Permissions-Policy" ) {
	   $detected = $true 
	   Write-Host " Permissions-Policy Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#k#" $DetectedValue ; 
	   $CompliantValue = $Compliance[10]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue2 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	     foreach ($directive in $CompliantValue){
			  if( $DetectedValue.replace(" ","") -match $directive.replace(" ","").replace("(","\(").replace(")","\)").replace("*","\*")    ) { 
		      $global:Score = $global:Score +0.1
			  Write-Host " directive" $directive  " it is compliant! " -ForegroundColor green
		      } 
		   else {
			  Write-Host " directive" $directive  " not found! " -ForegroundColor red
			  $Annotations += Write-Output "Missing directive '"$directive"'!</p><p>"
		   }
			
		
			
	     }

	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#k2#</span
"@
UpdateReport "#k2#"  $Green
UpdateReport "#k2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#k2#</span
"@
UpdateReport "#k2#" $Red
UpdateReport "#k2#"  $Annotations
}
	
}

else {
	Write-Host " Permissions-Policy Header not found!" -ForegroundColor red
    UpdateReport "#k#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#k2#"  $Missing
	
   
	}
	
Write-Host "`n"
return
	
}

<#
Function name: CheckCacheControl
Description: Checks Cache-Control header compliance status
Function calls: UpdateReport , WriteCompliantValue2
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckCacheControl () {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Cache-Control*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Cache-Control" ) {
	   $detected = $true 
	   Write-Host " Cache-Control Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +5
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#l#" $DetectedValue ; 
	   $CompliantValue = $Compliance[11]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue2 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	     foreach ($directive in $CompliantValue){
			  if( $DetectedValue.replace(" ","") -match $directive.replace(" ","") ) { 
		      $global:Score = $global:Score +2.5
			  Write-Host " directive" $directive  " it is compliant! " -ForegroundColor green
		      } 
		   else {
			  Write-Host " directive" $directive  " not found! " -ForegroundColor red
			  $Annotations += Write-Output "Missing directive '"$directive"'!</p><p>"
		   }
			
		
			
	     }

	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#l2#</span
"@
UpdateReport "#l2#"  $Green
UpdateReport "#l2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#l2#</span
"@
UpdateReport "#l2#" $Red
UpdateReport "#l2#"  $Annotations
}
	
}

else {
	Write-Host " Cache-Control Header not found!" -ForegroundColor red
	UpdateReport "#l#" "-"
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#l2#"  $Missing
	
   }
	
	
Write-Host "`n"	
return
	
}

<#
Function name: CheckPragma
Description: Checks Pragma header compliance status
Function calls: UpdateReport , WriteCompliantValue1
Input:  $HttpHeaders ,$Compliance 
Output: -

#>

function CheckPragma() {
	param(
	[Parameter(Mandatory = $True)] $HttpHeaders ,
	[Parameter(Mandatory = $True)] $Compliance 
	
    )
	
	$detected = $false
	Write-Host "*******Pragma*******" -ForegroundColor White -Backgroundcolor DarkGreen
	
	$i=0
	foreach ($header in  $HttpHeaders){
	
	 if ($header -match "Pragma" ) {
	   $detected = $true 
	   Write-Host " Pragma Header detected!" -ForegroundColor green
	   $global:Score = $global:Score +1
	
	
	   $DetectedValue  = $HttpHeaders[$i]	; UpdateReport "#m#" $DetectedValue ; 
	   $CompliantValue = $Compliance[12]
	   Write-Host " Detected Value : " $DetectedValue 
	   Write-Host " Compliant Value : " -nonewline
	   WriteCompliantValue1 $CompliantValue
	   
	   $Annotations = "" 
	   
	   try{
	  
	   	   if( $DetectedValue.replace(" ","") -match $CompliantValue.replace(" ","") ) { 
		   Write-Host " Pragma Header is compliant!" -ForegroundColor green
		   $global:Score = $global:Score +1
		   
		   } 
		   
		   else {
			  
			  Write-Host " Pragma Header it is not compliant! " -ForegroundColor red
			  $Annotations += Write-Output " Directive not compliant!`n"
    	   
		   }
	   }
	   
	   catch{ }
	   
	
	
	
	 }
	$i++
	}
	  

if($detected -eq $true) {
	if ($Annotations -eq "") {
$Green = @"
<span style="color: #339966;">#m2#</span
"@
UpdateReport "#m2#"  $Green
UpdateReport "#m2#"  "Compliant!"	
}
else {

$Red = @"
<span style="color: #ff0000;">#m2#</span
"@
UpdateReport "#m2#" $Red
UpdateReport "#m2#"  $Annotations
}
	
}

else {
	Write-Host " Pragma Header not found!" -ForegroundColor red
	UpdateReport "#m#" "-" 
$Missing = @"
<span style="color: #ff0000;">Missing header!</span
"@
	UpdateReport "#m2#"  $Missing
	
  }
  
Write-Host "`n"	
return
	
}