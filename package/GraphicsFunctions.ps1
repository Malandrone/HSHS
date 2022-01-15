<#
Function name: PrintLogo 
Description: Displays the HSHS logo and some info about the module   
Function calls: -
Input: -
Output: -   
#>

function PrintLogo( ) {
    param(  )
	
$logo = @' 

      ___           ___           ___           ___     
     /__/\         /  /\         /__/\         /  /\    
     \  \:\       /  /:/_        \  \:\       /  /:/_   
      \__\:\     /  /:/ /\        \__\:\     /  /:/ /\  
  ___ /  /::\   /  /:/ /::\   ___ /  /::\   /  /:/ /::\ 
 /__/\  /:/\:\ /__/:/ /:/\:\ /__/\  /:/\:\ /__/:/ /:/\:\
 \  \:\/:/__\/ \  \:\/:/~/:/ \  \:\/:/__\/ \  \:\/:/~/:/
  \  \::/       \  \::/ /:/   \  \::/       \  \::/ /:/ 
   \  \:\        \__\/ /:/     \  \:\        \__\/ /:/  
    \  \:\         /__/:/       \  \:\         /__/:/   
     \__\/         \__\/         \__\/         \__\/    


'@                                                           
# generated on http://www.patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20


$slogan ="             HTTP Security Headers Scanner"

$about = @'

-Version    : 1.0   
-Author     : Giuseppe Malandrone 
-Email      : giuseppe.malandrone@numera.it
-Company    : Numera Sistemi e Informatica S.p.A
-Department : Ufficio Sicurezza Informatica 
'@



Write-Host $logo -Foregroundcolor green
Write-Host $slogan -Foregroundcolor green
Write-Host $about
Write-Host "`n`r"  
   

    return
}

<#
Function name: WriteCompliantValue1
Description: Displays the HTTP header compliant value formatted with ; symbols 
Function calls: -
Input: $Value
Output: -   
#>

function WriteCompliantValue1 () {
	param(
	[Parameter(Mandatory = $True)] $Value 
    )


$i=0
        while ($i -lt (($Value.length).length) ){
         Write-Host $Value[$i] -nonewline  -ForegroundColor green 
         if ( $i -lt         ((($Value.length).length) -1)    ) { Write-Host " ; "  -nonewline  -ForegroundColor green }
         $i++
         }
        Write-Host "`n"
return 
}

<#
Function name: WriteCompliantValue2
Description: Displays the HTTP header compliant value formatted with , symbols 
Function calls: -
Input: $Value
Output: -   
#>

function WriteCompliantValue2 () {
	param(
	[Parameter(Mandatory = $True)] $Value 
    )


$i=0
        while ($i -lt (($Value.length).length) ){
         Write-Host $Value[$i] -nonewline  -ForegroundColor green 
         if ( $i -lt         ((($Value.length).length) -1)    ) { Write-Host " , "  -nonewline  -ForegroundColor green }
         $i++
         }
        Write-Host "`n"
return 
}
