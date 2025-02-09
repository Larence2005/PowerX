# PowerX

PowerX is a powerful PowerShell-based multi-tool designed to simplify Windows command execution. It allows users to analyze networks, retrieve system information and Wi-Fi stored passwords, fix critical files, and enhance security—all from a user-friendly menu interface.

## Features

PowerX includes **33 simplified Windows commands** across various categories:

### Networking
- Ping a host
- Flush DNS
- Display IP configuration
- Trace route
- Display ARP table
- Release & renew IP
- Display network statistics

### System Information
- Display system details
- View disk usage
- List running processes
- Show installed drivers
- Display boot configuration
- View environment variables

### Wi-Fi Management
- Show Wi-Fi profiles
- Retrieve Wi-Fi passwords
- Disconnect from Wi-Fi

### File Fixer
- Run System File Checker (SFC)
- Execute Check Disk (chkdsk)
- Repair system image (DISM)
- Fix boot configuration

### Security & Access
- Enable/disable firewall
- Scan for malware (quick & full scan)
- Kill a process by PID
- Display open ports
- View user accounts

### Advanced Commands
- Query/start/stop Windows services
- Query/add/delete registry keys

## Installation
### Option 1
1. Download the PowerX from the [PowerX v1.0.0.zip](https://github.com/user-attachments/files/18725396/PowerX.v1.0.0.zip).
2. Open PowerX.exe as Administrator.

### Option 2
1. Download the PowerX script from the [GitHub repository](https://github.com/Larence2005/PowerX).
2. Open PowerX.ps1 as Administrator.
   
### Option 3
1. Download the PowerX script from the [GitHub repository](https://github.com/Larence2005/PowerX).
2. Open PowerShell as Administrator.
3. Navigate to the script directory:
   ```powershell
   cd path\to\PowerX
   ```
4. Run the script:
   ```powershell
   .\PowerX.ps1
   ```

> **Note:** Ensure execution policy allows running scripts:
> ```powershell
> Set-ExecutionPolicy Bypass -Scope Process -Force
> ```

## Convert PowerShell Script (.ps1) to Executable (.exe)

### Prerequisites
- Windows OS
- PowerShell 5.1 or later
- Administrator privileges (for module installation)

### Installation
First, install the **ps2exe** module by running the following command in PowerShell:
```powershell
Install-Module -Name ps2exe -Scope CurrentUser
```
If prompted to install from an untrusted repository, type **Y** and press **Enter**.

### Convert PS1 to EXE
Use the following command to convert your PowerShell script to an executable:
```powershell
ps2exe "C:\path\to\your\script.ps1" "C:\path\to\output.exe"
```
Example:
```powershell
ps2exe "C:\Scripts\PowerX.ps1" "C:\Scripts\PowerX.exe"
```

### Additional Options
You can customize the conversion using various parameters:
- **Hide PowerShell console:** `-noConsole`
- **Set architecture:** `-x86` (32-bit) or `-x64` (64-bit)
- **Embed an icon:** `-icon "C:\path\to\icon.ico"`

Example with additional options:
```powershell
ps2exe "PowerX.ps1" "PowerX.exe" -noConsole -x64 -icon "icon.ico"
```

### Troubleshooting
- If the command is not recognized, restart PowerShell and try again.
- If execution policy errors occur, run:
  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force
  ```

### Developer
**John Larence Lusaya**

Buy me a coffee:
**Bitcoin:** `bc1qayxlfxvyjcspkq85fjh454hlpcgsqaclvus33d`
