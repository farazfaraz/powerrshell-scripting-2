# PowerShell Script: Delete Old Folders

## Overview
This PowerShell script helps manage and clean up old folders by:
- **Automatically deleting folders older than a specified number of days**.
- **Allowing the user to select a predefined or custom directory**.
- **Ensuring user input validation and safe execution**.

## Features
✅ **Automatic Folder Cleanup** – Deletes folders based on their creation date.  
✅ **User-Friendly Menu** – Offers options to select predefined or custom paths.  
✅ **Secure Execution** – Ensures valid inputs before performing deletions.  
✅ **Color-Coded Feedback** – Uses different colors for warnings, confirmations, and errors.  

## Requirements
- Windows OS with **PowerShell**.
- Access to the **network drive** (`\\YOUR_DRIVE`).
- Proper permissions to delete folders.

## How It Works
### 1️⃣ Running the Script
Run the script using PowerShell:
```
.\Delete-OldFolders.ps1
```

##Choose an option:
1. Delete all subfolders under the predefined drive path (\YOUR_DRIVE).
2. Specify a custom folder whose contents you want to delete (e.g., 'YOUR_DIRECTORY').
