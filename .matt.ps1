$Username = $Env:UserName

[string]$LinuxHome = "LinuxHome"
[string]$WinHome = "WinHome"
[string]$WinWork = "WinWork"

[string][ValidateSet("LinuxHome", "WinHome", "WinWork")]$WhereAmI = "LinuxHome"



if ($IsLinux)
{
    $WhereAmI = $LinuxHome
}
else 
{
    if ($Env:ComputerName -like "P*")
    {
        $WhereAmI = $WinWork
    }
    else 
    {
        $WhereAmI = $WinHome    
    }
}
# Set up stuff specific to this particular PC or environment

if ($WhereAmI -eq $LinuxHome)
{
    $HomeMatt = '/home/matt'
    
    $PowershellFolder = join-path $HomeMatt "powershell"
    $env:PSModulePath = $env:PSModulePath + ":/home/matt/powershell/modules"
    set-executionpolicy bypass -Scope Process
    $ENV:PAth = $Env:Path + ";/home/matt/sdcard/hugo/bin"
    $Images = "$HomeMatt/salisburyandstonehenge.net/static/images"
    $Sas = "$HomeMatt/salisburyandstonehenge.net"
  
}
else 
{
    $HomeMatt = "c:\matt"

    $PowershellFolder = join-path "c:" "powershell"

    if (test-path c:\matt\local\set-LocalEnvironment.ps1)
    {
        . c:\matt\local\set-LocalEnvironment.ps1
    }
    if (test-path 'C:\Program Files\Vim\vim74\gvim.exe')
    {
        set-alias gvim 'C:\Program Files\Vim\vim74\gvim.exe'
    }
    else
    {
        set-alias gvim 'C:\Program Files (x86)\Vim\vim74\gvim.exe'
    }
    
    import-module WindowsStuff
    import-module SqlStuff
        
}




if ($WhereAmI -ne $WinWork)
{
    function cdhugo { cd $(Join-Path $HomeMatt "salisburyandstonehenge.net") }
    function cdodt { cd $(Join-Path $HomeMatt "salisburyandstonehenge.net/content/on-this-day") }
    function cdpic { cd $(Join-Path $HomeMatt "salisburyandstonehenge.net/static/images") }
    set-alias cdotd cdodt
       

    <#
        function runhugo {cd /home/matt/salisburyandstonehenge.net ; d:/hugo/bin/hugo server -w  --renderToDisk --theme hyde}
        function rundocs {cd /home/matt/sdcard/hugo/sites/docs ; d:/hugo/bin/hugo server -w -v --renderToDisk -p 1314}
        set-alias rundoc rundocs
    #>
    #  $OLD = "/home/matt/sdcard/hugo/sites/example.com/content/on-this-day"
    $OTD = join-path $HomeMatt "salisburyandstonehenge.net/content/on-this-day"
}


if (!($PowershellFolder))
{
    $PowershellFolder = "C:\Users\$Username\Documents\windowspowershell"
}
cd $PowershellFolder

$Modules = join-path $PowershellFolder "modules"
$env:PSModulePath = "$env:PSModulePath;$Modules;$PowershellFolder/work_in_progress"
$Scripts = join-path $PowershellFolder "Scripts"
$Functions = join-path $PowershellFolder "Functions"
set-alias ebook cdbook

function cdmod {cd $Modules}
function cdfun {cd $Functions}
function cdscripts {cd $scripts}
function cdwip {cd $PowershellFolder/work_in_progress}
function cdph {cd $PowershellFolder/modules/poshhugo}
function cdbook {cd C:/Users/$Username/Documents/a-unix-persons-guide-to-powershell}

$FunctionsFolder = "$PowershellFolder/functions"

$env:path = $env:path + ";" + $PowershellFolder + ";" + $FunctionsFolder

$VerbosePreference = "Continue"



write-verbose "About to load functions"
foreach ($FUNC in $(select-string Autoload $FunctionsFolder/*.ps1))
{

  $FunctionToAutoload = $Func.Path
  . $FunctionToAutoload
}

write-verbose "About to non-githubbed functions functions"
foreach ($FUNC in $(select-string Autoload $UnGithubbedFunctionsFolder/*.ps1))
{

  $FunctionToAutoload = $Func.Path
  . $FunctionToAutoload
}

function select-StringsFromCode {
<#
.SYNOPSIS
Searches for specified text in functions folder

This function is autoloaded
#>
param ($SearchString)
    select-string $SearchString $FunctionsFolder/*.ps1 | select path, line
    select-string $SearchString $Modules/*.psm1 | select path, line
    select-string $SearchString $UnGithubbedFunctionsFolder/*.ps1 | select path, line

}

set-alias sfs select-StringsFromCode
set-alias gfs sfs

$DEBUGPREFERENCE = "SilentlyContinue"
$VerbosePreference = "SilentlyContinue"


Import-Module z
import-module PersonalStuff
import-module -force PSReadLine

function prompt { [string]$x=$pwd
    $x = $x -replace '/home/matt',''
    $x = $x -replace '/sdcard',''
    $x = $x -replace '/salisburyandstonehenge.net','s.net'
    $x = $x -replace '/mattypenny.net','s.net'
        "$x >"   }

        $HistoryFile = Join-Path $PowershellFolder -ChildPath 'history'
        
        $HistoryFile = Join-Path $HistoryFile -ChildPath 'ExportedHistory.xml'
function export-history {
    Get-History | Export-Clixml $HistoryFile
}

set-alias ehh export-history
set-alias eh export-history
set-alias gh export-history

Add-History -InputObject (Import-Clixml -Path $HistoryFile)

