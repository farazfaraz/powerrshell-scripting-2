# Function to delete folders older than the specified number of days
function Delete-OldFolders {
    param (
        [string]$Path,       # Path to search for folders
        [int]$Days           # Number of days to determine the cutoff
    )

    # Calculate the cutoff date
    $cutoffDate = (Get-Date).AddDays(-$Days)

    # Get all immediate subfolders of the specified path
    Get-ChildItem -Path $Path -Directory | ForEach-Object {
        $folderCreationDate = $_.CreationTime

        # Print folder details
        Write-Host "Folder: $($_.FullName) (Created: $folderCreationDate)" -ForegroundColor Yellow

        # Check if the folder is older than the cutoff date
        if ($folderCreationDate -lt $cutoffDate) {
            Write-Host "    Deleting folder: $($_.FullName)" -ForegroundColor Red
            Remove-Item -Path $_.FullName -Recurse -Force
        }
    }
}

net use U: \\YOUR_DRIVE /user:YOUR_USER_NAME YOUR_PASSWORD

# Prompt the user to choose an option
Write-Host "Choose an option:"
Write-Host "1. Delete all subfolders under the predefined drive path (\YOUR_DRIVE)."
Write-Host "2. Specify a custom folder whose contents you want to delete(e.g., 'YOUR_DIRECTORY')."
$choice = Read-Host "Enter your choice (1 or 2)"

# Option 1: Predefined path
if ($choice -eq "1") {
    # Print top-level folders under the U drive and their immediate subfolders
	# Prompt the user to enter the number of days to delete old folders
    $days = Read-Host "Enter the number of days (folders older than this will be deleted)"
    # Validate the input is a number
    if ([int]::TryParse($days, [ref]$null)) {
		Get-ChildItem -Path U:\ -Directory | ForEach-Object {
				# Print the top-level folder
				Write-Host "Top-Level Folder: $($_.FullName)" -ForegroundColor Green
				Delete-OldFolders -Path $_.FullName -Days $days
		}
    } else {
        Write-Host "Invalid input for the number of days. Please enter a valid number." -ForegroundColor Red
        }
}

# Option 2: Custom path
elseif ($choice -eq "2") {
    # Prompt the user to enter a custom path
    $customPath = Read-Host "Enter the relative path under U:\ (e.g., 'YOUR_DIRECTORY')"
    $fullPath = Join-Path "U:\" $customPath

    # Validate the path
    if (Test-Path $fullPath) {
        Write-Host "Valid path: $fullPath" -ForegroundColor Green

        # Prompt the user for the number of days
        $days = Read-Host "Enter the number of days (folders older than this will be deleted)"

        # Validate the input is a number
        if ([int]::TryParse($days, [ref]$null)) {
            # Call the function to delete old folders
            Delete-OldFolders -Path $fullPath -Days $days
        } else {
            Write-Host "Invalid input for the number of days. Please enter a valid number." -ForegroundColor Red
        }
    } else {
        Write-Host "Invalid path: $customPath. Please try again." -ForegroundColor Red
    }
}
# Invalid choice
else {
    Write-Host "Invalid choice. Please run the script again and choose either 1 or 2." -ForegroundColor Red
}

# Remove the PSDrive
Remove-PSDrive -Name U
