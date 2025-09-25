# 🚨 IMMEDIATE FIX FOR CACHE ISSUES

You're seeing this error because VS Code is using cached DevContainer metadata that references old features.

## For WSL + Docker Setup (Your Configuration)

Since you're using Docker in WSL (not Docker Desktop), you need to run the cleanup from within WSL:

```bash
# From your WSL terminal, navigate to your project
cd /mnt/c/GitHub_paulwu/SpecKitTest
bash .devcontainer/cleanup.sh
```

## For Docker Desktop Users Only

- PowerShell: `.\.devcontainer\cleanup.ps1` (Windows with Docker Desktop)
- Batch: `.devcontainer\cleanup.bat` (Windows with Docker Desktop)

## After Running Cleanup

1. **Close VS Code completely**
2. **Reopen VS Code and your project**
3. **Press Ctrl+Shift+P**
4. **Select "Dev Containers: Rebuild Container Without Cache"**

## Alternative: Simple Configuration

If cleanup doesn't work, try the minimal config:

```bash
# From WSL
cd /mnt/c/GitHub_paulwu/SpecKitTest/.devcontainer
cp devcontainer.json devcontainer-backup.json
cp devcontainer-simple.json devcontainer.json
```

Then rebuild the container.

---

**Note**: The PowerShell and batch scripts only work if you have Docker Desktop installed on Windows. Since you're using Docker in WSL, you must use the bash script from within your WSL environment.

The issue is that Docker/VS Code cached the old configuration that used external features from ghcr.io. The cleanup scripts will remove this cached data.