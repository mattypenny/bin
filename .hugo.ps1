function cdhugo { cd D:\hugo\sites\example.com }
function cdodt { cd D:\hugo\sites\example.com\content\on-this-day }
$ENV:PAth = $Env:Path + ";D:\hugo\bin"
cdhugo

# function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w -v --renderToDisk --theme hyde}
function runhugo {cd D:\hugo\sites\example.com ; d:\hugo\bin\hugo server -w  --renderToDisk --theme hyde}
function rundocs {cd D:\hugo\sites\docs ; d:\hugo\bin\hugo server -w -v --renderToDisk -p 1314}
set-alias rundoc rundocs
