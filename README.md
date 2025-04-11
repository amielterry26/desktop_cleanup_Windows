# Desktop Cleanup Script (Windows)

This PowerShell script organizes files on your Windows Desktop into categorized folders based on file type. It’s designed to help you stay organized while giving you a quick way to undo changes if needed.

---

## Features

- Moves files into a `Desktop Cleanup` folder with subfolders:
    - `Documents` — PDF, Word, Excel, PowerPoint, and text files
    - `Media` — Images, audio, video files
    - `Other` — Everything else
- Displays detailed logs of moved files
- Calculates file sizes in MB
- Shows grouped output and a final summary
- Skips itself (`desktop_cleanup.ps1`), the restore script (`desktop_restore.ps1`), and the cleanup folder

---

## Scripts Included

### `desktop_cleanup.ps1`

Organizes all files from your Desktop into `Desktop Cleanup/Documents`, `Media`, and `Other`.

### `desktop_restore.ps1`

Restores files from the `Desktop Cleanup` folder back to their original location on the Desktop.

---

## How to Use

### Step 1: Download the Scripts

Place both of these scripts directly on your Desktop:

- `desktop_cleanup.ps1`
- `desktop_restore.ps1`

### Step 2: Run the Cleanup Script

Right-click the file and choose:

**`Run with PowerShell`**

Or from PowerShell manually:

```powershell
& "$HOME\Desktop\desktop_cleanup.ps1"
```

### Step 3: Restore (If Needed)

To undo the cleanup and move everything back:

```powershell
& "$HOME\Desktop\desktop_restore.ps1"
```

> **Note:** These scripts will not move themselves. They are always left on your Desktop for easy access.

---

## Example Output

```
==================== RESULTS ====================

Documents:
 - report.docx (1.23 MB) moved to Documents
 - notes.txt (0.75 MB) moved to Documents

Media:
 - vacation.jpg (2.01 MB) moved to Media

Other:
 - setup.exe (5.40 MB) moved to Other

==================== SUMMARY ====================
Documents: 2 file(s), 1.98 MB
Media:     1 file(s), 2.01 MB
Other:     1 file(s), 5.40 MB

Desktop cleanup complete.
```

---

## PowerShell Execution Policy

If you’re unable to run the scripts due to permissions, allow scripts for the current user with:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

---

## Disclaimer

These scripts **move files** on your Desktop. Always test in a safe environment before using in sensitive or shared environments. No files are deleted — just moved.

---

## License

MIT License — use freely, modify responsibly.

---

## Author

Crafted with obsessive attention to detail by 🧙🏾‍♂️‍ [Amiel Terry](https://amielterry.me) & Arcane Systems LLC