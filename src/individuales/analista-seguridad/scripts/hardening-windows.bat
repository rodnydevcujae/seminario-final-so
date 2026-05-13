@echo off
:: Hardening básico para Windows 10/11 sin licencia oficial
:: Analista: Alex Dayan Rodríguez Hernández
:: Ejecutar como Administrador

echo === HARDENING SUMIFER - SEGURIDAD ===

:: 1. Firewall: bloquear entrada por defecto
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
echo [OK] Firewall: bloqueo inbound activado.

:: 2. Deshabilitar SMBv1 (vulnerable)
dism /online /disable-feature /featurename:SMB1Protocol /quiet /norestart
echo [OK] SMBv1 deshabilitado.

:: 3. Deshabilitar servicios inseguros / telemetria no critica
sc config DiagTrack start= disabled
sc stop DiagTrack 2>nul
sc config dmwappushservice start= disabled
sc stop dmwappushservice 2>nul
sc config RemoteRegistry start= disabled
sc stop RemoteRegistry 2>nul
echo [OK] Servicios de telemetria y remotos deshabilitados.

:: 4. Bloquear puertos comunes no necesarios
netsh advfirewall firewall add rule name="Bloquear FTP" dir=out remoteport=21 protocol=TCP action=block
netsh advfirewall firewall add rule name="Bloquear Telnet" dir=out remoteport=23 protocol=TCP action=block
netsh advfirewall firewall add rule name="Bloquear NetBIOS" dir=out remoteport=137,138,139,445 protocol=TCP action=block
echo [OK] Puertos salientes bloqueados.

:: 5. Deshabilitar AutoRun USB (previene malware)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f
echo [OK] AutoRun USB deshabilitado.

:: 6. Auditoría básica de puertos abiertos
echo === PUERTOS ESCUCHANDO ANTES DEL HARDENING ===
netstat -an | findstr "LISTENING" > puertos_antes.txt
echo [OK] Listado guardado en puertos_antes.txt

echo === HARDENING COMPLETADO ===
echo Recomendacion: Reiniciar y ejecutar 'netstat -an' para verificar.
pause