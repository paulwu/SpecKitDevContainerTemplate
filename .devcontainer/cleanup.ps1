# Clear DevContainer cache and containers (PowerShell version)

Write-Host "🧹 Cleaning up DevContainer cache and containers..." -ForegroundColor Green

# Stop and remove any running containers with the project label
Write-Host "Stopping containers..." -ForegroundColor Yellow
$containers = docker ps -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"
if ($containers) {
    docker stop $containers
}

Write-Host "Removing containers..." -ForegroundColor Yellow
$allContainers = docker ps -aq --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"
if ($allContainers) {
    docker rm $allContainers
}

# Remove images built for this project
Write-Host "Removing images..." -ForegroundColor Yellow
$images = docker images -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"
if ($images) {
    docker rmi $images
}

# Clean up build cache
Write-Host "Cleaning build cache..." -ForegroundColor Yellow
docker builder prune -f

# Clean up volumes (optional - be careful with this)
Write-Host "Cleaning up unused volumes..." -ForegroundColor Yellow
docker volume prune -f

Write-Host "✅ Cleanup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Now try rebuilding your DevContainer:" -ForegroundColor Cyan
Write-Host "1. Press Ctrl+Shift+P" -ForegroundColor White
Write-Host "2. Select 'Dev Containers: Rebuild Container'" -ForegroundColor White