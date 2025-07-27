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
$Weapons = [System.Collections.Generic.List[object]]::new()

$Attacks = [System.Collections.Generic.List[object]]::new()
$Inventory = [System.Collections.Generic.List[object]]::new()
$Proficiencies =  [System.Collections.Generic.List[object]]::new()
$Skill_Proficiencies =  [System.Collections.Generic.List[object]]::new()#
$Traits = [System.Collections.Generic.List[object]]::new()

$Suggested_Scores = @("15","14","13","12","10","8")
$Scores = [pscustomobject]@{STR = ""; DEX = ""; WIS = ""; CON = ""; INT = ""; CHA = "";}
$Score_Modifiers = [pscustomobject]@{STR = ""; DEX = ""; WIS = ""; CON = ""; INT = ""; CHA = "";}


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

$Species_Data = $Species_Data[$indexy]

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

for ($i = 0; $i -lt $Species_Data.Traits.Length; $i++) {
    $Traits.Add($Species_Data.Traits[$i]);
}

if ($Has_Subtype) {
    for ($i = 0; $i -lt $Subtype_Data.Traits.Length; $i++) {
        $Traits.Add($Subtype_Data.Traits[$i]);
    }
}



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

for ($i = 0; $i -lt $Class_Data.Equipment.Length; $i++) {
    if ($Class_Data.Equipment[$i].GetType().Name -eq "Object[]") {
        # if it's an array
        # turn both into strings
        if ($Class_Data.Equipment[$i][0].Weapon -like "*/*") {
            $temp = ""
            #echo "WILDCARDS!!!!"
            $tempy = $Class_Data.Equipment[$i][0].Weapon -split '/'
            for ($n = 1; $n -lt $tempy.Length; $n++){
                $temp = $temp + " " + $tempy[$n]
            }
            $temp = $temp + "weapon"
        } else {$temp = $Class_Data.Equipment[$i][0].Weapon}
        $first_choice = $number_words[$Class_Data.Equipment[$i][0].Amount] + " " + $temp.ToLower()
        if ($Class_Data.Equipment[$i][0].Amount -gt 1) {$first_choice = $first_choice + "s"}
        if ($Class_Data.Equipment[$i][1].Weapon -like "*/*") {
            $temp = ""
            #echo "WILDCARDS!!!!"
            $tempy = $Class_Data.Equipment[$i][1].Weapon -split "/"
            #echo $tempy
            for ($n = 1; $n -lt $tempy.Length; $n++){
                $temp = $temp + " " + $tempy[$n]
            }
            $temp = $temp + " weapon"
        } else {$temp = $Class_Data.Equipment[$i][0].Weapon}
        $second_choice = $number_words[$Class_Data.Equipment[$i][1].Amount] + " " + $temp.ToLower()
        if ($Class_Data.Equipment[$i][1].Amount -gt 1) {$second_choice = $second_choice + "s"}
        [int]$indexy = Read-Host "Choose [enter the number]:
        0: $first_choice
        1: $second_choice
        Answer"
        for ($n = 0; $n -lt $Class_Data.Equipment[$i][$indexy].Amount; $n++) {
            $Weapons.Add($Class_Data.Equipment[$i][$indexy].Weapon)
        }
    } else {
        for ($n = 0; $n -lt $Class_Data.Equipment[$i].Amount; $n++) {
            $Weapons.Add($Class_Data.Equipment[$i].Weapon)
        }
    }

}

for ($i = 0; $i -lt $Class_Data.Inventory.Length; $i++) {
    if ($Class_Data.Inventory[$i].GetType().Name -eq "Object[]") {
        # if it's an array
        # turn both into strings
        $temp = $Class_Data.Equipment[$i][0].Weapon
        $first_choice = $number_words[$Class_Data.Equipment[$i][0].Amount] + " " + $temp.ToLower()
        if ($Class_Data.Equipment[$i][0].Amount -gt 1) {$first_choice = $first_choice + "s"}
        $temp = $Class_Data.Equipment[$i][0].Weapon
        $second_choice = $number_words[$Class_Data.Equipment[$i][1].Amount] + " " + $temp.ToLower()
        if ($Class_Data.Equipment[$i][1].Amount -gt 1) {$second_choice = $second_choice + "s"}
        [int]$indexy = Read-Host "Choose [enter the number]:
        0: $first_choice
        1: $second_choice
        Answer"
        for ($n = 0; $n -lt $Class_Data.Equipment[$i][$indexy].Amount; $n++) {
            $Inventory.Add($Class_Data.Equipment[$i][$indexy].Weapon)
        }
    } else {
        for ($n = 0; $n -lt $Class_Data.Inventory[$i].Amount; $n++) {
            $Inventory.Add($Class_Data.Inventory[$i].Weapon)
        }
    }

}

for ($i = 0; $i -lt $Class_Data.Proficiencies.Length; $i++) {
    if ($Proficiencies -contains $Class_Data.Proficiencies[$i]) {} else {
        $Proficiencies.Add($Class_Data.Proficiencies[$i])
    }
}

for ($i = 0; $i -lt $Class_Data.Skill_Proficiencies.Length; $i++) {
    if ($Class_Data.Skill_Proficiencies[$i].GetType().Name -eq "Object[]") {
        #if array
        $formatted = ""
        for ($n = 0; $n -lt $Class_Data.Skill_Proficiencies[$i].Length; $n++) {
        $temp = $Class_Data.Skill_Proficiencies[$i][$n]
        $formatted = "$formatted[$n]:$temp
        "
        }
        [int]$indexy = Read-Host "Which of these proficiencies do you want?
        $formatted Answer" 
    }
    if ($Skill_Proficiencies -contains $Class_Data.Skill_Proficiencies[$i]) {} else {
        $Skill_Proficiencies.Add($Class_Data.Skill_Proficiencies[$i])
    }
}

for ($i = 0; $i -lt $Class_Data.Traits.Length; $i++) {
    $Traits.Add($Class_Data.Traits[$i]);
}
#>
echo "Each score [Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma] gets one of these scores : $Suggested_Scores "
$temporary = @("STR", "DEX", "CON", "INT", "WIS", "CHA")
for ($i = 0; $i -lt $Suggested_Scores.Length; $i++) {
    
    [string]$temp = $Suggested_Scores[$i]
    echo $temp
    <#[0]: Strength
    [1]: Dexterity
    [2]: Constitution
    [3]: Intelligence
    [4]: Wisdom
    [5]: Charisma#>
    $formatted = ""
    for ($n = 0; $n -lt $temporary.Length; $n++) { # weird bug on last one for some reason :/, removing last line for that go-through fixes it but like noooooooooo
        $formatted = "$formatted[$n]:"
        $tempy = $temporary[$n]
        $formatted = "$formatted $tempy
        "
    }
    [int]$indexy = Read-Host "Which ability would you like to have a score of $temp ?
    $formatted\Answer"
    
    $temp = $temporary[$indexy]

    $Scores.$temp = $Suggested_Scores[$i]
    # https://www.reddit.com/r/PowerShell/comments/10wrxbr/underrated_way_of_removing_item_from_array/
    if ($i -ne 4) {$temporary = $temporary | Where-Object -FilterScript {$_ -ne $temp}} 
}

$temporary = @("STR", "DEX", "CON", "INT", "WIS", "CHA")
for ($i = 0; $i -lt $temporary.Length; $i++) {
    #$mod/2 - (($mod/2) % 1)) - 5
    [int]$temp = $Scores.$temporary[$i]
    $Score_Modifiers.$temporary[$i] = $temp/2 - (($temp/2) % 1) - 5
}