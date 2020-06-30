
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
$version = [System.Environment]::Is64BitOperatingSystem 
if($version -eq $true){
#Download Java Windows 64bit
$url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242060_3d5a2bb8f8d4428bbe94aed7ec7ae784"
$outpath = ".\java.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
}
elseif ($version -eq $false) {
    
#Download Java Windows 32bit
$url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242058_3d5a2bb8f8d4428bbe94aed7ec7ae784"
$outpath = ".\java.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
}

#Install
Start-Process -Filepath ".\java.exe" -Wait
Start-Process -FilePath ".\ninite.exe" -Wait

#Do you want to install Reader?
do{
$i = 0
$UsersAnswer = Read-Host -Prompt 'Do you want to install Adobe Reader? (Yes/No)'
if ($UsersAnswer -eq 'Yes'){

#Download Reader
$url = "https://admdownload.adobe.com/bin/live/readerdc_en_xa_crd_install.exe"
$outpath = ".\readerdc_en_xa_crd_install.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Install
Start-Process -FilePath ".\readerdc_en_xa_crd_install.exe" -ArgumentList '/passive' -Wait
$i = 1
}
elseif ($UsersAnswer -eq 'No'){
    Write-Host 'O.K.'
    $i = 1
 }
 else{
    Write-Host 'Type Yes or No.'
 }
 } while ($i -eq 0)