param (
    [string]$inputFile,  # Path to the input large text file
    [int]$linesPerFile = 100000,  # Number of lines per smaller file (default to 100000)
    [string]$outputFolder,  # Path to the output folder
    [switch]$removeDuplicates  # Option to remove duplicate lines
)

# Function to display help
function Show-Help {
    Write-Host "Usage: .\SplitLargeText.ps1 -input 'Path' -LPF 'NumberOfLines' -output 'OutputPath' [options]"
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -input         Path to the input large text file."
    Write-Host "  -LPF           (Optional) Number of lines per smaller file. Default is 100000."
    Write-Host "  -output        Path to the output folder where smaller files will be saved."
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -removeDuplicates  (Optional) Remove duplicate lines from the input file before splitting."
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  .\SplitLargeText.ps1 -input 'C:\Path\to\largeFile.txt' -LPF 1000 -output 'C:\Path\to\outputFolder'"
    Write-Host "  .\SplitLargeText.ps1 -input 'C:\Path\to\largeFile.txt' -LPF 1000 -output 'C:\Path\to\outputFolder' -removeDuplicates"
    Write-Host ""
    Write-Host "This script splits a large text file into smaller files and optionally removes duplicates."
}

# If no parameters are provided, show the help page
if (-not $inputFile -or -not $outputFolder) {
    Show-Help
    exit
}

# Validate input file path
if (-not (Test-Path $inputFile)) {
    Write-Host "Error: The input file path '$inputFile' does not exist." -ForegroundColor Red
    exit 1
}

# Validate output folder path
if (-not (Test-Path $outputFolder)) {
    Write-Host "Error: The output folder path '$outputFolder' does not exist. Creating folder..." -ForegroundColor Yellow
    try {
        New-Item -ItemType Directory -Force -Path $outputFolder
    } catch {
        Write-Host "Error: Unable to create the output folder. $_" -ForegroundColor Red
        exit 1
    }
}

# Initialize variables for file splitting
$lineNumber = 0
$fileIndex = 1
$inputFileName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)  # Get the name of the input file without extension
$outputFile = "$outputFolder\$inputFileName`_Part$fileIndex.txt"

# Open StreamReader to read input file and StreamWriter to write output files
$reader = [System.IO.StreamReader]::new($inputFile)
$writer = [System.IO.StreamWriter]::new($outputFile)

# If removing duplicates, initialize a HashSet
$seen = if ($removeDuplicates) { New-Object System.Collections.Generic.HashSet[String] } else { $null }

# Display starting message
Write-Host "Splitting of '$inputFileName.txt' started. This might take a while..." -ForegroundColor Cyan

# Read and process the file line by line
while ($null -ne ($line = $reader.ReadLine())) {
    # If removing duplicates, check if the line has been seen before
    if ($removeDuplicates) {
        if (-not $seen.Contains($line)) {
            $seen.Add($line)
            $writer.WriteLine($line)
        }
    } else {
        $writer.WriteLine($line)
    }

    $lineNumber++

    # If the line count exceeds the maximum lines per file, start a new file
    if ($lineNumber -ge $linesPerFile) {
        $writer.Close()  # Close the current output file
        $fileIndex++  # Increment the file index
        $outputFile = "$outputFolder\$inputFileName`_Part$fileIndex.txt"  # New output file path
        $writer = [System.IO.StreamWriter]::new($outputFile)  # Open new file for writing
        $lineNumber = 0  # Reset line number for the new file
        Write-Host "Processed $($fileIndex * $linesPerFile) lines so far..." -ForegroundColor Green
    }
}

# Ensure the last file is saved
$writer.Close()
$reader.Close()

Write-Host "The file has been split into $fileIndex parts." -ForegroundColor Green
