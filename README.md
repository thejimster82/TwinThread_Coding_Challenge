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

  I chose to use PowerShell for this challenge as I had experience with it at my Genworth internship and I knew it would make things like downloading files and dealing with hashtables much easier. I focused at first on doing what I saw as the easiest tasks, downloading the sample data (1), giving a count of unique class names (4) and listing all classes with critical status(3). I was able to implement code to complete these three parts of the challenge using a variety of methods. While I did not format them in a way that was super easy to read, I did put their output to a GUI that will be mentioned later.
 
 For part (2), I based my implementation off of [gravejester's](https://github.com/gravejester/Communary.PASM/blob/master/Functions/Select-FuzzyString.ps1) fuzzy search function and modified it to fit my needs. For part (5), I waited until the end to try and build a recursive function that would complete this task but I was unable to completely finish it.
 
 After implementing a large portion of the code, I used POSH GUI to generate a GUI that I used to output the results of the code. 
