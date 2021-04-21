;@echo off
;Findstr -rbv ; %0 | powershell -c -
;goto:sCode

#Stop and Start TaskTrayApplication Six times.
#One
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'
#Two
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'
#Three
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'
#Four
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'
#Five
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'
#Six
Stop-Process -Name TaskTrayApplication
Start-Process -FilePath 'C:\Program Files\swet\TaskTrayApplication.exe'

;:sCode
;echo "If the code scanner did not connect try running this again"
;echo Exit
;pause & goto :eof