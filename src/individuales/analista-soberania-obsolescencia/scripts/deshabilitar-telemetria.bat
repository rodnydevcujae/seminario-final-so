@echo off
:: Deshabilitar telemetría y servicios de seguimiento en Windows
:: Analista: Martín Alejandro García Babastro
:: Ejecutar como Administrador

echo === DESHABILITANDO TELEMETRIA - SUMIFER ===

:: 1. Servicios principales de telemetría
sc config DiagTrack start= disabled
sc stop DiagTrack 2>nul
sc config dmwappushservice start= disabled
sc stop dmwappushservice 2>nul
echo [OK] DiagTrack y dmwappushservice deshabilitados.

:: 2. Deshabilitar tareas programadas de telemetría (Windows 10)
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 2>nul
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 2>nul
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable 2>nul
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 2>nul
echo [OK] Tareas programadas de telemetria deshabilitadas.

:: 3. Bloquear dominios de telemetría via hosts (opcional)
echo 0.0.0.0 vortex.data.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 0.0.0.0 settings-win.data.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 0.0.0.0 telemetry.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo [OK] Dominios de telemetria bloqueados en hosts.

:: 4. Desinstalar bloatware común (OneDrive, Xbox, etc.)
echo [INFO] Desinstalando bloatware...
powershell -Command "Get-AppxPackage *xbox* | Remove-AppxPackage" 2>nul
powershell -Command "Get-AppxPackage *skype* | Remove-AppxPackage" 2>nul
powershell -Command "Get-AppxPackage *onedrive* | Remove-AppxPackage" 2>nul
echo [OK] Bloatware eliminado (Xbox, Skype, OneDrive).

echo === TELEMETRIA DESHABILITADA ===
pause