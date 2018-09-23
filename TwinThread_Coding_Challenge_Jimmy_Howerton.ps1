#Jimmy Howerton
#9-23-2018
#I used the full 4 hours to do this

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$TwinThreadAssetForm             = New-Object system.Windows.Forms.Form
$TwinThreadAssetForm.ClientSize  = '647,400'
$TwinThreadAssetForm.text        = "TwinThread Asset Identifier"
$TwinThreadAssetForm.TopMost     = $false

$CancelButton                    = New-Object system.Windows.Forms.Button
$CancelButton.text               = "Cancel"
$CancelButton.width              = 60
$CancelButton.height             = 30
$CancelButton.location           = New-Object System.Drawing.Point(539,332)
$CancelButton.Font               = 'Microsoft Sans Serif,10'

$SearchBox                       = New-Object system.Windows.Forms.TextBox
$SearchBox.multiline             = $false
$SearchBox.width                 = 100
$SearchBox.height                = 20
$SearchBox.location              = New-Object System.Drawing.Point(63,75)
$SearchBox.Font                  = 'Microsoft Sans Serif,10'

$GenBox                          = New-Object system.Windows.Forms.CheckBox
$GenBox.text                     = "General Search"
$GenBox.AutoSize                 = $false
$GenBox.width                    = 125
$GenBox.height                   = 20
$GenBox.location                 = New-Object System.Drawing.Point(185,80)
$GenBox.Font                     = 'Microsoft Sans Serif,10'

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Search For Assets"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(65,48)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$SearchButton                    = New-Object system.Windows.Forms.Button
$SearchButton.text               = "Search"
$SearchButton.width              = 60
$SearchButton.height             = 30
$SearchButton.location           = New-Object System.Drawing.Point(64,109)
$SearchButton.Font               = 'Microsoft Sans Serif,10'

$WinForm1                        = New-Object system.Windows.Forms.Form
$WinForm1.ClientSize             = '647,400'
$WinForm1.text                   = "Form"
$WinForm1.TopMost                = $false

$WinForm2                        = New-Object system.Windows.Forms.Form
$WinForm2.ClientSize             = '647,400'
$WinForm2.text                   = "Form"
$WinForm2.TopMost                = $false

$WinForm3                        = New-Object system.Windows.Forms.Form
$WinForm3.ClientSize             = '647,400'
$WinForm3.text                   = "Form"
$WinForm3.TopMost                = $false

$CriticalButton                  = New-Object system.Windows.Forms.Button
$CriticalButton.text             = "List Critical Assets"
$CriticalButton.width            = 160
$CriticalButton.height           = 30
$CriticalButton.location         = New-Object System.Drawing.Point(39,332)
$CriticalButton.Font             = 'Microsoft Sans Serif,10'

$UniqueButton                    = New-Object system.Windows.Forms.Button
$UniqueButton.text               = "Give Unique Class Names"
$UniqueButton.width              = 220
$UniqueButton.height             = 30
$UniqueButton.location           = New-Object System.Drawing.Point(242,331)
$UniqueButton.Font               = 'Microsoft Sans Serif,10'

$IDBox                           = New-Object system.Windows.Forms.TextBox
$IDBox.multiline                 = $false
$IDBox.width                     = 153
$IDBox.height                    = 20
$IDBox.location                  = New-Object System.Drawing.Point(323,76)
$IDBox.Font                      = 'Microsoft Sans Serif,10'

$HierarchyLabel                  = New-Object system.Windows.Forms.Label
$HierarchyLabel.text             = "Show Hierarchy for ID"
$HierarchyLabel.AutoSize         = $true
$HierarchyLabel.width            = 25
$HierarchyLabel.height           = 10
$HierarchyLabel.location         = New-Object System.Drawing.Point(324,46)
$HierarchyLabel.Font             = 'Microsoft Sans Serif,10'

$HierarchyButton                 = New-Object system.Windows.Forms.Button
$HierarchyButton.text            = "Go"
$HierarchyButton.width           = 60
$HierarchyButton.height          = 30
$HierarchyButton.location        = New-Object System.Drawing.Point(321,109)
$HierarchyButton.Font            = 'Microsoft Sans Serif,10'

$AllDataBox                      = New-Object system.Windows.Forms.CheckBox
$AllDataBox.text                 = "Show All Fields"
$AllDataBox.AutoSize             = $false
$AllDataBox.width                = 138
$AllDataBox.height               = 20
$AllDataBox.location             = New-Object System.Drawing.Point(493,81)
$AllDataBox.Font                 = 'Microsoft Sans Serif,10'

$GeneralBox                      = New-Object System.Windows.Forms.TextBox
$GeneralBox.height               = 152
$GeneralBox.Multiline = $True
$GeneralBox.ScrollBars = "Both"
$GeneralBox.width                = 557
$GeneralBox.location             = New-Object System.Drawing.Point(39,157)
$GeneralBox.WordWrap = $true
$GeneralBox.ReadOnly = $true

$AssetTypeBox                    = New-Object system.Windows.Forms.ComboBox
$AssetTypeBox.text               = "assetId"
$AssetTypeBox.width              = 100
$AssetTypeBox.height             = 20
$AssetTypeBox.location           = New-Object System.Drawing.Point(64,15)
@('assetId','name','description','status','icon','Running','Utilization','Performance','Location','parentId') | ForEach-Object {[void] $AssetTypeBox.Items.Add($_)}
$AssetTypeBox.Font               = 'Microsoft Sans Serif,10'

$TwinThreadAssetForm.controls.AddRange(@($AssetTypeBox,$GeneralBox,$CancelButton,$SearchBox,$GenBox,$Label1,$SearchButton,$CriticalButton,$UniqueButton,$IDBox,$HierarchyLabel,$HierarchyButton,$AllDataBox))

#variable that is altered in GenBox to say whether calls to search will be general or not
$useGeneral=$false
#region gui events {
    #region gui events {
$HierarchyButton.Add_Click({ 
    fullHier -id $IDBox.text
 })
$SearchButton.Add_Click({
    #I need to add failsafes for these in case people run them in ways that will break things
    #just no time to do that right now
    simpleSearch -general $global:useGeneral -searchStr $global:SearchBox.Text -searchType $global:AssetTypeBox.Text
})
$CancelButton.Add_Click({
    $TwinThreadAssetForm.Close()
  })
$UniqueButton.Add_Click({ 
    uniqueNames
 })
$CriticalButton.Add_Click({  
    critFunc
})
$AllDataBox.Add_Click({  })
$GenBox.Add_Click({ 
    if($global:useGeneral -eq $false){
        $global:useGeneral = $true
    }
    else{
        $global:useGeneral = $false
    }
 })
#endregion events }
#endregion events }

#endregion GUI }


#Write your logic code here

#this function written by gravejester on github, found here
#https://github.com/gravejester/Communary.PASM/blob/master/Functions/Select-FuzzyString.ps1
#I edited this so that it could iterate through the JSON object, searching through only a single field, and then return the corresponding entire object. Before I was having issues because it was just returning the value of the field you were searching through. This also allows general searching without providing a field so I had to change it to allow that as well.
function Select-FuzzyString {
    <#
        .SYNOPSIS
            Perform fuzzy string search.
        .DESCRIPTION
            This function lets you perform fuzzy string search, and will
            calculate a score for each result found. This score can be used
            to sort the results to get the most relevant results first.
        .EXAMPLE
            Select-FuzzyString -Search $searchQuery -In $searchData
        .EXAMPLE
            $searchData | Select-FuzzyString $searchQuery
        .EXAMPLE
            $searchData | Select-FuzzyString $searchQuery | Sort-Object Score,Result -Descending
        .INPUTS
            System.String
            System.String[]
        .OUTPUTS
            System.Object
        .NOTES
            Author: Øyvind Kallstad
            Date: 08.07.2016
            Version: 1.0
        .LINK
            https://communary.wordpress.com/
            https://github.com/gravejester/Communary.PASM
    #>
    [CmdletBinding()]
    param (
        # The search query.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Search,
        
        # The data you want to search through.
        [Parameter(Position = 1, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('In')]
        [psobject] $Data,

        #MY EDIT HERE
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Field,

        # Set to True (default) it will calculate the match score.
        [Parameter()]
        [switch] $CalculateScore = $false,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $GeneralSearch = $false
    )

    BEGIN {
        # Remove spaces from the search string
        $search = $Search.Replace(' ','')

        # Add wildcard characters before and after each character in the search string
        $quickSearchFilter = '*'

        $search.ToCharArray().ForEach({
            $quickSearchFilter += $_ + '*'
        })
    }

    PROCESS {
        foreach ($string in $data) {
            if ($GeneralSearch){
                if ($string -like $quickSearchFilter) {

                    #Write-Verbose "Found match: $($string)"
    
                    if ($CalculateScore) {
    
                        # Get score of match
                        $score = Get-FuzzyMatchScore -Search $Search -String $string
    
                        Write-Output (,([PSCustomObject][Ordered] @{
                            Score = $score
                            Result = $string
                        }))
                    }
    
                    else {
                        Write-Output $string
                    }
                }
            }
            else{
                if ($string.$Field -like $quickSearchFilter) {

                    #Write-Verbose "Found match: $($string)"
    
                    if ($CalculateScore) {
    
                        # Get score of match
                        $score = Get-FuzzyMatchScore -Search $Search -String $string
    
                        Write-Output (,([PSCustomObject][Ordered] @{
                            Score = $score
                            Result = $string
                        }))
                    }
    
                    else {
                        Write-Output $string
                    }
                }
            }
            # Do a quick search using wildcards
        }
    }
}

function simpleSearch{
    #the individual search parameters could be optimized (i.e. assetId is already in order in the json so could do a binary search or maybe even direct referencing) however I figured that this would take a while and I wouldn't be able to give equal attention to each field type.
    param([string]$searchStr,[string]$searchType,$general)
    switch($searchType){
        "assetId" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "name" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "description" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "status" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "icon" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "Running" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "Utilization" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "Performance" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "Location" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "parentId" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
    }
    #Write-Host $result.
    $GeneralBox.Text = $result | ConvertTo-Json
}

function critFunc{
    #some initialization text
    $critResult +=  "These are the current critical assets:`r`n"
    $critResult +=  "_____________________________________`r`n"
    #get the value that means critical (in case it changes)
    $critNum = $jsonResponse.asset_status.Critical
    #print out the ones that match
    foreach ($asset in $jsonResponse.assets){
        if ($asset.status -eq $critNum){
            $critResult += $asset | ConvertTo-Json
            $critResult += "`n"
        }
    }
    $GeneralBox.Text=$critResult
}

function uniqueNames{
    #make hashtable of class names
    $nameHash = @{}
    #for each asset
    $uniqueResult=""
    $msg=""
    foreach ($asset in $jsonResponse.assets){
        #for each class inside of each asset
        foreach($class in $asset.classList){
            #if the class name is in the hashtable, add the name of this asset to the end of the value
            if($nameHash.ContainsKey($class.name)){
                $nameHash[$class.name]=$nameHash[$class.name]+"`r`n"+$asset.name
            }
            #otherwise, add it in
            else{
                $nameHash.Add($class.name,$asset.name)
            }
        }
    }
    #go back through the hash and print out the relevant info
    $uniqueResult += $nameHash.Count
    $uniqueResult += " unique class names `r`n"
    $nameHash.GetEnumerator() | ForEach-Object{
        $msg += $_.key
        $msg += "`r`n"
    }
    $msg += "_____________________________________`r`n"
    $uniqueResult += $msg
    $nameHash.GetEnumerator() | ForEach-Object{
        $msg = "Class Name {0}:`r`n_____________________________________`r`n{1}" -f $_.key, $_.value
        $uniqueResult += $msg
        $uniqueResult += "`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n"
    }
    $GeneralBox.Text = $uniqueResult
}

#this hierarchy function is VERY unfinished


#the idea was to use the hashtable to recursively go down
#using tabs (I had to stop here it was 4hrs exactly)
function getHier{
    param($id)
    $resultString=""
    if($hierarchyTable.ContainsKey($id))
    {
        $resultString+=($hierarchyTable[$id])
        $resultString+= "`r`n"
        Write-Host $resultString
        foreach($idVal in $hierarchyTable[$id]){
            $resultString+=getHier($hierarchyTable[$id])
        }
    }
}

function fullHier{
    param($id)
    Write-Host $id

    $outputString = getHier -id $id
    $GeneralBox.Text = $outputString
}




#import data from site
$url ='https://www.twinthread.com/code-challenge/assets.txt'
$response = Invoke-WebRequest -Uri $url
#change data to Json format
$jsonResponse = $response | ConvertFrom-Json
#initialize a hashtable of arrays that signify the hierarchies
#I do this here because it would be a waste to do it in every hierarchy call
#I don't do this for uniqueNames because that has no parameters so it is going to give the same information every time it is ran, as a result I assume that the user will not repeatedly run that function.
$hierarchyTable = @{}
foreach ($asset in $jsonResponse.assets){
    #if the key is already in the table, append entry to the arraylist
    if($asset.parentId = "null"){
        #do nothing
    }
    elseif($hierarchyTable.ContainsKey($asset.parentId)){
        $hierarchyTable[$asset.parentId].add($asset)
    }
    #otherwise make the arraylist
    else{
        $hierarchyTable[$asset.parentId] = New-Object System.Collections.ArrayList
        $hierarchyTable[$asset.parentId].add($asset)
    }
}
#simpleSearch -general $true -searchStr '10227' -searchType 'assetId'


[void]$TwinThreadAssetForm.ShowDialog()
