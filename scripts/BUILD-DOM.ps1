$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$app = Join-Path $root "app"
$dist = Join-Path $root "dist"
$release = Join-Path $app "build\windows\x64\runner\Release"
$iss = Join-Path $root "installer\DOM-Setup.iss"

Write-Host ""
Write-Host "=== DOM Messenger: one-click Windows installer ===" -ForegroundColor Cyan

function Need($cmd, $name) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    throw "$name is not installed or is not on PATH."
  }
}

Need "flutter" "Flutter"
if (-not (Get-Command "iscc" -ErrorAction SilentlyContinue)) {
  $isccCandidates = @(
    "$env:LOCALAPPDATA\Programs\Inno Setup 7\ISCC.exe",
    "$env:ProgramFiles(x86)\Inno Setup 7\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 7\ISCC.exe"
  )
  $iscc = $isccCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
  if ($iscc) { $env:Path += ";" + (Split-Path $iscc) } else { throw "Inno Setup (ISCC.exe) is not installed." }
}
Need "iscc" "Inno Setup (ISCC.exe)"

Write-Host "[1/4] Checking Flutter..." -ForegroundColor Yellow
flutter doctor -v

Write-Host "[2/4] Preparing Windows platform..." -ForegroundColor Yellow
Set-Location $app
flutter config --enable-windows-desktop | Out-Host
flutter create --platforms=windows . | Out-Host
flutter pub get | Out-Host

Write-Host "[3/4] Building DOM Messenger..." -ForegroundColor Yellow
flutter build windows --release | Out-Host

if (-not (Test-Path (Join-Path $release "dom_messenger.exe"))) {
  throw "dom_messenger.exe was not produced by Flutter."
}

if (Test-Path $dist) { Remove-Item $dist -Recurse -Force }
New-Item $dist -ItemType Directory | Out-Null

Write-Host "[4/4] Creating branded DOM Setup.exe..." -ForegroundColor Yellow
& iscc "/Qp" $iss
if ($LASTEXITCODE -ne 0) { throw "Inno Setup compilation failed." }

Write-Host ""
Write-Host "DONE." -ForegroundColor Green
Write-Host ("Installer: " + (Join-Path $dist "DOM-Messenger-Setup.exe"))
