#Retreve Azure Groups
$adGroups = Get-MsolGroup -All

#Loop thought every group in a list of groups
foreach ($group in $adGroups) {
    
    if($group.DisplayName -like "Exp0*"){
        Remove-MsolGroup -ObjectId "$($group.ObjectId)" -Force
    }
    

}