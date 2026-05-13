@echo off
:: Script para medir consumo energético antes/después
:: Analista: Frank Abel

set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%

echo === MEDICION ENERGETICA SUMIFER ===
echo Fecha/Hora: %TIMESTAMP%

:: 1. Generar informe de energía
powercfg /energy /output "energia_%TIMESTAMP%.html"
echo [OK] Informe energy guardado: energia_%TIMESTAMP%.html

:: 2. Generar informe de batería (si es laptop)
powercfg /batteryreport /output "bateria_%TIMESTAMP%.html" 2>nul
if %errorlevel%==0 (
    echo [OK] Informe bateria guardado
) else (
    echo [WARN] No se genero informe de bateria (no es laptop o comando no soportado)
)

:: 3. Capturar consumo estimado actual
echo === CONSUMO ESTIMADO (powercfg -requests) ===
powercfg -requests
echo === FIN ==
echo Medicion completada. Revisar archivos HTML generados.
pause