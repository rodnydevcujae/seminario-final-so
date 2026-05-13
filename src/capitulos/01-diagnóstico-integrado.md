# Diagnóstico integrado

## Metodología

Se realizó un diagnóstico colaborativo utilizando herramientas nativas de Windows (por ser el SO actual de los tres equipos) y, en el caso del servidor de archivos (Ubuntu 20.04, no listado inicialmente pero presente en la empresa), se emplearon herramientas de Linux. Cada analista aportó su mirada:

- **Rendimiento y energía**: `powercfg /energy`, `tasklist`, `wmic`, Monitor de recursos, `perfmon`.
- **Soberanía y obsolescencia**: `winget list`, `Get-AppxPackage`, `services.msc`, `systeminfo` (fecha de fin de soporte).
- **Seguridad**: `netstat -ano`, `sc query`, `icacls`, Autoruns (Sysinternals), revisión de logs de Event Viewer.

## Diagnóstico por equipo

### Equipo A – Director General (Windows 10 Ultimate x64, 4GB RAM, HDD 1TB)

- **Rendimiento**
  - Uso de CPU en reposo: 35-40% (procesos en segundo plano: TeamViewer, actualizaciones de Office, telemetría).
    - -> `powercfg /energy` mostró 5 advertencias (timeouts de USB, dispositivos no suspendidos).
  - RAM utilizada: 3.2 GB de 4 GB (80%), con paginación excesiva al HDD.
  - HDD 5400 rpm con fragmentación del 18%.

- **Energía**
  - Plan de energía "Alto rendimiento" activado, consumo estimado: ~65W en reposo.
    - -> Informe `powercfg /energy` – dispositivos que no permiten suspensión.
  - Hibernación deshabilitada, pero suspensión de USB selectiva inactiva.

- **Soberanía**
  - Windows 10 Ultimate sin licencia oficial (activador no autorizado).
    - -> `sc query DiagTrack` muestra estado RUNNING.
  - Telemetría activa (`DiagTrack`, `dmwappushservice`).
  - Dependencia de Microsoft Office 2019 (pirata) y TeamViewer (software propietario con telemetría).
    - -> `winget list` muestra paquetes de terceros no controlados.

- **Obsolescencia**
  - Windows 10 Ultimate (sin soporte extendido oficial después de 2025). Al ser versión no genuina, no recibe actualizaciones de seguridad desde hace >1 año.
    - -> `systeminfo` muestra "Versión de SO: 10.0.19045 sin licencia".
  - Hardware: Pentium G4400 (2015), HDD mecánico. Aún útil con SO ligero.

- **Seguridad**
  - Firewall de Windows desactivado por completo.
  - TeamViewer configurado con inicio automático y sin autenticación de dos factores.
  - FTP sin cifrado (puerto 21 abierto) para transferir actas.
  - Usuario Administrador sin contraseña (cuenta "director" con blank password).
    - -> `net user director` muestra contraseña no requerida.
  - No hay antivirus actualizado.
  - Evidencia general: `netstat -ano` muestra puertos 3389 (RDP), 21 (FTP), 5938 (TeamViewer).

### Equipo B – Directora Económica (Windows 10 Ultimate 32 bits, 2GB RAM, HDD 320GB)

- **Rendimiento**
  - CPU Core 2 Duo (2009) constantemente al 70-90% con Chrome + Office abiertos.
  - RAM 2 GB saturada (1.9 GB usados), uso intensivo de archivo de paginación en HDD.
  - Escáner Canon con controladores legacy que generan interrupciones frecuentes.
    - -> `tasklist /fi "memusage gt 50000"` muestra chrome.exe y winword.exe como responsables.

- **Energía**
  - Batería de respaldo (UPS) con informes de eficiencia baja.
  - Plan equilibrado pero con dispositivos USB (escáner) que impiden suspensión.
    - -> `powercfg /batteryreport` no aplicable (desktop).

- **Soberanía**
  - Sistema de 32 bits, limitado a 4GB RAM, pero con Windows 10 32 bits que ya no recibe actualizaciones de seguridad desde 2023.
    - -> `systeminfo | find "System Type"` -> x86-based PC.
  - Uso de Office 2016 (fuera de soporte) y Versat Sarasola (software cubano obligatorio).
  - No hay alternativa libre instalada.
    - -> `winget list` muestra Office 2016 y complementos de Canon.

- **Obsolescencia**
  - El hardware (Core 2 Duo, 2GB RAM) es de 2009. Windows 10 32 bits es la última versión compatible, pero sin parches.
    - -> `wmic cpu get name` muestra Intel Core2 Duo E7500 @ 2.93GHz.
  - El escáner Canon requiere drivers antiguos que no funcionan en Linux sin configuración compleja.

- **Seguridad**
  - USB AutoRun activado (riesgo de malware por pendrives compartidos).
    - -> `reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun` devuelve 0.
  - Servicio de impresión (Spooler) activo sin necesidad.
  - Antivirus AVG Free instalado pero desactualizado y sin protección en tiempo real.
  - Cuentas de usuario con contraseñas débiles ("123456").
    - -> Event Viewer muestra múltiples errores de seguridad ID 4625 (fallos de inicio de sesión).

### Equipo C – Técnica de RRHH (Windows 10 Ultimate x64, 8GB RAM, HDD 1TB)

- **Rendimiento**
  - Mejor desempeño relativo (8GB RAM, Core i5).
  - AutoCAD LT pirata consume muchos recursos en segundo plano (hasta 1.5GB RAM).
  - Disco HDD con poco espacio libre (solo 120GB libres) por acumulación de archivos de nóminas.
    - -> `winsat disk` muestra tasa de transferencia secuencial de 85 MB/s (lento para estándares modernos).

- **Energía**
  - Plan de energía "Equilibrado" pero con suspensión desactivada (nunca se apaga).
  - Consumo innecesario nocturno (monitor, discos).
    - -> `powercfg /requests` muestra que AutoCAD LT mantiene una solicitud de "ejecución continua".

- **Soberanía**
  - Dependencia de AutoCAD LT (versión crackeada) para planos de instalaciones.
  - Office 2019 pirata, Versat Sarasola.
  - No hay políticas de software libre en la empresa.
    - -> `Get-AppxPackage *autocad*` no aparece (es versión tradicional). Se verificó manualmente la presencia de crack en `C:\Program Files\Autodesk`.

- **Obsolescencia**
  - Windows 10 Ultimate sin soporte, igual que equipos A y B.
  - El hardware es el más moderno (Core i5 7ma gen, 2017), puede durar 5+ años si se optimiza.
    - -> `systeminfo` -> BIOS fecha 2017, procesador i5-7200U.

- **Seguridad**
  - Windows Defender desactivado por el crack de AutoCAD.
    - -> `Get-MpComputerStatus` muestra AntivirusEnabled: False.
  - Puertos SMB (445) abiertos a toda la red.
    - -> `netstat -an | findstr 445` muestra LISTENING en todas las interfaces.
  - Almacenamiento de nóminas y certificados médicos en texto plano, sin cifrado.
  - Chrome con contraseñas guardadas y sincronización activa (riesgo si se compromete cuenta Google).

## Diagnóstico transversal (toda la empresa)

- **Red plana sin segmentación**: Los tres equipos y un servidor Ubuntu 20.04 (no mencionado inicialmente pero presente) comparten la misma subred. El servidor corre FTP (vsftpd) sin TLS y Samba con SMBv1 habilitado.
- **Actualizaciones de seguridad nulas**: Al ser todas instalaciones pirata de Windows, no se puede confiar en Windows Update. Los parches críticos (BlueKeep, PrintNightmare, etc.) no se han aplicado.
- **Cultura de seguridad deficiente**: Contraseñas en papel, cuentas de administrador sin contraseña, USB compartidos sin control.
- **Consumo energético estimado total**: 180W en horario laboral (8h/día) + 50W en standby nocturno (16h), aproximadamente 730 kWh/año solo en estos tres equipos.

Este diagnóstico evidencia la necesidad de intervenir los cinco ejes de manera integrada, tal como se presenta en el plan de mejora del siguiente capítulo.
