#===================================================
# Program Name : ButtarsD_Netutils
# Author: Daz Buttars
# I Daz Buttars wrote this script as original work completed by me.
# Your Network Utility:  Test-IPHostSpeed pings every hop between you and your destination and reports back with color coded responses.
# Support functions: Formate-Dash prints out a dash line for every charicate in a string.
#===================================================

function Format-Dash([string]$string, [string]$ForegroundColor) {
    $array = @()
    $num = $string.Length
    for ($i = 1; $i -le $num; $i++) {
        $dash = "-"
        $array += , $dash
    }
    $line += -join $array
    Write-Host $line -ForegroundColor $ForegroundColor
}

#Function 1
function Test-IPHost {
    <#
    .SYNOPSIS
    Ping a Host Name 
    .Description
    Function takes a hostname, determines the IP address(es) for the host and pings each IP address to determine if it is online.
    .Example
    Test-IPHost -HostName example.com
    Test-IPHost -HostName example.com -Count 10
    Test-IPHost -HostName example.com, dazbuttars.com
    #>
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, ValueFromPipeline)][array]$HostName, [Parameter(Mandatory = $false)][int]$Count)
    begin{}
    process{
    foreach ($element in $HostName) {
        try {
            $ip = Resolve-DnsName $element -ErrorAction Stop |Where-Object {$_.section -eq 'answer' -and $_.type -eq 'a'}|ForEach-Object {$_.ipaddress}

            foreach ($address in $ip) {
                $name = "$element [$address]"
                Format-Dash -string $name -ForegroundColor 'green'
                Write-Host $name -ForegroundColor 'green'
                Format-Dash -string $name -ForegroundColor 'green'
     
                if ($Count) {
                    ping -n $Count $address
                }
                else {
                    ping $address
                }
            }
        }
        Catch {
            Write-Host "Sorry, but the hostname $element could not be found." -ForegroundColor 'red'
        }
    }  
}
}
end{}

#Function 2
function Get-IPNetwork {
    <#
    .SYNOPSIS
    Get the Netowrk ID based on Subnet and IP address.
    .Description
    Given an IP address and a Subnet mask returns the network ID if no subnet mask is entered the classful address is used.
    .Example
    Get-IPNetwork -IP 192.168.0.1 -SubnetMask 255.255.255.0
    Get-IPNetwork -IP 192.168.0.1 -SubnetMask /24
    Get-IPNetwork -IP 172.16.0.0
    #>
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true)][string]$IP,
        [Parameter(Mandatory = $false)][string]$SubnetMask) 
    if ($IP -notmatch '\b(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}\b') {
        Write-Host "It tooks like somthing is wrong with the IP address $IP" -ForegroundColor 'red'
        break;
    }
    if ($SubnetMask ) {
        if ($SubnetMask -notmatch '^(((255\.){3}(255|254|252|248|240|224|192|128+))|((255\.){2}(255|254|252|248|240|224|192|128|0+)\.0)|((255\.)(255|254|252|248|240|224|192|128|0+)(\.0+){2})|((255|254|252|248|240|224|192|128|0+)(\.0+){3}))$') {
            if ($SubnetMask -notmatch '(/[8-9]|/[1-2][0-9]$|/30)') {
                Write-Host "It looks like there is something wrong with the Subnet Mask $SubnetMask" -ForegroundColor 'red'
                break;
            }
        }
    }

    $ipadd = [System.Net.IPAddress]"$IP"

    if (!($SubnetMask) -and ($ipadd.IPAddressToString.Substring(0, 1) -ge '0') -and ($ipadd.IPAddressToString.Substring(0, 3) -lt '128')) {
        $SubnetMask = '255.0.0.0'
    }
    elseif (!($SubnetMask) -and ($ipadd.IPAddressToString.Substring(0, 3) -ge '128') -and ($ipadd.IPAddressToString.Substring(0, 3) -lt '192')) {
        $SubnetMask = '255.255.0.0'
    }
    elseif (!($SubnetMask) -and ($ipadd.IPAddressToString.Substring(0, 3) -ge '192') -and ($ipadd.IPAddressToString.Substring(0, 3) -lt '224')) {
        $SubnetMask = '255.255.255.0'
    }
    elseif (!($SubnetMask)) {
        Write-Host 'That IP address is outside of the classful subnetting standard, please enter a subnetmask.' -ForegroundColor 'red'
        break;
    }
      
    if ($SubnetMask.Substring(0, 1) -contains '/') {
        $CIDRtoDD = [ordered]@{
            '/30' = '255.255.255.252'
            '/29' = '255.255.255.248'
            '/28' = '255.255.255.240'
            '/27' = '255.255.255.224'
            '/26' = '255.255.255.192'
            '/25' = '255.255.255.128'
            '/24' = '255.255.255.0'
            '/23' = '255.255.254.0'
            '/22' = '255.255.252.0'
            '/21' = '255.255.248.0'
            '/20' = '255.255.240.0'
            '/19' = '255.255.224.0'
            '/18' = '255.255.192.0'
            '/17' = '255.255.128.0'
            '/16' = '255.255.0.0'
            '/15' = '255.254.0.0'
            '/14' = '255.252.0.0'
            '/13' = '255.248.0.0'
            '/12' = '255.240.0.0'
            '/11' = '255.224.0.0'
            '/10' = '255.192.0.0'
            '/9'  = '255.128.0.0'
            '/8'  = '255.0.0.0'
        }

        $sm = [System.Net.IPAddress]$CIDRtoDD[$SubnetMask]
    }
    else {
        $sm = [System.Net.IPAddress]$SubnetMask
    }
    $netID = [ipaddress]($ipadd.Address -band $sm.Address)
    #      Write-Host "The Network ID is $($netId.IPAddressToString)" -ForegroundColor 'green'
    $t = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = 'green'
    Write-Output "The Network ID is $($netID.IPAddressToString)"
    $host.ui.RawUI.ForegroundColor = $t
}

#Function 3
function Test-IPNetwork {
    <#
    .SYNOPSIS
    Checks if IP's are on the same network
    .Description
    Determines if two IP addresses are on the same network, if no subnetmask is entered the classful address is used.
    .Example
    Test-IPNetwork -IP1 192.168.0.1 -IP2 192.168.1.2 -SubnetMask 255.255.255.0
    Test-IPNetwork -IP1 192.168.0.1 -IP2 192.168.1.2 -SubnetMask /24
    Test-IPNetwork -IP1 192.168.0.1 -IP2 192.168.1.2
    #>
    [CmdletBinding()]
    Param([Parameter(Mandatory = $true)]$IP1, [Parameter(Mandatory = $true)]$IP2, [Parameter(Mandatory = $false)]$SubnetMask)
    $ipOne = Get-IPNetwork $IP1 $SubnetMask
    $ipTwo = Get-IPNetwork $IP2 $SubnetMask
    Write-Host  "$($ipOne -eq $ipTwo)" -ForegroundColor 'green'
}

#My Function
function Test-IPHopSpeed {
    <#
    .SYNOPSIS
    Pings hops between you and the destination
    .Description
    When given an IP address or host name this Cmdlet pings ever hop to that destination and displays the results.
    .Example
    Test-IPHopSpeed -Destination example.com
    Test-IPHopSpeed -Destination 8.8.8.8
    #>
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, ValueFromPipeline)]$Destination)
    begin{}
    process{
    Write-Host 'Retrieving Hop IP Addresses.................' -ForegroundColor 'white' -BackgroundColor 'blue'
    $route = $(Test-NetConnection $Destination  -TraceRoute).TraceRoute
    foreach ($IP in $route) {
        $ping = ping $IP
        $i++
        $color = 'white'
        $loss = 'white'
        if ($ping[-1] -notlike '*Average*') {
            $ping[-1] = "Hop $i did not respond to pings."
            $color = 'darkred'
        }
        elseif ($ping[-1] -like '*Average = ?ms*') {
            $color = 'green'
            $loss = 'green'
        }
        elseif ($ping[-1] -like '*Average = 1?ms*') {
            $color = 'green'
            $loss = 'green'
        }
        elseif ($ping[-1] -like '*Average = 2?ms*') {
            $color = 'green'
            $loss = 'green'
        }
        elseif ($ping[-1] -like '*Average = 3?ms*') {
            $color = 'green'
            $loss = 'green'
        }
        elseif ($ping[-1] -like '*Average = 4?ms*') {
            $color = 'green'
            $loss = 'green'
        }
        elseif ($ping[-1] -like '*Average = 5?ms*') {
            $color = 'yellow'
            $loss = 'yellow'
        }
        elseif ($ping[-1] -like '*Average = ??ms*') {
            $color = 'yellow'
            $loss = 'yellow'
        }
        elseif ($ping[-1] -like '*Average = ???ms*') {
            $color = 'red'
            $loss = 'red'
        }
        if ($ping[-3] -like '*(??% loss)*') {
            $loss = 'darkred'
        }
        $hopCount = "HOP $i"
        Write-Host $hopCount
        Format-Dash -string $hopCount -ForegroundColor 'white'

        Write-Host $ping[1] -ForegroundColor $color
        Write-Host $ping[-3] -ForegroundColor $loss
        Write-Host $ping[-1] -ForegroundColor $color
    }
    $done = 'DONE'
    Write-Host $done
    Format-Dash -string $done -ForegroundColor 'white'
}
end{}
}
