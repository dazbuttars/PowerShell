$r = 1..100|Get-Random
$i = 0
$t = 0
while ($i -eq 0) {
    'Guess a Number between 1 and 100 then press [ENTER]:'
    $g = Read-Host
    $g = [int]$g
    if ($g -eq $r) {
        ++$t
        if ($t -eq 1) {
            "You got it in $t try the answer was $r!" 
            $i = 1
        }
        else {
            "You got it in $t tries the answer was $r!" 
            $i = 1
        }
    
    }
    elseif ($g -lt $r) {
        "No $g is too low, try again."  
        $i = 0 
        ++$t 
    }
    elseif ($g -gt $r) {
        "No $g is too high, try again."
        $i = 0
        ++$t
    }
    else {
        "I don't know what you did but somthing has gone horribly wrong!!!" 
    }
}


