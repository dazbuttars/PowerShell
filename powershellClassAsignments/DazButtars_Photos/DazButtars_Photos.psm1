function Rename-Photos {
 <#
    .SYNOPSIS
    Change Photos name to Filepath and a string of 8 random Characters
    .Description
    SourceFolder: Location to process: use current folder if none specified

    Recurse: Switch to determine if we process sub folders

    NameRoot: Folder where naming begins

    Separator: Character used to separate elements in filename, default to “-“

    Force: Switch to Rename all

    .Example
    Rename-Photos -NameRoot Example -SourceFolder C:\Users\username\Photos\Example\2018\Christmas
    .Example
    Rename-Photos -NameRoot Example -Recurse
    .Example
    Rename-Photos -NameRoot Example -Force
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    param ( 
        [Parameter(Mandatory = $True)][string]$NameRoot,
        $SourceFolder,
        $Separator,
        [switch]$Recurse,
        [switch]$Force 
    )
    if (!$SourceFolder) {
        $SourceFolder = Get-Location
        Write-Verbose "Set SourceFolder as $SourceFolder"
    }
    if (!$Separator) {
        $Separator = '_'
        Write-Verbose "Set Separator as $Separator"
    }
    Write-Verbose "Checking Separator characters"
    if ($Separator -match "\`"|\'|\%|\||\#|\:|\<|\>|\/|\\|\?") {
        Write-Error "$Separator can not be used as the separator character."
        exit;
    }
    Write-Verbose "Creating file name"
    $splitPath = $SourceFolder -split $NameRoot
    $slashName = "$NameRoot$($splitPath[1])"
    $name = $slashName.Replace('\', "$Separator")
    $allItems = Get-ChildItem
    if ($Recurse) {
        Write-Verbose 'Recursing through files'
        $allItems = Get-ChildItem -Recurse
    }
    $exists = "$name$($Separator)????????.*"
    if ($Force) {
        $exists = '         '
    }
    Write-Verbose "Looping through photos"
    foreach ($photo in $allItems) {
        if ($photo.Name -notlike $exists) {
            Write-Verbose "Filtering out photos"
            if (($photo.Extension -eq '.jpg') -or ($photo.Extension -eq '.tif') -or ($photo.Extension -contains '.gif') -or ($photo.Extension -contains '.png') -or ($photo.Extension -contains '.raw') -or ($photo.Extension -contains '.jpeg')) {
                if ($Recurse) {
                    Write-Verbose 'Creating file name for Recursing photos'
                    $SourceFolder = $($photo.Directory).FullName
                    $splitPath = $SourceFolder -split $NameRoot
                    $slashName = "$NameRoot$($splitPath[1])"
                    $name = $slashName.Replace('\', "$Separator")
                }
                $random = ([System.IO.Path]::GetRandomFileName()).Split('.')[0]
                Write-Verbose "Created random string $random"
                $newName = "$name$Separator$random$($photo.Extension)"
                Rename-Item -Path $photo.FullName -NewName $newName
                Write-Verbose "Renamed $($photo.Name) to $newName"
            }
        }
    }
}