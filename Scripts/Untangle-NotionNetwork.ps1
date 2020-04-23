#Get input from user
Write-Host 'The CSV file will be created in the derectory you run this script in.' -ForegroundColor Yellow
$jsonPath = Read-Host -Prompt 'Enter file path to the Untangle json file [ENTER]'

#Convert from JSON to PSObject
$jsonArray = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

#Rename columns
$formatedArray = $jsonArray | Select-Object @{Name = "ADDR"; Expression = {$_.address}}, @{Name = "Description"; Expression = {$_.description}}, @{Name ="Physical Location"; Expression = {$null}}, @{Name ='Notes/more details on "What is this?"'; Expression = {$null}}, @{Name = "MAC ADDR"; Expression = {$_.macAddress}}

#Format as CSV
$csv = $formatedArray | ConvertTo-Csv -NoTypeInformation

#Output to file
$csv | ForEach-Object {Add-Content -Path './Network - .csv' -Value $_}