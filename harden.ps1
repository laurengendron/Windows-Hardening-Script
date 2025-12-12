# Windows Hardening Script (PowerShell)
# This script applies basic security hardening settings.
# Sections:
# 1. Disable SMBv1
# 2. Enable all firewall profiles
# 3. Disable unnecessary services
# 4. Set strong password policies
# 5. Remove/disable guest account
# 6. List outdated or suspicious software

Write-Host "Starting Windows Hardening..." -ForegroundColor Cyan

# 1. Disable SMBv1
tTry {
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
    Write-Host "SMBv1 disabled." -ForegroundColor Green
} Catch {
    Write-Host "Failed to disable SMBv1: $_" -ForegroundColor Red
}

# 2. Enable all firewall profiles
Try {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
    Write-Host "Firewall profiles enabled." -ForegroundColor Green
} Catch {
    Write-Host "Error enabling firewall: $_" -ForegroundColor Red
}

# 3. Disable unnecessary services (example list)
$services = @(
    "XblGameSave",
    "XboxGipSvc",
    "XboxNetApiSvc",
    "DiagTrack" # Telemetry
)
foreach ($svc in $services) {
    Try {
        Set-Service -Name $svc -StartupType Disabled
        Write-Host "Disabled service: $svc" -ForegroundColor Yellow
    } Catch {
        Write-Host "Failed to disable service $svc: $_" -ForegroundColor Red
    }
}

# 4. Password Policy (requires admin + domain/local policy)
Try {
    secedit.exe /export /cfg C:\temp\policy.inf | Out-Null
    (Get-Content C:\temp\policy.inf).replace("MinimumPasswordLength = 0","MinimumPasswordLength = 12") | Set-Content C:\temp\policy.inf
    (Get-Content C:\temp\policy.inf).replace("PasswordComplexity = 0","PasswordComplexity = 1") | Set-Content C:\temp\policy.inf
    secedit.exe /configure /db C:\Windows\security\local.sdb /cfg C:\temp\policy.inf /areas SECURITYPOLICY | Out-Null
    Write-Host "Password policies enforced." -ForegroundColor Green
} Catch {
    Write-Host "Password policy change failed: $_" -ForegroundColor Red
}

# 5. Disable guest account
Try {
    net user guest /active:no
    Write-Host "Guest account disabled." -ForegroundColor Green
} Catch {
    Write-Host "Failed to disable guest account: $_" -ForegroundColor Red
}

# 6. List outdated or suspicious software
Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Sort-Object Name | Out-File C:\temp\installed_software.txt
Write-Host "Generated installed software report at C:\temp\installed_software.txt" -ForegroundColor Green

Write-Host "Hardening complete!" -ForegroundColor Cyan
