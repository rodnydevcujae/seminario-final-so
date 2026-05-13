@echo off
:: Script de optimización energética para Windows 10/11
:: Analista: Frank Abel
:: Ejecutar como Administrador

echo === OPTIMIZACION ENERGETICA SUMIFER ===

:: 1. Plan de energía equilibrado (base)
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
echo [OK] Plan equilibrado activado.

:: 2. Suspensión de discos duros después de 10 min
powercfg /change disk-timeout-ac 10
powercfg /change disk-timeout-dc 5
echo [OK] Timeout de discos ajustado.

:: 3. Deshabilitar hibernación (libera espacio en disco)
powercfg /h off
echo [OK] Hibernacion deshabilitada.

:: 4. Configurar suspensión de USB selectiva
powercfg /setacvalueindex scheme_current sub_usb usbselectivesuspend 1
powercfg /setdcvalueindex scheme_current sub_usb usbselectivesuspend 1
echo [OK] Suspension USB selectiva activada.

:: 5. Reducir tiempo de apagado de pantalla
powercfg /change monitor-timeout-ac 15
powercfg /change monitor-timeout-dc 10
echo [OK] Timeout de pantalla ajustado.

:: 6. Deshabilitar servicios que despiertan el equipo
powercfg /lastwake
powercfg /waketimers
echo [INFO] Revisar wake timers manualmente si es necesario.

echo === OPTIMIZACION COMPLETADA ===
pause