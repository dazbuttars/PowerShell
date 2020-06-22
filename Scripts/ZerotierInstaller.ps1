#Check to see if ZeroTier is already installed
$pathTest = Test-Path 'C:\Program Files (x86)\ZeroTier\One'
if ($pathTest -eq $true) {
    #If installed exit
    exit
}
else {
#Download Zerotier msi
$url = "https://download.zerotier.com/dist/ZeroTier%20One.msi"
$outpath = ".\ZeroTier One.msi"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Get file path
$path = Get-Location

#Run msi
Start-Process "$path\ZeroTier One.msi" -ArgumentList "/passive" -Wait

#CD to ZeroTier program directory
Set-Location 'C:\Program Files (x86)\ZeroTier\One'

#Run ZeroTier cli join command
.\zerotier-cli.bat join #Replace this comment with your ZeroTier Network ID
}
