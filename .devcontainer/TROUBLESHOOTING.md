# DevContainer Troubleshooting Guide

If you're experiencing network or DNS issues with the DevContainer, you have several options:

## Option 1: Use the Current Configuration (Recommended)

The main `devcontainer.json` has been updated to remove external feature dependencies. Try rebuilding:

1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Select "Dev Containers: Rebuild Container"
3. Wait for the rebuild to complete

## Option 2: Use Dockerfile-based Configuration

If you still experience issues, switch to the Dockerfile-based configuration:

1. Rename `devcontainer.json` to `devcontainer-features.json`
2. Rename `devcontainer-dockerfile.json` to `devcontainer.json`
3. Rebuild the container

```bash
# In your terminal (from the repository root):
cd .devcontainer
mv devcontainer.json devcontainer-features.json
mv devcontainer-dockerfile.json devcontainer.json
```

Then rebuild the container in VS Code.

## Option 3: Use Simple Configuration

For the most basic setup with minimal dependencies:

1. Backup your current `devcontainer.json`
2. Replace it with `devcontainer-simple.json`
3. Rebuild the container

```bash
# In your terminal (from the repository root):
cd .devcontainer
mv devcontainer.json devcontainer-backup.json
mv devcontainer-simple.json devcontainer.json
```

## Option 4: Manual Installation (No DevContainer)

If DevContainers don't work in your environment:

1. Install Python 3.11+
2. Install uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`
3. Install Spec-Kit: `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`
4. Verify: `specify check`

## Common Network Issues

### Corporate Networks
- Your corporate firewall may block access to `ghcr.io`
- Try the Dockerfile approach (Option 2) which downloads packages during build
- Contact your IT team about accessing GitHub Container Registry

### DNS Resolution Issues
- The error `getaddrinfo EAI_AGAIN ghcr.io` indicates DNS problems
- Try changing your DNS settings to `8.8.8.8` and `8.8.4.4`
- Use the simple configuration (Option 3) which has fewer external dependencies

### Proxy Settings
If you're behind a corporate proxy, add these to your `devcontainer.json`:

```json
{
  "build": {
    "args": {
      "HTTP_PROXY": "http://your-proxy:port",
      "HTTPS_PROXY": "http://your-proxy:port"
    }
  }
}
```

## Verification Steps

After any of these approaches, verify your setup:

1. Open a terminal in the container
2. Run: `specify check`
3. You should see confirmation that tools are installed

## Getting Help

If none of these options work:

1. Check the [Spec-Kit GitHub Issues](https://github.com/github/spec-kit/issues)
2. Open a new issue with:
   - Your operating system
   - Network environment (corporate/home)
   - Complete error message
   - Which configuration you tried