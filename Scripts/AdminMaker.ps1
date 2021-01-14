# Retreve email address.
$rawEmailAddress = get-childitem hkcu:\Software\Microsoft\IdentityCRL\UserExtendedProperties\ | Select-Object pschildname

# Change type to string
$emailAddress = $rawEmailAddress.PSChildName.ToString()

# Add user to Local Admin Group
Add-LocalGroupMember -Group "Administrators" -Member "AzureAD\$emailAddress"