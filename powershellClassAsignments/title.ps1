function Make-Title([string]$Title, [switch]$AllCaps){
    $i = 0
if($AllCaps){
    $Title.ToUpper()
}
else{
    $titleArray = $Title -split ' '
    foreach($element in $titleArray){
       $a = $element.substring(0,1).ToUpper() + $element.substring(1).ToLower()
       if(($element -eq 'is') -or ($element -eq 'a') -or ($element -eq 'to') -or ($element -eq 'the') -or ($element -eq 'at') -or ($element -eq 'in') -or ($element -eq 'of') -or ($element -eq 'with') -or ($element -eq 'and') -or ($element -eq 'but') -or ($element -eq 'or')){
        $a = $element.ToLower()
       }
       $titleArray[$i] = $a
       $titleArray[0]  = $titleArray[0].substring(0,1).ToUpper() + $titleArray[0].substring(1)
       $i++  
    }
   "$titleArray"
}
}