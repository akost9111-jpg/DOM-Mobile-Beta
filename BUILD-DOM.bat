@echo off
setlocal
title DOM Messenger - One Click Builder
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\BUILD-DOM.ps1"
if errorlevel 1 (
  echo.
  echo BUILD FAILED. Read the message above.
  pause
  exit /b 1
)
echo.
echo ============================================
echo DOM installer is ready in the dist folder.
echo ============================================
pause
