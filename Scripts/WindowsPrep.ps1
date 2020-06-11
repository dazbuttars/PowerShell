#Unpin Taskbar Store and Mail
function UnPinFromTaskbar { param( [string]$appname )
Try {
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | Where-Object{$_.Name -eq $appname}).Verbs() | ?{$_.Name -like "Ta bort fr*" -OR $_.Name -like "Unpin from*"} | ForEach-Object{$_.DoIt()}
} Catch {$a="b"}
} #UnPinFromTaskbar
UnPinFromTaskbar "E-Post"
UnPinFromTaskbar "Microsoft Store"
UnPinFromTaskbar "Mail"

#Download applications
#Download Ninite
$url = "https://ninite.com/7zip-air-chrome-firefox-silverlight-spybot2-vlc/"
$outpath = ".\ninite.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Download Java
$url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242029_3d5a2bb8f8d4428bbe94aed7ec7ae784"
$outpath = ".\java.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Download Reader
$url = "https://get.adobe.com/reader/download/?installer=Reader_DC_2020.009.20063_English_for_Windows&os=Windows%2010&browser_type=KHTML&browser_dist=Chrome&dualoffer=false&mdualoffer=true&cr=false&stype=7595&d=McAfee_Security_Scan_Plus&d=McAfee_Safe_Connect"
$outpath = ".\reader.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Exacute the installers
Start-Process -Filepath "./java.exe" -Wait
Start-Process -FilePath "./ninite.exe" -Wait
Start-Process -FilePath "./reader.exe" -Wait