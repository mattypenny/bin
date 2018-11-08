$Username = $Env:UserName

set-alias gvim vim

# change title
$Host.UI.RawUI.WindowTitle = $env:USERNAME

# Set up stuff specific to this particular PC or environment


    function cdhugo { cd /home/matt/salisburyandstonehenge.net }
    function cdodt { cd /home/matt/salisburyandstonehenge.net/content/on-this-day }
    function cdoodt { cd /home/matt/sdcard/hugo/sites/example.com/content/on-this-day }
    function cdpic { cd /home/matt/salisburyandstonehenge.net/static/images }
    set-alias cdotd cdodt
    $ENV:PAth = $Env:Path + ";/home/matt/sdcard/hugo/bin"

    # function runhugo {cd /home/matt/sdcard/hugo/sites/salisburyandstonehenge.net ; d:/hugo/bin/hugo server -w -v --renderToDisk --theme hyde}
    function runhugo {cd /home/matt/salisburyandstonehenge.net ; d:/hugo/bin/hugo server -w  --renderToDisk --theme hyde}
    function rundocs {cd /home/matt/sdcard/hugo/sites/docs ; d:/hugo/bin/hugo server -w -v --renderToDisk -p 1314}
    set-alias rundoc rundocs
    $OLD = "/home/matt/sdcard/hugo/sites/example.com/content/on-this-day"
    $OTD = "/home/matt/sdcard/hugo/sites/salisburyandstonehenge.net/content/on-this-day"
    $NEW = "/home/matt/salisburyandstonehenge.net/content/on-this-day"

New-PSDrive -Name PoSh -PSProvider FileSystem -root /home/matt/sdcard/powershell 
if (test-path PoSh:)
{
    $PowershellFolder = "PoSh:"
}
else
{
    $PowershellFolder = "C:/Users/$Username/Documents/windowspowershell"
}
# cd $PowershellFolder

$Modules = "$PowershellFolder/modules" 
$env:PSModulePath = "$env:PSModulePath;$Modules;$PowershellFolder/work_in_progress"
$Scripts = "$PowershellFolder/Scripts" 
$Functions = "$PowershellFolder/Functions" 
set-alias ebook cdbook

function cdmod {cd $PowershellFolder/Modules}
function cdfun {cd $PowershellFolder/Functions}
function cdscripts {cd $PowershellFolder/scripts}
function cdwip {cd $PowershellFolder/work_in_progress}
function cdph {cd $PowershellFolder/work_in_progress/poshhugo}
function cdbook {cd C:/Users/$Username/Documents/a-unix-persons-guide-to-powershell}
function oldbook {gvim C:/Users/$Username/Documents/zz_old_a-unix-persons-guide-to-powershell/all_the_details.txt} 


$FunctionsFolder = "$PowershellFolder/functions"

$env:path = $env:path + ";" + $PowershellFolder + ";" + $FunctionsFolder

 
$VerbosePreference = "Continue"

write-verbose "BaseFolder $PowershellFolder"
write-verbose "FunctionsFolder $FunctionsFolder"
write-verbose "env:path $env:path"



write-verbose "About to load functions"
foreach ($FUNC in $(select-string Autoload $FunctionsFolder/*.ps1))
{

  $FunctionToAutoload = $Func.Path
  write-verbose "Loading $FunctionToAutoload.... "
  . $FunctionToAutoload
}

write-verbose "About to non-githubbed functions functions"
foreach ($FUNC in $(select-string Autoload $UnGithubbedFunctionsFolder/*.ps1))
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
 select-string $SearchString $FunctionsFolder/*.ps1 | select path, line
 select-string $SearchString $Modules/*.psm1 | select path, line
 select-string $SearchString $UnGithubbedFunctionsFolder/*.ps1 | select path, line

}

set-alias sfs select-StringsFromCode
set-alias gfs sfs

$DEBUGPREFERENCE = "Continue"
$VerbosePreference = "SilentlyContinue"

 

set-executionpolicy bypass


$Images = "/home/matt/salisburyandstonehenge.net/static/images"
$Sas = "/home/matt/salisburyandstonehenge.net"

$env:USERPROFILE = '/home/matt'                                                                                                 
$env:PSModulePath = $env:PSModulePath + ":/home/matt/powershell/modules"                                                 
ipmo z                                                                                                                          

function prompt { [string]$x=$pwd
	$x = $x -replace '/home/matt',''
	$x = $x -replace '/sdcard',''
	$x = $x -replace '/salisburyandstonehenge.net','s.net'
	$x = $x -replace '/mattypenny.net','s.net'
        "$x >"   }


        $HistoryFile = Join-Path '~' -ChildPath 'powershell' -AdditionalChildPath 'history'
        $HistoryFile = Join-Path $HistoryFile -ChildPath 'ExportedHistory.xml'
function export-history {
    Get-History | Export-Clixml $HistoryFile 
}        

set-alias ehh export-history
set-alias eh export-history
set-alias gh export-history

Add-History -InputObject (Import-Clixml -Path $HistoryFile)

ipmo -force PSReadLine