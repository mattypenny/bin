$Username = $Env:UserName

# change title
$Host.UI.RawUI.WindowTitle = $env:USERNAME

# Set up stuff specific to this particular PC or environment
. c:\local\set-LocalEnvironment.ps1

if (test-path 'C:\Program Files\Vim\vim74\gvim.exe')
{
    set-alias gvim 'C:\Program Files\Vim\vim74\gvim.exe'
}
else
{
    set-alias gvim 'C:\Program Files (x86)\Vim\vim74\gvim.exe'
}

if (test-path 'd:\hugo')
{
    function cdhugo { cd D:\hugo\sites\example.com }
    function cdodt { cd D:\hugo\sites\example.com\content\on-this-day }
    set-alias cdotd cdodt
    $ENV:PAth = $Env:Path + ";D:\hugo\bin"

    # function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w -v --renderToDisk --theme hyde}
    function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w  --renderToDisk --theme hyde}
    function rundocs {cd D:\hugo\sites\docs ; d:\hugo\bin\hugo server -w -v --renderToDisk -p 1314}
    set-alias rundoc rundocs
}

if (test-path C:\powershell)
{
    $PowershellFolder = "C:\powershell"
}
else
{
    $PowershellFolder = "C:\Users\$Username\Documents\windowspowershell"
}
cd $PowershellFolder

$Modules = "$PowershellFolder\Modules" 
$env:PSModulePath = "$env:PSModulePath;$Modules"
$Scripts = "$PowershellFolder\Scripts" 
$Functions = "$PowershellFolder\Functions" 
set-alias ebook cdbook

function cdmod {cd $PowershellFolder\Modules}
function cdfun {cd $PowershellFolder\Functions}
function cdscripts {cd $PowershellFolder\scripts}
function cdwip {cd $PowershellFolder\work_in_progress}
function cdbook {cd C:\Users\$Username\Documents\a-unix-persons-guide-to-powershell}
function oldbook {gvim C:\Users\$Username\Documents\zz_old_a-unix-persons-guide-to-powershell\all_the_details.txt} 


$FunctionsFolder = "$PowershellFolder\functions"

$env:path = $env:path + ";" + $PowershellFolder + ";" + $FunctionsFolder

 
$VerbosePreference = "Continue"

write-verbose "BaseFolder $PowershellFolder"
write-verbose "FunctionsFolder $FunctionsFolder"
write-verbose "env:path $env:path"



write-verbose "About to load functions"
foreach ($FUNC in $(select-string Autoload $FunctionsFolder\*.ps1))
{

  $FunctionToAutoload = $Func.Path
  write-verbose "Loading $FunctionToAutoload.... "
  . $FunctionToAutoload
}

write-verbose "About to non-githubbed functions functions"
foreach ($FUNC in $(select-string Autoload $UnGithubbedFunctionsFolder\*.ps1))
{

  $FunctionToAutoload = $Func.Path
  write-verbose "Loading $FunctionToAutoload.... "
  . $FunctionToAutoload
}

function select-StringsFromCode {
<#
.SYNOPSIS
Searches for specified text in functions folder

This function is autoloaded
#>
 param ($SearchString) 
 select-string $SearchString $FunctionsFolder\*.ps1 | select path, line
 select-string $SearchString $Modules\*.psm1 | select path, line
 select-string $SearchString $UnGithubbedFunctionsFolder\*.ps1 | select path, line

}

set-alias sfs select-StringsFromCode
set-alias gfs sfs

$DEBUGPREFERENCE = "Continue"
$VerbosePreference = "SilentlyContinue"

 

set-executionpolicy bypass



