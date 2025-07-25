<#
replacing lines:

$text = "Lorem ipsum dolor sit amet"
Write-Host -NoNewLine "$text`r"
Start-Sleep -Seconds 2
Write-Host -NoNewLine ("`b" * $text.Length)
Write-Host "consectetur adipiscing elit"

source: https://stackoverflow.com/questions/30240715/how-to-edit-the-text-that-was-already-written-to-console-with-powershell
#>
echo "Press Ctrl-C|Strg-C to stop at any point"
$Species_Data = Get-Content "species-data.json"
#$Species_Data = ConvertTo-Json $Species_Data
$Species_Data = $Species_Data | ConvertFrom-Json 

# echo $Species_Data
[int]$indexy = Read-Host "What species do you want your character to be? 
0: Dwarf
1: Elf
2: Halfling
3: Human
5: Gnome
6: Half-Elf
7: Half-Orc
8: Tiefling
Answer"

$Species_Data = $Species_Data.body[$indexy]

if  ($Species_Data.Has_Subtype) {
    for ($i = 0; $i -lt $Species_Data.Subtypes.length; $i++) {
        $temp = $Species_Data.Subtypes[$i].Name
        $formatted = "$formatted[$i]:$temp
        "
    }
    [int]$indexy = Read-Host "What subtype do you want your character to be?
    $formatted Answer" 
    $Has_Subtype = true
    $Subtype_Data =  $Species_Data.Subtypes[$indexy]
}