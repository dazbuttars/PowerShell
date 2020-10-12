#CD to ZeroTier program directory
Set-Location 'C:\Program Files (x86)\ZeroTier\One'

#Run ZeroTier cli leave command
.\zerotier-cli.bat leave a0cbf4b62a4975f2

#Run ZeroTier cli join command
.\zerotier-cli.bat join 93afae596315894c