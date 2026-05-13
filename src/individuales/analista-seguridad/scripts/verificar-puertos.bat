@echo off
:: Script para verificar puertos abiertos después del hardening
:: Analista: Alex Dayan Rodríguez Hernández

echo === VERIFICACION DE PUERTOS - SUMIFER ===
echo Fecha: %DATE% %TIME%

:: 1. Listar puertos en escucha
netstat -ano | findstr "LISTENING" > puertos_despues.txt
echo [OK] Puertos en escucha guardados en puertos_despues.txt

:: 2. Mostrar solo los puertos comunes (22, 80, 443, 445, 3389)
echo === PUERTOS CRITICOS ===
netstat -ano | findstr ":22 " >nul && echo "22 (SSH) ABIERTO" || echo "22 (SSH) CERRADO"
netstat -ano | findstr ":80 " >nul && echo "80 (HTTP) ABIERTO" || echo "80 (HTTP) CERRADO"
netstat -ano | findstr ":443 " >nul && echo "443 (HTTPS) ABIERTO" || echo "443 (HTTPS) CERRADO"
netstat -ano | findstr ":445 " >nul && echo "445 (SMB) ABIERTO" || echo "445 (SMB) CERRADO"
netstat -ano | findstr ":3389 " >nul && echo "3389 (RDP) ABIERTO" || echo "3389 (RDP) CERRADO"

:: 3. Comparación con línea base
echo === COMPARACION ===
echo Compare manualmente puertos_antes.txt y puertos_despues.txt
echo Deberia haber menos puertos abiertos.

pause