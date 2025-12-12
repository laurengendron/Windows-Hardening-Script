Windows Hardening Script

A PowerShell-based Windows hardening script designed to apply essential security configurations on Windows 10/11 systems. This project demonstrates practical defensive security skills, system administration knowledge, and automation proficiency. It is ideal for IT support, cybersecurity, blue team, and endpoint management roles.

---

## 🔧 Features

* Disables **SMBv1** for improved security
* Enables all **Windows Firewall** profiles
* Disables unnecessary or high-risk services
* Enforces **strong password policies**
* Disables the built-in **Guest account**
* Generates a report of installed software
* Designed for beginners and adaptable for enterprise environments
* WARNING: “This script modifies system security settings. RUN AT YOUR OWN RISK.” Ideally, run in a virtual machine.
---

## 📂 Project Structure

```
Windows-Hardening-Script/
│
├── harden.ps1                # Main PowerShell script
├── README.md                 # Documentation
├── What-I-Learned            # Documentation


```

---

## 🚀 How to Use

1. Download or clone the repository:

   ```powershell
   git clone https://github.com/laurengendron/Windows-Hardening-Script.git
   ```
2. Navigate to the project folder:

   ```powershell
   cd Windows-Hardening-Script
   ```
3. Run the script as Administrator:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\harden.ps1
   ```

> **Note:** Some sections require admin rights and may modify system configuration.

---

## 📝 What This Script Hardens

### 🔒 SMBv1 Disabled

SMBv1 is an outdated and insecure protocol exploited by malware like **WannaCry**.

### 🔥 Firewall Enabled

Ensures Domain, Public, and Private firewall profiles are fully enabled.

### 🛑 Unnecessary Services Disabled

Disables services such as:

* Xbox-related services
* Telemetry-related services

### 🔐 Password Policy Hardening

* Minimum password length set to 12 characters
* Password complexity enforced

### 👤 Guest Account Disabled

Reduces risk of unauthorized logins.

### 📄 Installed Software Report

Exports a full list of installed programs for auditing or security review.

---

## 🛠️ Skills Demonstrated

* PowerShell scripting
* Windows security hardening
* Understanding of system services
* Firewall configuration
* Password and account policy management
* Logging and reporting
* Security automation fundamentals
* Blue team defensive practices

---


