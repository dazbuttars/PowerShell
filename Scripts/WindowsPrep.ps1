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
$url = "https://ninite.com/7zip-air-chrome-firefox-silverlight-spybot2-vlc/ninite.exe"
$outpath = ".\ninite.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Download Java
$url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242029_3d5a2bb8f8d4428bbe94aed7ec7ae784"
$outpath = ".\java.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Download Reader
$url = "https://admdownload.adobe.com/bin/live/readerdc_en_xa_crd_install.exe"
$outpath = ".\readerdc_en_xa_crd_install.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Exacute the installers
Start-Process -Filepath ".\java.exe" -ArgumentList '/passive' -Wait
Start-Process -FilePath ".\ninite.exe" -ArgumentList '/passive' -Wait
Start-Process -FilePath ".\readerdc_en_xa_crd_install.exe" -ArgumentList '/passive' -Wait