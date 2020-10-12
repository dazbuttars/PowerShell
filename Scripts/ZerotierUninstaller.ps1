$ZeroTier = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "ZeroTier One"}
$ZeroTier.Uninstall()