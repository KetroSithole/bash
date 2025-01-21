
$desktopPath = [Environment]::GetFolderPath('Desktop')

function Write-Log {
    param (
        [string]$Message,
        [string]$Type = "INFO"
    )
    $logFile = Join-Path -Path $desktopPath -ChildPath "FileOrganizerLog.txt"
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "[$timestamp] [$Type] $Message"
    Add-Content -Path $logFile -Value $logMessage
    if ($Type -eq "ERROR") {
        Write-Error $Message
    } elseif ($Type -eq "WARNING") {
        Write-Warning $Message
    } else {
        Write-Host $Message
    }
}

# Check if the Desktop path exists
if (-Not (Test-Path $desktopPath)) {
    Write-Log -Message "Desktop path not found. Please verify your environment settings." -Type "ERROR"
    exit
}

Write-Log -Message "Starting file organization process on the Desktop." -Type "INFO"

# Get all files from the Desktop
try {
    $files = Get-ChildItem -Path $desktopPath -File -ErrorAction Stop
    Write-Log -Message "Retrieved $(($files | Measure-Object).Count) file(s) from the Desktop." -Type "INFO"
} catch {
    Write-Log -Message "Failed to retrieve files from the Desktop. Error: $_" -Type "ERROR"
    exit
}


if ($files.Count -eq 0) {
    Write-Log -Message "No files found on the Desktop. Exiting script." -Type "INFO"
    exit
}

# Initialize counters for reporting
$filesMoved = 0
$filesSkipped = 0
$foldersCreated = 0

# Process each file
foreach ($file in $files) {
    try {
        Write-Log -Message "Processing file: $($file.Name)" -Type "INFO"
        
        # Determine the file extension
        $extension = $file.Extension.ToLower()
        if (-not $extension) {
            $extension = "NoExtension"
            Write-Log -Message "File '$($file.Name)' has no extension. Categorizing as 'NoExtension'." -Type "WARNING"
        }

        # Generate folder path based on extension
        $folderName = $extension.TrimStart('.')
        $folderPath = Join-Path -Path $desktopPath -ChildPath $folderName

        # Create folder if it doesn't exist
        if (-not (Test-Path $folderPath)) {
            try {
                New-Item -Path $folderPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
                $foldersCreated++
                Write-Log -Message "Created folder: $folderPath" -Type "INFO"
            } catch {
                Write-Log -Message "Failed to create folder '$folderPath'. Error: $_" -Type "ERROR"
                continue
            }
        } else {
            Write-Log -Message "Folder '$folderPath' already exists." -Type "INFO"
        }

        # Move the file to the folder
        $destination = Join-Path -Path $folderPath -ChildPath $file.Name
        if (-not (Test-Path $destination)) {
            try {
                Move-Item -Path $file.FullName -Destination $destination -Force -ErrorAction Stop
                $filesMoved++
                Write-Log -Message "Moved file '$($file.Name)' to folder '$folderName'." -Type "INFO"
            } catch {
                Write-Log -Message "Failed to move file '$($file.Name)' to '$folderName'. Error: $_" -Type "ERROR"
            }
        } else {
            $filesSkipped++
            Write-Log -Message "File '$($file.Name)' already exists in folder '$folderName'. Skipping..." -Type "WARNING"
        }
    } catch {
        Write-Log -Message "An error occurred while processing file '$($file.FullName)'. Error: $_" -Type "ERROR"
    }
}

# Final Summary
Write-Log -Message "File organization process completed." -Type "INFO"
Write-Log -Message "Summary:" -Type "INFO"
Write-Log -Message "  Files moved: $filesMoved" -Type "INFO"
Write-Log -Message "  Files skipped: $filesSkipped" -Type "INFO"
Write-Log -Message "  Folders created: $foldersCreated" -Type "INFO"
Write-Log -Message "Logs saved to 'FileOrganizerLog.txt' on the Desktop." -Type "INFO"

Write-Host "File organization complete. Summary:"
Write-Host "  Files moved: $filesMoved"
Write-Host "  Files skipped: $filesSkipped"
Write-Host "  Folders created: $foldersCreated"
Write-Host "Logs saved to 'FileOrganizerLog.txt' on the Desktop."
