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
$Species_Data = $Species_Data | ConvertFrom-Json 
$number_words = @("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen")

$Class_Data = Get-Content "class_data.json"
$Class_Data = $Class_Data | ConvertFrom-Json 
<#
echo $Class_Data[0].Equipment[2].GetType()
if ($Class_Data[0].Equipment[0].GetType().Name -eq "Object[]") {echo "hi"}
#>

# echo $Species_Data
<#
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
#>

[int]$indexy = Read-Host "What class do you want your character to be? 
0: Barbarian
1: Bard
2: Cleric
3: Druid
4: Fighter
5: Monk
6: Paladin
7: Ranger
8: Rogue
9: Sorcerer
10: Warlock
11: Wizard
Answer"

$Class_Data = $Class_Data[$indexy]
$arraya = $Class_Data.Equipment.Length -split " "
[int]$arraya = $arraya[0]
for ($i = 0; $i -lt $arraya, $i++) {
    if ($Class_Data.Equipment[$i].GetType().Name -eq "Object[]") {
        # if it's an array
        # turn both into strings
        $first_choice = $number_words[$Class_Data.Equipment[$i][0].Amount] + " " + $Class_Data.Equipment[$i][0].Weapon
        if ($Class_Data.Equipment[$i][0].Amount -gt 1) {$first_choice = $first_choice + "s"}
        $second_choice = $number_words[$Class_Data.Equipment[$i][0].Amount] + " " + $Class_Data.Equipment[$i][0].Weapon
        if ($Class_Data.Equipment[$i][0].Amount -gt 1) {$second_choice = $second_choice + "s"}
    }
}