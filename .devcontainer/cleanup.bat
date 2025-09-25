@echo off
REM Clear DevContainer cache and containers (Windows Batch version)

echo 🧹 Cleaning up DevContainer cache and containers...

echo Stopping containers...
for /f %%i in ('docker ps -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"') do docker stop %%i

echo Removing containers...
for /f %%i in ('docker ps -aq --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"') do docker rm %%i

echo Removing images...
for /f %%i in ('docker images -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest"') do docker rmi %%i

echo Cleaning build cache...
docker builder prune -f

echo Cleaning up unused volumes...
docker volume prune -f

echo ✅ Cleanup complete!
echo.
echo Now try rebuilding your DevContainer:
echo 1. Press Ctrl+Shift+P
echo 2. Select 'Dev Containers: Rebuild Container'

pause