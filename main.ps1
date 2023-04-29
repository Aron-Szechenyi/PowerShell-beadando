# This code converts X3D files to DXF files 
# Author: Áron Széchenyi
# Date: 2023.04.22.
# NEPTUN CODE: A3KWH7
# usage: .\main.ps1 from.x3d to.dxf

<#
App's entry point
#>

. ./"Parser.ps1"
. ./"Builder.ps1"


$Parser = [Parser]::new($args[0])
$Parser.Parse()

if($Parser.GetError()){
    Write-Host $Parser.GetErrorMsg()
    exit
}

$Builder = [Builder]::new($Parser.GetCoords(),$Parser.GetIndexes())

$Builder.Build().Write($args[1])
