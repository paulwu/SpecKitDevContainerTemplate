# PowerShell Script Usage Note

## ⚠️ When to Use This Script

This PowerShell script (`cleanup.ps1`) should **only** be used if you have:

- **Docker Desktop installed on Windows**
- Docker daemon running on the Windows host (not in WSL)

## ❌ When NOT to Use This Script

**Do NOT use this script if you:**

- Are using Docker in WSL (like the project owner)
- Have Docker installed only in a Linux VM or container
- Are running Docker through WSL2 integration

## ✅ For WSL + Docker Users

If you're using Docker in WSL (which is more common and efficient), use the bash script instead:

```bash
# From your WSL terminal
cd /mnt/c/GitHub_paulwu/SpecKitTest
bash .devcontainer/cleanup.sh
```

## Why This Matters

The PowerShell script tries to communicate with Docker through Windows, but if Docker is running in WSL, the Windows PowerShell can't reach the Docker daemon. This will result in "docker: command not found" or "Cannot connect to the Docker daemon" errors.

## Alternative Approaches

1. **WSL + Docker**: Use `cleanup.sh` from WSL terminal
2. **Docker Desktop**: Use `cleanup.ps1` from Windows PowerShell
3. **Command Prompt**: Use `cleanup.bat` from Windows Command Prompt (Docker Desktop only)