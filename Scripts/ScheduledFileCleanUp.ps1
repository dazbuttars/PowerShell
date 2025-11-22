#Deletes file types older than specified date in months from the C:\the\designated\spot directory every scheduled date via a scheduled task
$targetDate = (Get-Date).AddMonths(-2)
$tagetFiles = Get-ChildItem -Path "C:\the\designated\spot" -File -Filter "*.fileType" | Where-Object { $_.LastWriteTime -lt $targetDate } 
$tagetFiles | Remove-Item