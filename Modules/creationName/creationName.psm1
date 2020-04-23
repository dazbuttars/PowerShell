
#===================================================
# Program Name : ButtarsD_Netutils
# Author: Daz Buttars
# I Daz Buttars wrote this script as original work completed by me.
#====================================================
    function Set-NameDate {
        <#
        .SYNOPSIS
        Add date to file name
        .Description
        Function takes a filename and adds the cration date to the front of the name.
        .Example
        Set-NameDate
        #>
        [CmdletBinding()]

        param () 

        Get-ChildItem -File | ForEach-Object {
            Rename-Item -Path $_.Name -NewName "$($_.CreationTime.toString('yyyy-MM-dd-'))$($_.Name)" }
        
    }