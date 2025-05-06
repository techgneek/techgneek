 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : James Moore
    LinkedIn        : linkedin.com/in/jamesmoore1983
    GitHub          : github.com/techgneek
    Date Created    : 2025-06-05
    Last Modified   : 2025-06-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-06-05
    Tested By       : James Moore
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE


# Filename: Update-EventLogPolicy.ps1

# --- Part 1: Get last CMD command used ---
Write-Host "`n[+] Last CMD Command:" -ForegroundColor Cyan
cmd /c "doskey /history" | Select-Object -Last 1

# --- Part 2: Set EventLog MaxSize Policy ---
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$propertyName = "MaxSize"
$propertyValue = 0x8000  # 32,768 KB

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    Write-Host "[+] Registry path not found. Creating path..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the MaxSize DWORD value
Write-Host "[+] Setting MaxSize to $propertyValue (32MB) at $regPath" -ForegroundColor Cyan
New-ItemProperty -Path $regPath -Name $propertyName -PropertyType DWord -Value $propertyValue -Force | Out-Null

Write-Host "`n[✔] Registry setting applied successfully!" -ForegroundColor Green
 
