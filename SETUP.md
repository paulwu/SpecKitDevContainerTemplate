# 🛠️ Complete Setup Guide

This guide walks you through setting up the development environment for this Spec-Kit project using Docker and WSL.

## 📋 System Requirements

- Windows 10/11 (version 2004 or higher)
- At least 8GB RAM (16GB recommended)
- 10GB free disk space
- Administrator access for initial setup

## 🔧 Step-by-Step Installation

### Step 1: Install WSL2

1. **Open PowerShell as Administrator**
   ```powershell
   # Install WSL2 with Ubuntu (default)
   wsl --install
   
   # If WSL is already installed, update to WSL2
   wsl --set-default-version 2
   ```

2. **Restart your computer** when prompted

3. **Complete Ubuntu setup**
   - Ubuntu will launch automatically
   - Create a username and password when prompted
   - Remember these credentials - you'll need them for `sudo` commands

4. **Verify WSL2 installation**
   ```powershell
   # Check WSL version (should show version 2)
   wsl --list --verbose
   ```

### Step 2: Install Docker in WSL

1. **Open your WSL terminal** (Ubuntu)

2. **Update package lists**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

3. **Install Docker**
   ```bash
   # Install Docker
   sudo apt install -y docker.io
   
   # Add your user to docker group
   sudo usermod -aG docker $USER
   
   # Enable Docker service
   sudo systemctl enable docker
   ```

4. **Start Docker** (you'll need to do this each time you restart WSL)
   ```bash
   sudo service docker start
   ```

5. **Test Docker installation**
   ```bash
   # This should work without sudo after logout/login
   docker --version
   docker run hello-world
   ```

   **Note:** If you get permission errors, log out and back into WSL:
   ```bash
   exit  # then reopen WSL terminal
   ```

### Step 3: Install VS Code and Extensions

1. **Install VS Code** (if not already installed)
   - Download from [code.visualstudio.com](https://code.visualstudio.com/)
   - Install on Windows (not in WSL)

2. **Install required VS Code extensions**
   - [WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Step 4: Clone and Open Project

1. **Clone the project in WSL**
   ```bash
   # Navigate to your home directory
   cd ~
   
   # Clone the repository
   git clone <your-repository-url>
   cd SpecKitDevContainerBase
   ```

2. **Open in VS Code from WSL**
   ```bash
   # This opens VS Code connected to WSL
   code .
   ```

### Step 5: Start the DevContainer

1. **Ensure Docker is running**
   ```bash
   sudo service docker start
   ```

2. **In VS Code:**
   - You should see a notification: "Folder contains a Dev Container configuration file"
   - Click **"Reopen in Container"**
   - If you miss the notification: `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"

3. **Wait for setup** (first time takes 5-10 minutes)
   - Container will be built and configured
   - Dependencies will be installed
   - Spec-Kit CLI will be set up

4. **Verify installation**
   ```bash
   # Open terminal in VS Code and run
   specify check
   ```

## ⚡ Daily Workflow

### Starting Your Development Session

1. **Open WSL terminal**
   ```bash
   # Start Docker
   sudo service docker start
   
   # Navigate to project
   cd ~/SpecKitDevContainerTemplate
   
   # Open in VS Code
   code .
   ```

2. **If DevContainer isn't running:**
   - `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"

### Stopping Your Development Session

- Simply close VS Code
- Docker container stops automatically
- WSL stays running (or you can close the terminal)

## 🚨 Troubleshooting

### Docker Issues

**Problem:** `docker: permission denied`
```bash
# Solution: Add user to docker group and restart session
sudo usermod -aG docker $USER
exit  # then reopen WSL terminal
```

**Problem:** `Cannot connect to the Docker daemon`
```bash
# Solution: Start Docker service
sudo service docker start
```

**Problem:** `docker: command not found`
```bash
# Solution: Reinstall Docker
sudo apt update
sudo apt install -y docker.io
```

### WSL Issues

**Problem:** WSL is slow or VS Code can't find files
- **Cause:** Project is on Windows filesystem (`/mnt/c/...`)
- **Solution:** Move project to WSL filesystem (`/home/username/...`)

**Problem:** `wsl --install` doesn't work
```powershell
# Enable WSL feature manually
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart computer, then install Ubuntu
wsl --install -d Ubuntu
```

### DevContainer Issues

**Problem:** Container build fails with network errors
```bash
# Clear Docker cache and try again
docker system prune -a
# Then rebuild in VS Code
```

**Problem:** VS Code shows "Dev Containers extension not found"
- Install the Dev Containers extension from VS Code marketplace
- Ensure VS Code is connected to WSL (bottom left should show "WSL: Ubuntu")

### VS Code Issues

**Problem:** VS Code opens in Windows mode instead of WSL
- Always run `code .` from WSL terminal
- Check bottom left corner shows "WSL: Ubuntu"
- If not: `Ctrl+Shift+P` → "WSL: Connect to WSL"

## 🔄 Auto-Start Docker (Optional)

To avoid running `sudo service docker start` every time:

```bash
# Add to your ~/.bashrc
echo 'sudo service docker start > /dev/null 2>&1' >> ~/.bashrc

# Or create an alias
echo 'alias start-docker="sudo service docker start"' >> ~/.bashrc
```

## 📞 Getting Help

If you encounter issues not covered here:

1. **Check Docker status:** `sudo service docker status`
2. **Check WSL version:** `wsl --list --verbose` (from PowerShell)
3. **Check VS Code connection:** Bottom left should show "WSL: Ubuntu"
4. **Clear caches:** `docker system prune -a` (from WSL)
5. **Restart WSL:** `wsl --shutdown` (from PowerShell), then reopen

## 🎯 Success Checklist

- [ ] WSL2 installed and working
- [ ] Docker installed in WSL and running
- [ ] VS Code with WSL + Dev Containers extensions
- [ ] Project cloned in WSL filesystem (`~/SpecKitDevContainerTemplate`)
- [ ] DevContainer opens without errors
- [ ] `specify check` command works in container terminal

Once all items are checked, you're ready to start developing with Spec-Kit! 🎉