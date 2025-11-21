# Prompt for printer name
$PrinterName = Read-Host "Enter the printer name:"

# Prompt for printer IP
$PrinterIP = Read-Host "Enter the printer IP Address:"

# Install the built-in print driver
Invoke-Command { pnputil.exe -a "C:\Windows\inf\ntprint.inf" }

# Add the printer driver
Add-PrinterDriver -Name "Microsoft PCL6 Class Driver"

# Create the printer port
Add-PrinterPort -Name "$PrinterIP" -PrinterHostAddress "$PrinterIP"

# Add the printer using user-provided values
Add-Printer -Name "$PrinterName" -DriverName "Microsoft PCL6 Class Driver" -PortName "$PrinterIP"

Write-Host "Printer $PrinterName added successfully on IP $PrinterIP."
