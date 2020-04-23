#===================================================
# Program Name : Color
# Author: Daz Buttars
# I Daz Buttars wrote this script as original work completed by me.
# Special Feature: If a user types moo the game displays an ascii cow, dead beef displays a dead cow.
#===================================================
$timeArray = @()
$newgame = 1

while ($newgame -eq 1) {
    
    $SystemColors = [System.Enum]::getvalues([System.ConsoleColor]) #Returns an array of all the possible ConsoleColor Values
    [string]$randoColor = $SystemColors | Get-Random
    #$color = [System.ConsoleColor]'DarkRed' #Creates a ConsoleColor from a string
    #[string]$randoColor = $color
    $guessArray = @()
    $stopwatch = [system.diagnostics.stopwatch]::StartNew()
    $i = 0

    # Output hints for user on start of round.
    Write-Host "1. For a list a valid colors type list when asked for a color." -BackgroundColor 'yellow' -ForegroundColor 'Black'
    Write-Host "2. For a list of your guesses type guess." -BackgroundColor 'yellow' -ForegroundColor 'Black'
    Write-Host "3. For a hint type hint." -BackgroundColor 'yellow' -ForegroundColor 'Black'
    Write-Host "4. To exit type exit." -BackgroundColor 'yellow' -ForegroundColor 'Black'
    Write-Host "5. No matter whatever you do don't type moo!" -BackgroundColor 'red'
    while ($i -eq 0) {
        # Ask the user for an input.
        Write-Host "Guess my favorite System Console Color [ENTER]:"
        $guess = Read-Host

        # If the guess matches the random color output Correct, Color, the amount of time it took to play and how many guesses it took.
        if ($randoColor -contains $guess) {
            $guessArray += $guess
            [string]$start = $stopwatch.ElapsedMilliseconds
            $time = $start.Substring(0, $start.Length - 3)
            Write-Host "Correct, "  -NoNewline
            Write-Host $guess -ForegroundColor $guess -NoNewline
            Write-Host " is my favorite color!" 
            Write-Host "It took you $time seconds to guess correctly"
            Write-Host "It took you"  $guessArray.Count  "guesses."
            $timeArray += $time
            $i = 1
        }
        # Output list of System Colors if user types list.
        elseif ($guess -eq 'list') {
            " "
            $SystemColors
      
        }
        # Output list of users guesses if user types guess.
        elseif ($guess -eq 'guess') {
            " "
            $guessArray
        }
        # Output a hint if user types hint.
        elseif ($guess -eq 'hint') {
            if ($randoColor.StartsWith('Dark')) {
                $randoColor.SubString(0, 5)
            }
            else {
                $randoColor.SubString(0, 1)
            }
        }
        # Exit the game if user types exit.
        elseif ($guess -eq 'exit') {
            $i = 1
        }
        #Ascii cow for moo.
        elseif ($guess -eq 'moo'){
     
            $moo = "
            \|/         (__)    
                 `\------(oo)
                  ||    (__)
                  ||w--||     \|/
               \|/
        "
       Write-Host "$moo" -ForegroundColor 'green'
        }
        # Ascii cow for dead beef.
        elseif ($guess -eq 'dead beef'){
            $beef ="
                          *
            vv       vv  /
            ||____M__||/
            ||       ||                     
          /\||_______||                      
         (Xx)                                
         (--)
            "
            Write-Host "$beef" -ForegroundColor 'DarkRed'
        }
        # Lets the user know what the input they gave is not a System Color.
        elseif ($SystemColors -notcontains $guess) {
            Write-Host "$guess " -BackgroundColor "red" -NoNewline
            Write-Host " is not a valid color for a list of colors type list before guessing a color." -BackgroundColor "yellow" -ForegroundColor 'Black'
        }
        # Lets the user know their input is not the right color.
        else {
            $guessArray += $guess
            Write-Host "No " -NoNewline
            Write-Host $guess -ForegroundColor $guess -NoNewline 
            Write-Host " is not my favorite color, try agian."
        }
    }
    # Ask the user if they want to play again.
    Write-Host "Do you want to play again [y] or [n]"
    $yn = Read-Host
    # If yes start another round.
    if ($yn -eq 'y' -Or $yn -eq 'yes') {
        $stopwatch.Stop()
        $newgame = 1
        Clear-Host
    }
    # If no stop the game
    elseif ($yn -eq 'n' -Or $yn -eq 'no') {
        foreach ($rounds in $timeArray) {
            ++$games
            Write-Host "Game $games took $rounds seconds."
        }
        "Average time = $(($timeArray|Measure-Object -average).Average)"
        $newgame = 0
    }
    # If the user enters anything else start another round by default uncomment $newgame = 0 
    else {
        Write-Host 'WHAT ARE YOU DOING? That was not a choice!!! Iam going to make you play again :)' -BackgroundColor 'red'
        #$newgame = 0
}
}