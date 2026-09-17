$ErrorActionPreference = 'Stop'
$TaskRoot = Split-Path $PSScriptRoot -Parent
$TaskVersion = '8.10.2'
$TaskCache = Join-Path $TaskRoot '.toolchain'
$TaskGradle = Join-Path $TaskCache "gradle-$TaskVersion/bin/gradle.bat"
if (-not (Test-Path $TaskGradle)) {
    New-Item -ItemType Directory -Force -Path $TaskCache | Out-Null
    $TaskZip = Join-Path $TaskCache "gradle-$TaskVersion-bin.zip"
    if (-not (Test-Path $TaskZip)) {
        Invoke-WebRequest -Uri "https://services.gradle.org/distributions/gradle-$TaskVersion-bin.zip" -OutFile $TaskZip
    }
    Expand-Archive -Path $TaskZip -DestinationPath $TaskCache -Force
}
Push-Location $TaskRoot
try { & $TaskGradle @args; $TaskExit = $LASTEXITCODE } finally { Pop-Location }
exit $TaskExit
