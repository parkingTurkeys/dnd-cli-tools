param([switch]$Boss, [switch]$Hsr) # adding some stuff for my campaign specifically :D
<#
$Name = Read-Host "What would you like to name the monster?"
# echo "The monster's name is $Name"
$Size = Read-Host "What size is the monster?"
$Category = Read-Host "What category would you classify the monster as?" # add examples
$Alignment = Read-Host "What is the monsters alignment?"
$Html = "<!DOCTYPE html><html><head><title>$Name Stat Block</title><meta name='viewport' content='width=device-width, initial-scale=1' /><!--<link rel = 'stylesheet' href = 'style.css' /> embed style --></head><body><!--Stuff that will be edited is started with a '$'--><div id = 'stat-block'><h1>Monster Name</h1><i>$Size $Category, $Alignment</i><br />"

$Armor_Class = Read-Host "What is the monsters Armor Class?"
$Note = Read-Host "Armor Class note" # explain
#>
$Hp_Formula = Read-Host "Give the HP formula [examples: 2d4 + 4, 1d5 - 3, 1d5 + 2d4]"
$Avg_Hp = $Hp_Formula -replace '\s','' # from stack overflow again
$Avg_Hp_Array = $Avg_Hp.split('+-*/%'.toCharArray())
$Avg_Hp_Array_ints = @(0.0,0.0,0.0,0.0,0.0,0.0)

#echo $Avg_Hp_Array.length
for ($i = 0; $i -lt $Avg_Hp_Array.length; $i++) {
    if ($Avg_Hp_Array[$i] -like "*d*") {
        $temp_var = $Avg_Hp_Array[$i] -split "d"
        # echo "temp_var: $temp_var"
        # make numbers 
        $temp_var_int = @(0,0)
        for ($x = 0; $x -lt $temp_var.length; $x++) {
            [int]$temp_var_int[$x] = [convert]::ToInt32($temp_var[$x], 10)
        }
        # get average 
        # echo "type:" + $temp_var_int[1].GetType()
        $Avg_Hp_Array_ints[$i] = ($temp_var_int[1] + 1)/2 * $temp_var_int[0]
        <#$Avg_Hp_Array[$i] = $Avg_Hp_Array[$i]/2
        $Avg_Hp_Array[$i] = $Avg_Hp_Array[$i] * $temp_var_int[0]#>
    } else {
        $Avg_Hp_Array_ints[$i] = $Avg_Hp_Array[$i]
    }
}
# echo "avg hp array: "  $Avg_Hp_Array_ints[0..($Avg_Hp_Array.length - 1)]

$Avg_Hp_Operators = $Avg_Hp -replace "[0-9d]", ""
# echo $Avg_Hp_Operators

$full_calculated_formula = "" + $Avg_Hp_Array_ints[0]

for ($i = 0; $i -lt $Avg_Hp_Operators.length; $i++) {
    $full_calculated_formula = "$full_calculated_formula" + $Avg_Hp_Operators[$i]
    $full_calculated_formula = "$full_calculated_formula" + $Avg_Hp_Array_ints[$i + 1]
}

$Command = "$full_calculated_formula"
Invoke-Expression $Command

#Invoke-Expression "$full_calculated_formula"

#Invoke-Expression 
# my best idea here is invoke expression which i "shouldn't have"?



# "<b>Armor Class </b><span>$Armor_Class ($Note)</span> <br /><b>Hit Points </b><span>$Avg_Hp ($Hp_Formula)</span><br /><b>Speed </b><span>$Walk_Speed ft.<!--any other speeds + notes--></span><br /><hr /><table> <tr><th>STR</th><th>DEX</th><th>CON</th><th>INT</th><th>WIS</th><th>CHA</th></tr><tr><td>$Strength ($Strength_Modifier)</td><td>$Dexterity ($Dexterity_Modifier)</td><td>$Constitution ($Constitution_Modifier)</td><td>$Intelligence ($Intelligence_Modifier)</td><td>$Wisdom ($Wisdom_Modifier)</td><td>$Charisma ($Charisma_Modifier)</td></tr></table><hr /><!--Some of these only apply if they exist -- actually just put all of them in a list? and then have it generate them from the list???--><b>Condition Immunities</b><span><!--Loop through immunities here-->$Skills[$n].name '+'$Skills[$n].value</span><b>Skills</b><span><!--Loop through skills here-->$Skills[$n].name '+'$Skills[$n].value</span><b>Senses</b><span><!--Loop through senses here-->$Senses[$n] $Senses[$n].value</span><b>etc.</b><span><!--Loop through anything here atp there are so many addable things :/ -->$yap</span><b>Challenge</b><span>$Challenge_Level ($Xp XP)</span><hr /><p><b>$Traits[$n].name </b>$Traits[$n].Description</p> <!--only if applies--><h2 class = 'small-caps'>Actions</h2><div class = 'line'></div><p><!--if $multiattack.Has == true--><b>Multiattack </b>$Multiattack.Description</p><p><b>$Attacks[$n].name </b><i>$Attacks[$n].Sphere <!--zB Melee Weapon Attack--></i> +$Attacks[$n].to_Hit to hit, reach $Attacks[$n].Reach ft., $Attacks[$n].target. <i>Hit: </i>$Attacks[$n].Average_Damage ($Attacks[$n].Damage_Equation) $Attacks[$n].Type damage. </p> <!--repeat--><h2 class = 'small-caps'>Reactions</h2><div class = 'line'></div><p><b>$Reactions[$n].name </b>$Reactions[$n].Description</p><h2 class = 'small-caps'>Legendary Actions</h2><div class = 'line'></div><!--just put those here ig????? iiiiiiiiiiiiii        dddddddddddddddddd             k--></div></body><style>.small-caps {font-variant: small-caps;}#stat-block {background-color: #f6f8ca;}.line {background-color: #000000;height: 1px;padding: 0;margin: 0;}h2 {padding: 0;margin: 0;}</style></html>"