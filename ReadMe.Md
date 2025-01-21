

# **Desktop File Organizer (RPA Project Starter)**

This project provides an **RPA (Robotic Process Automation)** starter script written in PowerShell to automate the organization of files on your desktop. It groups files into folders based on their file types (extensions), making your desktop clean and organized. This solution is beginner-friendly and serves as an excellent starting point for learning RPA concepts.

## **Features**
- **File Type Detection**: Automatically identifies file types based on their extensions.
- **Dynamic Folder Creation**: Creates folders dynamically for each file type.
- **Error Handling**: Comprehensive error handling to manage unexpected issues.
- **Logging**: Generates a log file (`FileOrganizerLog.txt`) to document every action taken.
- **Duplicate Handling**: Detects and skips duplicate files gracefully.

---

## **How It Works**
1. **Scan Files**: The script scans all files on the user's desktop.
2. **Group by File Type**: Files are categorized by their extensions. Files without extensions are placed in a folder named `NoExtension`.
3. **Move Files**: Each file is moved to the corresponding folder.
4. **Log Actions**: A detailed log of actions, errors, and skipped files is saved to the desktop.

---

## **Setup Instructions**

### Prerequisites
- **Windows OS**: This script is designed to run on Windows.
- **PowerShell**: Ensure you have PowerShell 5.1 or later installed.

### Installation
1. Download the script file `OrganizeFiles.ps1`.
2. Save the file to a convenient location on your computer.

### Running the Script
1. **Open PowerShell**: Press `Win + S`, type `PowerShell`, right-click on it, and select **Run as Administrator**.
2. Navigate to the script's location using the `cd` command. Example:
   ```powershell
   cd "C:\Path\To\Script"
   ```
3. Run the script:
   ```powershell
   .\OrganizeFiles.ps1
   ```

### Post-Run Outputs
- **Organized Folders**: Your desktop will have new folders based on file types.
- **Log File**: A `FileOrganizerLog.txt` file will be created on your desktop with a summary of actions.

---

## **Example Log Output**
```text
[2025-01-21 14:32:45] [INFO] Starting file organization process on the Desktop.
[2025-01-21 14:32:47] [INFO] Retrieved 10 file(s) from the Desktop.
[2025-01-21 14:32:48] [INFO] Created folder: C:\Users\Username\Desktop\pdf
[2025-01-21 14:32:49] [INFO] Moved file 'document.pdf' to folder 'pdf'.
[2025-01-21 14:32:50] [WARNING] File 'example.txt' already exists in folder 'txt'. Skipping...
[2025-01-21 14:32:51] [INFO] File organization process completed.
[2025-01-21 14:32:51] [INFO] Summary:
[2025-01-21 14:32:51] [INFO]   Files moved: 8
[2025-01-21 14:32:51] [INFO]   Files skipped: 2
[2025-01-21 14:32:51] [INFO]   Folders created: 5
```

---

## **Customization**
- Modify the `$desktopPath` variable to organize files in a different directory.
- Enhance the script to handle additional scenarios, such as archiving files or integrating with cloud storage.

---

## **Error Handling**
- The script catches errors during file retrieval, folder creation, and file movement.
- All errors are logged in the `FileOrganizerLog.txt` file for debugging.

---

## **Future Enhancements**
This project can be extended to include:
- **Scheduler Integration**: Automate the script to run at regular intervals using Windows Task Scheduler.
- **Email Notifications**: Send a summary of actions via email.
- **Advanced File Grouping**: Group files based on additional metadata like creation date or size.

---

## **Contributing**
Contributions are welcome! Feel free to fork this repository and submit pull requests with improvements.

---

## **License**
This project is open-source under the [MIT License](LICENSE).

---

Start automating and organizing today!