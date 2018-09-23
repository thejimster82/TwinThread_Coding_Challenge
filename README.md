# TwinThread_Coding_Challenge
## Running the script:
Note: After finishing the project I realized that compiling the code directly breaks the search functionality so this is a work-around. If I were to finish a script like this I would take the time to figure out why this type of compiling breaks certain functionality.
1. Open Powershell ISE (pre-installed on windows PCs)
2. Open the provided file (TwinThread_Coding_Challenge_Jimmy_Howerton.ps1)
3. Click run at the top (Green arrow)
4. Click buttons, enter values, etc. (hierarchy section doesn't work)
## Overview
The main goals of this challenge were to 
1. Downloads the [sample data](https://www.twinthread.com/code-challenge/assets.txt) upon starting the application
2. Allows for a simple search of asset data by name, description, or other specified top level field
3. List all assets that have a critical status
4. Gives a count of unique class names, then, for every class name, lists the names of those assets that have those class names
5. Build a visual hierarchy for a given asset id (see a tree of assets beneath that asset)
All in 4 hours.

  I chose to use PowerShell for this challenge as I had experience with it at my Genworth internship and I knew it would make things like downloading files and dealing with hashtables much easier. I focused at first on doing what I saw as the easiest tasks, downloading the sample data (1), giving a count of unique class names (4) and listing all classes with critical status(3). I was able to implement code to complete these three parts of the challenge using a variety of methods. While I did not format them in a way that was super easy to read, I did put their output to a GUI that will be mentioned later.
 
 For part (2), I based my implementation off of [gravejester's](https://github.com/gravejester/Communary.PASM/blob/master/Functions/Select-FuzzyString.ps1) fuzzy search function and modified it to fit my needs. For part (5), I waited until the end to try and build a recursive function that would complete this task but I was unable to completely finish it.
 
 After implementing a large portion of the code, I used POSH GUI to generate a GUI that I used to output the results of the code. 
## Details
### Downloading Sample Data
PowerShell provides a quick and easy way to download files by way of the Invoke-WebRequest Command 
```PowerShell
$url ='https://www.twinthread.com/code-challenge/assets.txt'
$response = Invoke-WebRequest -Uri $url
```
Since we are working with a json file I then convert it to json for use later in the script.
```PowerShell
$jsonResponse = $response | ConvertFrom-Json
```
### Search Functionality
As mentioned before, the fuzzy search part of my searching was an edit of [gravejester's](https://github.com/gravejester/Communary.PASM/blob/master/Functions/Select-FuzzyString.ps1) work. I had to modify it so that you could pass in individual characteristics for it to search, but then have it return the entire json associated with the given parameter. I also added a parameter to deal with the possibility of general searches.
```PowerShell
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Field,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $GeneralSearch = $false
  ```
  I then made another function that calls this fuzzy search, using a switch statement based on the different parameters in the json file
 .
 ```PowerShell
 switch($searchType){
        "assetId" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
        "name" {$result = $jsonResponse.assets | Select-FuzzyString $searchStr -Field $searchType -GeneralSearch $general | Sort-Object Score,Result -Descending}
etc.
```
### Critical Assets
For this part I made a function that does a simple search through the assets and prints out the ones with critical status.
```PowerShell
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
```
### Count of Unique Class Names
Providing this functionality meant using hash tables to keep track of which classes had already been seen before and then adding the name of the asset to the value held in the hash table for every asset.
```PowerShell
if($nameHash.ContainsKey($class.name)){
                $nameHash[$class.name]=$nameHash[$class.name]+"`r`n"+$asset.name
            }
            #otherwise, add it in
            else{
                $nameHash.Add($class.name,$asset.name)
            }
```
There was a lot of string parsing that went on in order to make this look nice afterwards. I acknowledge that simply adding the string to the hashtable value might not be the most elegant way to do this but it doesn't waste much space and still allows the user to see what they want to see.
### Build a visual hierarchy
I was unable to complete this part of the challenge but I did begin implementation. My idea was to use a hashtable of arraylists that keep track of the children of each id. This would be done by iterating through the list at startup and adding to the arraylists using the parentId stored in the JSON. When passed the id to visualize, I would then recursively access the hashtable to print out the children. I'm not sure how I would visualize the relationship, there are several ways that would work.

### GUI
As mentioned before, I used POSHGUI to generate my GUI pieces and then modified their Add_Click() functionality to do the specific function calls. I used a single multiline textbox with scrolling to print all of the output to.

## Other Sources
- [Kevin Marquette's PowerShell resources](https://kevinmarquette.github.io/) are amazing 
- [Stack Overflow](https://stackoverflow.com/) is generally a life-saver for quick help
