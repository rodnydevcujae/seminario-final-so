# Diagnóstico integrado

## Metodología

Se realizó un diagnóstico colaborativo basado en una simulación de los entornos reales mediante máquinas virtuales y, en algunos casos, equipos de los propios estudiantes que ejecutaban Windows 10 sin licencia. Cada analista aportó herramientas desde su rol:

- **Rendimiento y energía**: `powercfg /energy`, `tasklist`, `winsat disk`, Monitor de recursos.
- **Soberanía y obsolescencia**: revisión de servicios, procesos de telemetría y análisis de dependencias propietarias.
- **Seguridad**: `netstat -ano`, `sc query`, Autoruns (Sysinternals), revisión de Event Viewer (simulado) y evaluaciones manuales de configuración.

Dado que los sistemas reales no estaban accesibles para mediciones directas, todas las cifras que se presentan son estimaciones basadas en los perfiles de hardware proporcionados y en las observaciones de las máquinas virtuales.

## Diagnóstico por equipo

### Equipo A – Director General (Windows 10 Ultimate x64, 4GB RAM, HDD 1TB)

- **Rendimiento**
  - En entornos con Windows 10 sin optimizar se observó una utilización de CPU en reposo del orden del 35-40 %, atribuible a procesos en segundo plano (TeamViewer, servicios de Office y telemetría).
  - El informe simulado de `powercfg /energy` reveló múltiples advertencias típicas de dispositivos que impiden la suspensión (USB, red).
  - La memoria RAM se encontró cerca del límite práctico (aproximadamente 3 de los 4 GB en uso), con signos de paginación excesiva sobre un disco mecánico.
  - El disco HDD de 5400 rpm mostró síntomas de fragmentación elevada, sin que se cuantificara el porcentaje exacto; se espera que, en el sistema real, esté por encima del 15 %.
  
- **Energía**
  - El plan activo era "Alto rendimiento". En simulaciones con características similares se estima un consumo idle cercano a los 60‑65 W, aunque no pudo medirse directamente.
    - El reporte simulado de `powercfg /energy` señaló dispositivos que no permiten la suspensión y la hibernación deshabilitada.

- **Soberanía**
  - Windows 10 Ultimate usado con activación no oficial; no se reciben actualizaciones de seguridad genuinas.
  - Servicios de telemetría (`DiagTrack`, `dmwappushservice`) se encontraron en ejecución, lo cual envía datos del sistema fuera del control de la empresa.
  - Dependencia de Microsoft Office 2019 (sin licencia) y de TeamViewer en su configuración por defecto, ambos con componentes de telemetría adicionales.

- **Obsolescencia**
  - Windows 10 en general se encuentra fuera del ciclo de soporte extendido; las versiones no genuinas no pueden recibir parches fiables.
  - El hardware (Pentium G4400, 2015) aún puede ser útil si se migra a un sistema operativo ligero.

- **Seguridad**
  - Firewall de Windows desactivado.
  - TeamViewer iniciando con el sistema sin segundo factor de autenticación.
  - FTP (puerto 21) escuchando; se usa para transferir actas sin cifrado.
  - Cuenta de administrador con contraseña en blanco.
  - Sin antivirus actualizado.
  - En la simulación, `netstat -ano` mostró puertos 21, 3389 (RDP) y 5938 (TeamViewer) abiertos.

### Equipo B – Directora Económica (Windows 10 Ultimate 32 bits, 2GB RAM, HDD 320GB)

- **Rendimiento**
  - El procesador Core 2 Duo (2009) se satura fácilmente al abrir Chrome y Office; en las pruebas simuladas se mantenía constantemente por encima del 70 % de uso de CPU.
  - Al contar con solo 2 GB de RAM, el sistema depende intensamente del archivo de paginación, lo que genera una respuesta muy lenta.
  - Los controladores del escáner Canon generan interrupciones frecuentes, aumentando la carga de CPU.

- **Energía**
  - El plan de energía "Equilibrado" no logra aplicar suspensión completa por la presencia del escáner USB.
  - No se pudo generar un informe de batería (equipo de escritorio), pero se infiere un consumo elevado para la antigüedad del hardware, probablemente en el rango de 50‑55 W en reposo.

- **Soberanía**
  - Sistema de 32 bits, lo que limita futuras actualizaciones de software y no recibe parches (último soporte real 2023).
  - Software utilizado: Office 2016 (fuera de soporte) y Versat Sarasola. No se emplean alternativas libres.
  - Se identificó que el navegador Chrome envía datos de uso sin control corporativo.

- **Obsolescencia**
  - El hardware es el más antiguo (2009) y la plataforma de 32 bits ya no es soportada por la mayoría de las distribuciones modernas, aunque una versión ligera de Linux de 32 bits podría extender su vida.

- **Seguridad**
  - USB AutoRun activado (riesgo de propagación de malware por memorias compartidas).
  - Servicio Spooler de impresión activo sin necesidad real.
  - Antivirus AVG Free desactualizado; no brinda protección en tiempo real efectiva.
  - Contraseña débil ("123456") y múltiples eventos de fallos de inicio de sesión detectados en el visor de eventos.

### Equipo C – Técnica de RRHH (Windows 10 Ultimate x64, 8GB RAM, HDD 1TB)

- **Rendimiento**
  - Es el equipo más potente, pero AutoCAD LT (versión no oficial) consume una cantidad importante de RAM (hasta 1.5 GB) incluso cuando no está en uso activo.
  - El disco HDD presenta poco espacio libre tras acumular nóminas y documentos pesados; en la simulación se observaron velocidades de transferencia secuenciales bajas para estándares actuales, aunque no se midió un valor exacto.
  - No se cuantificó el porcentaje exacto de fragmentación, pero es previsible que sea alto por el uso intensivo de archivos grandes.

- **Energía**
  - El plan "Equilibrado" se mantiene activo, pero el software de AutoCAD impide la entrada en estados de ahorro energético profundo (se evidenció en la simulación mediante `powercfg /requests`).
  - El equipo permanece encendido durante la noche; se estima un consumo idle del orden de 65‑70 W, cifra que se podrá reducir significativamente con las medidas propuestas.

- **Soberanía**
  - Dependencia total de AutoCAD LT (versión crackeada), Office 2019 pirata y Versat Sarasola sin alternativas libres.
  - No se han implementado políticas de software libre en la empresa.

- **Obsolescencia**
  - El hardware (Core i5 de séptima generación, 2017) tiene capacidad para durar varios años más si se optimiza el sistema operativo.

- **Seguridad**
  - Windows Defender se encuentra desactivado para que el crack de AutoCAD funcione.
  - SMB (puerto 445) abierto a toda la red sin restricciones.
  - Almacenamiento de nóminas y certificados médicos sin cifrado.
  - Navegador Chrome con sincronización de contraseñas activa, lo que supone un riesgo si la cuenta Google es comprometida.

## Diagnóstico transversal (toda la empresa)

- **Red plana sin segmentación**: Los tres equipos y el servidor Ubuntu 20.04 (presente en la empresa) comparten la misma subred. El servidor ofrece FTP sin TLS (vsftpd) y Samba con SMBv1 habilitado.
- **Actualizaciones de seguridad nulas**: Todas las instalaciones de Windows son no genuinas, por lo que Windows Update no es confiable y los parches críticos no se aplican.
- **Cultura de seguridad deficiente**: Contraseñas en papel, cuentas de administrador sin contraseña, uso de memorias USB sin control.
- **Consumo energético total estimado**: tomando como referencia perfiles típicos de hardware similares, los tres equipos podrían estar consumiendo en conjunto alrededor de 180 W en horario laboral, más un consumo nocturno que podría reducirse drásticamente con las medidas propuestas.

Este diagnóstico evidencia la necesidad de intervenir los cinco ejes de manera integrada, tal como se presenta en el plan de mejora del siguiente capítulo.
