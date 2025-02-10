# Set console properties
$host.UI.RawUI.WindowTitle = "PowerX"

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.FontSize = 30
$pshost = $host.UI.RawUI
$size = $pshost.WindowSize
$size.Width = 106
$size.Height = 41
$pshost.WindowSize = $size
Clear-Host

# Function to check for administrator privileges
function Test-Admin {
    $currentUser = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Request UAC elevation if not running as admin
if (-not (Test-Admin)) {
    Write-Host "Requesting administrator privileges..." -ForegroundColor Yellow
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
} else {
    Write-Host "Administrator privileges confirmed." -ForegroundColor Green
}

# Main Menu
function Show-MainMenu {
    Clear-Host
 Write-Host "                                                                    "-ForegroundColor Blue
 Write-Host "                                    _____                    __   __"-ForegroundColor Blue
 Write-Host "                                   |  __ \                   \ \ / /"-ForegroundColor Blue
 Write-Host "                                   | |__) |____      _____ _ _\ V /" -ForegroundColor Blue
 Write-Host "                                   |  ___/ _ \ \ /\ / / _ \ '__> <"  -ForegroundColor Blue
 Write-Host "                                   | |  | (_) \ V  V /  __/ | / . \" -ForegroundColor Blue
 Write-Host "                                   |_|   \___/ \_/\_/ \___|_|/_/ \_\"-ForegroundColor Blue
 Write-Host "                                                                    "-ForegroundColor Blue
 Write-Host "                  PowerX written in PowerShell that simplifies Windows command execution,"
 Write-Host "                   allowing you to scan and analyze networks and systems. It also fixes"
 Write-Host "                             sensitive or critical files to maintain system"
 Write-Host "                                         security and integrity."
 Write-Host ""
 
 Write-Host "                                    Developed by: John Larence Lusaya" -ForegroundColor Red
 Write-Host ""
 Write-Host "                           Bitcoin: bc1qayxlfxvyjcspkq85fjh454hlpcgsqaclvus33d"
 Write-Host ""
 Write-Host ""
 Write-Host ""
 Write-Host ""
 Write-Host ""
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "             MENU" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Networks" -ForegroundColor Green
    Write-Host "[2] System Information" -ForegroundColor Green
    Write-Host "[3] Wi-Fi" -ForegroundColor Green
    Write-Host "[4] File Fixer" -ForegroundColor Green
    Write-Host "[5] Security and Access" -ForegroundColor Green
    Write-Host "[6] Advanced" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Exit" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a category"
    switch ($choice) {
        1 { Show-NetworkingMenu }
        2 { Show-SystemInfoMenu }
        3 { Show-WiFiMenu }
        4 { Show-FileFixerMenu }
        5 { Show-SecurityAccessMenu }
        6 { Show-AdvancedCmdMenu }
        99 { exit }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-MainMenu
        }
    }
}

# Networking Tools Menu
function Show-NetworkingMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "           Networks" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Ping a Host" -ForegroundColor Green
    Write-Host "[2] Flush DNS" -ForegroundColor Green
    Write-Host "[3] Display IP Configuration" -ForegroundColor Green
    Write-Host "[4] Trace Route" -ForegroundColor Green
    Write-Host "[5] Display ARP Table" -ForegroundColor Green
    Write-Host "[6] Release and Renew IP" -ForegroundColor Green
    Write-Host "[7] Display Network Statistics" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {
        1 {
            $hostname = Read-Host "Enter IP or Website to ping"
            ping $hostname
            pause
            Show-NetworkingMenu
        }
        2 {
            ipconfig /flushdns
            pause
            Show-NetworkingMenu
        }
        3 {
            ipconfig /all
            pause
            Show-NetworkingMenu
        }
        4 {
            $hostname = Read-Host "Enter host to trace"
            tracert $hostname
            pause
            Show-NetworkingMenu
        }
        5 {
            arp -a
            pause
            Show-NetworkingMenu
        }
        6 {
            ipconfig /release
            ipconfig /renew
            pause
            Show-NetworkingMenu
        }
        7 {
            netstat -an
            pause
            Show-NetworkingMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-NetworkingMenu
        }
    }
}

# Wi-Fi Tools Menu
function Show-WiFiMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "             Wi-Fi" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Show Wi-Fi Profiles" -ForegroundColor Green
    Write-Host "[2] Show Wi-Fi Profiles with Keys" -ForegroundColor Green
    Write-Host "[3] Disconnect Wi-Fi" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {

	1 {
	    netsh wlan show profiles
	    pause
            Show-WiFiMenu
	}
        2 {
            $profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { $_ -replace ".*: ", "" }
            foreach ($profile in $profiles) {
                $password = netsh wlan show profile name="$profile" key=clear | Select-String "Key Content" | ForEach-Object { $_ -replace ".*: ", "" }
                Write-Host "Name: $profile" -ForegroundColor Green
                Write-Host "Password: $password" -ForegroundColor Green
                Write-Host
            }
            pause
            Show-WiFiMenu
        }
        3 {
            netsh wlan disconnect
            Write-Host "Wi-Fi disconnected." -ForegroundColor Green
            pause
            Show-WiFiMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-WiFiMenu
        }
    }
}

     
# System Information Menu
function Show-SystemInfoMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "      System Information" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Display System Info" -ForegroundColor Green
    Write-Host "[2] Display Disk Usage" -ForegroundColor Green
    Write-Host "[3] Display Running Processes" -ForegroundColor Green
    Write-Host "[4] Display Installed Drivers" -ForegroundColor Green
    Write-Host "[5] Display Boot Configuration" -ForegroundColor Green
    Write-Host "[6] Display Environment Variables" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {
        1 {
            systeminfo
            pause
            Show-SystemInfoMenu
        }
        2 {
            Get-WmiObject Win32_LogicalDisk | Format-Table DeviceID, Size, FreeSpace
            pause
            Show-SystemInfoMenu
        }
        3 {
            Get-Process
            pause
            Show-SystemInfoMenu
        }
        4 {
            Get-WmiObject Win32_PnPSignedDriver | Format-Table DeviceName, Manufacturer
            pause
            Show-SystemInfoMenu
        }
        5 {
            bcdedit
            pause
            Show-SystemInfoMenu
        }
        6 {
            Get-ChildItem Env:
            pause
            Show-SystemInfoMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-SystemInfoMenu
        }
    }
}

# File Fixer Tools Menu
function Show-FileFixerMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "          File Fixer" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Run System File Checker" -ForegroundColor Green
    Write-Host "[2] Run Check Disk" -ForegroundColor Green
    Write-Host "[3] Run DISM" -ForegroundColor Green
    Write-Host "[4] Repair Boot Configuration" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {
        1 {
            sfc /scannow
            pause
            Show-FileFixerMenu
        }
        2 {
            chkdsk /f
            pause
            Show-FileFixerMenu
        }
        3 {
            DISM /Online /Cleanup-Image /RestoreHealth
            pause
            Show-FileFixerMenu
        }
        4 {
            bootrec /rebuildbcd
            pause
            Show-FileFixerMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-FileFixerMenu
        }
    }
}

# Security and Access Tools Menu
function Show-SecurityAccessMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "     Security and Access" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Enable Firewall" -ForegroundColor Green
    Write-Host "[2] Disable Firewall" -ForegroundColor Green
    Write-Host "[3] Scan for Malware (Quick Scan)" -ForegroundColor Green
    Write-Host "[4] Scan for Malware (Full Scan)" -ForegroundColor Green
    Write-Host "[5] Kill a Process" -ForegroundColor Green
    Write-Host "[6] Display Open Ports" -ForegroundColor Green
    Write-Host "[7] Check User Accounts" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {
        1 {
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
            Write-Host "Firewall enabled." -ForegroundColor Green
            pause
            Show-SecurityAccessMenu
        }
        2 {
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
            Write-Host "Firewall disabled." -ForegroundColor Green
            pause
            Show-SecurityAccessMenu
        }
        3 {
            Start-MpScan -ScanType QuickScan
            pause
            Show-SecurityAccessMenu
	}
        4 {
            Start-MpScan -ScanType FullScan
            pause
            Show-SecurityAccessMenu
        }
        5 {
            $pid = Read-Host "Enter Process ID to kill"
            Stop-Process -Id $pid -Force
            if ($?) {
                Write-Host "Process killed successfully." -ForegroundColor Green
            } else {
                Write-Host "Error: Failed to kill process." -ForegroundColor Red
            }
            pause
            Show-SecurityAccessMenu
        }
        6 {
            netstat -an | Select-String "LISTENING"
            pause
            Show-SecurityAccessMenu
        }
        7 {
            Get-LocalUser
            pause
            Show-SecurityAccessMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-SecurityAccessMenu
        }
    }
}

# Advanced CMD Commands Menu
function Show-AdvancedCmdMenu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "            Advance" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "[1] Query Services (sc query)" -ForegroundColor Green
    Write-Host "[2] Start a Service (sc start)" -ForegroundColor Green
    Write-Host "[3] Stop a Service (sc stop)" -ForegroundColor Green
    Write-Host "[4] Query Registry Key (reg query)" -ForegroundColor Green
    Write-Host "[5] Add Registry Key (reg add)" -ForegroundColor Green
    Write-Host "[6] Delete Registry Key (reg delete)" -ForegroundColor Green
    Write-Host ""
    Write-Host "[99] Return to Main Menu" -ForegroundColor Green
    Write-Host "==============================" -ForegroundColor Green
    $choice = Read-Host "Select a command"
    switch ($choice) {
        1 {
            Get-Service
            pause
            Show-AdvancedCmdMenu
        }
        2 {
            $service = Read-Host "Enter service name to start"
            Start-Service -Name $service
            if ($?) {
                Write-Host "Service started successfully." -ForegroundColor Green
            } else {
                Write-Host "Error: Failed to start service." -ForegroundColor Red
            }
            pause
            Show-AdvancedCmdMenu
        }
        3 {
            $service = Read-Host "Enter service name to stop"
            Stop-Service -Name $service
            if ($?) {
                Write-Host "Service stopped successfully." -ForegroundColor Green
            } else {
                Write-Host "Error: Failed to stop service." -ForegroundColor Red
            }
            pause
            Show-AdvancedCmdMenu
        }
        4 {
            $key = Read-Host "Enter registry key to query"
            reg query $key
            pause
            Show-AdvancedCmdMenu
        }
        5 {
            $key = Read-Host "Enter registry key to add"
            $value = Read-Host "Enter value name"
            $data = Read-Host "Enter data"
            reg add $key /v $value /d $data /f
            if ($?) {
                Write-Host "Registry key added successfully." -ForegroundColor Green
            } else {
                Write-Host "Error: Failed to add registry key." -ForegroundColor Red
            }
            pause
            Show-AdvancedCmdMenu
        }
        6 {
            $key = Read-Host "Enter registry key to delete"
            reg delete $key /f
            if ($?) {
                Write-Host "Registry key deleted successfully." -ForegroundColor Green
            } else {
                Write-Host "Error: Failed to delete registry key." -ForegroundColor Red
            }
            pause
            Show-AdvancedCmdMenu
        }
        99 { Show-MainMenu }
        default {
            Write-Host "Invalid choice! Please try again." -ForegroundColor Red
            pause
            Show-AdvancedCmdMenu
        }
    }
}

# Start the script
Show-MainMenu
