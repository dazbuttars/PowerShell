# Remount H drive
New-SmbMapping -LocalPath H: -RemotePath \\10.0.0.2\documents -Persistent 1

# Add ProviderFlags to Regestry
New-ItemProperty -Path 'HKCU:\Network\H' -Name 'ProviderFlags' -PropertyType 'DWord' -Value 1 -Force

