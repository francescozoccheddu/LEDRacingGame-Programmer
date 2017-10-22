Param(
    [string]$projdir="C:\Users\zocch\Onedrive\Unica\ARE",
    [string]$projname="ARE",
    [string]$scriptfile=".\map2json.py"
)
$sources = Get-ChildItem "$projdir\$projname\*.asm"
python $scriptfile "$projdir\$projname\Debug\$projname.map" "$projdir\$projname\Debug\$projname.eep" $sources