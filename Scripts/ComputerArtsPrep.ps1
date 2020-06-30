#You must allow Powershell to run scripts with the (Set-ExecutionPolicy Unrestricted) command before you can run this script
#or you can just pass the text into a Powershell session and hit Enter.
 
#Disable UAC requires a computer restart.
New-ItemProperty -Path 'HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system' -Name 'EnableLUA' -PropertyType 'DWord' -Value 0 -Force
#Disable DEP
start-job -ScriptBlock {cmd bcdedit /set {current} nx AlwaysOff}
#Disable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
#Run .vbs files as Administrator.
#1 Set HKCR PsDrive to access the HKEY_CLASSES_ROOT key.
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
#2 Create subkey named runas
New-Item -ItemType "directory" -Path "HKCR:\VBSFile\shell\runas"
#3 Create string value HasLUAShield
New-ItemProperty -Path "HKCR:\VBSFile\shell\runas" -Name "HasLUAShield" -Force
#4 Create subkey named command
New-Item -ItemType "directory" -Path "HKCR:\VBSFile\shell\runas\command"
#5 Create subkey (Default) Properties
New-ItemProperty -Path "HKCR:\VBSFile\shell\runas\command" -Name "(Default)" -Value 'C:\Windows\System32\WScript.exe "%1" %*' -Force
do {
  
$i = 0
$UsersAnswer = Read-Host -Prompt 'A Restart Is Required, would you like to restart now? (Yes/No)'
if ($UsersAnswer -eq 'Yes'){
   Restart-Computer -Force
   $i = 1
}
elseif ($UsersAnswer -eq 'No'){
   Write-Host 'You will need to restart the PC for changes to take effect.'
   $i = 1
}
else{
   Write-Host 'Type Yes or No.'
}
} while ($i -eq 0)

