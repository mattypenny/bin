set-alias gvim 'C:\Program Files\Vim\vim74\gvim.exe'

cd C:\Users\matt\Documents\windowspowershell

function cdmod {cd C:\Users\matt\Documents\WindowsPowerShell\Modules}
function cdfun {cd C:\Users\matt\Documents\WindowsPowerShell\Functions}
function cdscripts {cd C:\Users\matt\Documents\WindowsPowerShell\scripts}
function cdbook {cd C:\Users\matt\Documents\a-unix-persons-guide-to-powershell}
function oldbook {gvim C:\Users\matt\Documents\zz_old_a-unix-persons-guide-to-powershell\all_the_details.txt} 
function cdhugo { cd D:\hugo\sites\example.com }
function cdodt { cd D:\hugo\sites\example.com\content\on-this-day }
set-alias cdotd cdodt
$ENV:PAth = $Env:Path + ";D:\hugo\bin"

# function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w -v --renderToDisk --theme hyde}
function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w  --renderToDisk --theme hyde}
function rundocs {cd D:\hugo\sites\docs ; d:\hugo\bin\hugo server -w -v --renderToDisk -p 1314}
set-alias rundoc rundocs

$Modules = "C:\Users\matt\Documents\WindowsPowerShell\Modules" 
$Scripts = "C:\Users\matt\Documents\WindowsPowerShell\Scripts" 
$Functions = "C:\Users\matt\Documents\WindowsPowerShell\Functions" 
set-alias ebook cdbook

$RepositoryServer = "ronnie"
$BaseDir = "\\$RepositoryServer\c$\users\matt\Documents\WindowsPowershell"
$FunctionsDir = "$BaseDir\functions"

$env:path = $env:path + ";" + $BaseDir + ";" + $FunctionsDir

 
$VerbosePreference = "Continue"

write-verbose "BaseDir $BaseDir"
write-verbose "FunctionsDir $FunctionsDir"
write-verbose "env:path $env:path"


<#
write-verbose "Calling Initialize-SqlpsEnvironment.ps1"
. \\$RepositoryServer\d$\dbawork\admin\bin\Initialize-SqlpsEnvironment.ps1
write-verbose "Done Initialize-SqlpsEnvironment.ps1"
#>

 

write-verbose "About to load functions"
foreach ($FUNC in $(dir $FunctionsDir\*.ps1))
{

  write-verbose "Loading $FUNC.... "
  . $FUNC.FullName
}

$DEBUGPREFERENCE = "Continue"
$VerbosePreference = "SilentlyContinue"

 

set-executionpolicy bypass


cal 

