#$n=Get-Process notepad -ErrorAction SilentlyContinue -ErrorVariable noteError
#if($noteError.count -eq 0){
#    "Notepad is running."
#}
#Else{"Notepad is not running"}

#foreach($f in 1..10) {
#    Write-Host $f
#}

#foreach ($i in 1..10){
#    [void] $foreach.MoveNext()
#    Write-Host $foreach.Current $i
#}

#foreach ($i in 1..10){
#    if ($i % 2 -eq 0){
#        Write-Host $i
#    }
#}

#1,2,3,4 |foreach {Start-Process -FilePath 'https://www.google.com'}

cls
foreach($f dir){
    $f.name
}
'loop 1'
dir|ForEach-Object {$_.name}
'loop 2'
dir|foreach {$_.name}
'loop 3'
dir|%{$_.Name}
'loop 4'
dir|% Name