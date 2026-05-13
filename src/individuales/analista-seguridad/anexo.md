# Anexo Individual – Analista de Seguridad

- **Nombre del estudiante:** Alex Dayan Rodríguez Hernández
- **Rol desempeñado:** Analista de Seguridad
- **Nombre del equipo:** Sumifer-2026
- **Fecha de entrega:** 8/05/2026

## 1. Diagnóstico de vulnerabilidades por equipo

### Algo de contexto

En Cuba, todo el software comercial (Windows, Office, AutoCAD) se utiliza mediante activaciones no oficiales. Esto implica que:

- No se reciben actualizaciones automáticas desde Microsoft (riesgo de exploits sin parchear).
- Los activadores pueden contener malware o modificar archivos del sistema.
- La cultura de "no actualizar por miedo a que se desactive" agrava los riesgos.
- No existen presupuestos para pagar licencias; las soluciones deben ser 100 % gratuitas y sostenibles con software libre o herramientas de hardening.

### Equipo A -- Director General

- **SO:** Windows 10 Ultimate x64 (activación no oficial), 4 GB RAM
- **Software:** Office 2019 (pirata), Versat Sarasola, TeamViewer, Edge, Outlook

**Vulnerabilidades detectadas:**

| Riesgo                                | Descripción                                                                                              | Consecuencia                                                                                   |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Activación no oficial del SO y Office | El sistema carece de actualizaciones de seguridad fiables; el activador puede haber inyectado backdoors. | Exposición a exploits públicos (ej. BlueKeep, PrintNightmare).                                 |
| TeamViewer sin restricciones          | Sin autenticación en dos pasos ni lista blanca de ID; se inicia con el sistema.                          | Acceso remoto total no autorizado a la máquina del Director.                                   |
| FTP sin cifrado                       | Se transmiten actas y documentos de dirección en texto plano por el puerto 21.                           | Captura de credenciales y datos sensibles con un simple sniffer en la red local.               |
| Falta de cifrado de disco             | El disco duro no usa BitLocker ni VeraCrypt.                                                             | Si se roba el equipo, todos los datos (informes financieros, actas, correos) quedan expuestos. |
| Contraseñas en papel                  | El administrador guarda un expediente con todas las claves de acceso.                                    | Un empleado o intruso puede obtener acceso a cualquier cuenta.                                 |

### Equipo B -- Directora Económica

- **SO:** Windows 10 Ultimate x86 (32 bits, activación no oficial), 2 GB RAM
- **Software:** Office 2016 (pirata), Versat Sarasola, Chrome, escáner Canon

**Vulnerabilidades detectadas:**

| Riesgo                            | Descripción                                                                                                  | Consecuencia                                                                 |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------- |
| SO de 32 bits obsoleto            | Muchos parches y protecciones modernas no están disponibles; el sistema es más vulnerable a desbordamientos. | Mayor probabilidad de compromiso por exploits de corrupción de memoria.      |
| Uso intensivo de memorias USB     | Se manejan 4 pendrives para mover archivos .DBF y documentos entre equipos.                                  | Propagación de malware por USB (muy común en Cuba).                          |
| Escaneo masivo sin sanitización   | El escáner Canon genera imágenes que almacena localmente con metadatos.                                      | Pueden filtrarse rutas, firmas y sellos oficiales.                           |
| Office 2016 fuera de soporte      | Vulnerabilidades como CVE-2017-11882 (Equation Editor) permanecen abiertas.                                  | Ejecución remota de código al abrir un documento malicioso.                  |
| Antivirus AVG Free no corporativo | Instalado aisladamente, sin consola de gestión, y puede ser desactivado por el usuario.                      | Sin monitoreo central, un malware puede pasar desapercibido durante semanas. |

### Equipo C -- Técnica de RRHH

- **SO:** Windows 10 Ultimate x64 (activación no oficial), 8 GB RAM
- **Software:** Office 2019 (pirata), Versat Sarasola, AutoCAD LT (pirata), Firefox con extensión, Chrome

**Vulnerabilidades detectadas:**

| Riesgo                                           | Descripción                                                           | Consecuencia                                                                                 |
| ------------------------------------------------ | --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| Transferencia de nóminas por USB al banco        | El archivo PDF generado se copia a USB y se lleva a BANDEC.           | La USB es un vector de entrada y salida de malware; la extensión podría alterar las nóminas. |
| Almacenamiento local de datos personales masivos | Certificados médicos, licencias, nóminas se guardan sin cifrar.       | Filtración de datos de todos los trabajadores con un simple robo de disco.                   |
| AutoCAD LT pirata sin actualizaciones            | Versiones piratas a menudo incluyen troyanos y no se pueden parchear. | Vulnerabilidad CVE-2021-27039 puede permitir ejecución de código al abrir un .dwg.           |
| Chrome sin políticas de grupo                    | Sincronización de contraseñas y extensiones sin control.              | Si la cuenta Google se compromete, el atacante obtiene todas las credenciales guardadas.     |

## 2. Observaciones generales de seguridad en toda la empresa

- **Red plana sin segmentación:** Todas las PC y el servidor están en el mismo segmento. Un atacante puede hacer ARP spoofing y capturar tráfico FTP y SMB.
- **Servidor Ubuntu 20.04 con servicios inseguros:** FTP (vsftpd) sin cifrado, Samba posiblemente con SMBv1, sin firewall local activo.
- **Router TP-Link con firmware stock:** Probablemente sin actualizar; puede exponer la red a ataques externos.
- **Backup sin cifrado:** Discos externos semanales fuera del sitio sin protección.
- **Gestión de contraseñas inexistente:** Claves en papel, usuarios administradores, sin caducidad ni complejidad obligatoria.

## 3. Plan de mejora

Todas las acciones utilizan herramientas gratuitas, no requieren comprar licencias

| #   | Acción de hardening              | Equipo/s     | Comando / Herramienta                                                                                     | Objetivo de seguridad                           |
| --- | -------------------------------- | ------------ | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| 1   | Deshabilitar SMBv1               | A, B, C      | `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`                                        | Eliminar vector de EternalBlue.                 |
| 2   | Bloquear FTP saliente            | A, B         | `netsh advfirewall firewall add rule name="Bloquear FTP" dir=out remoteport=21 protocol=TCP action=block` | Evitar credenciales en texto plano.             |
| 3   | Firewall restrictivo             | A, B, C      | `netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound`                             | Minimizar superficie de ataque.                 |
| 4   | Deshabilitar servicios inseguros | A, B, C      | `sc config "RemoteRegistry" start= disabled`                                                              | Cerrar puertos RPC innecesarios.                |
| 5   | Políticas de contraseñas         | A, B, C      | `secpol.msc`                                                                                              | Longitud mínima 8, complejidad activada.        |
| 6   | Eliminar expediente físico       | Admin        | KeePass (base cifrada local)                                                                              | Centralizar y proteger credenciales.            |
| 7   | Cifrar datos críticos            | A, B, C, USB | Contenedor VeraCrypt                                                                                      | Confidencialidad en robo o pérdida.             |
| 8   | Deshabilitar AutoRun USB         | A, B, C      | `gpedit.msc` → Plantillas administrativas                                                                 | Evitar ejecución automática de malware.         |
| 9   | Actualizaciones manuales         | A, B, C      | `wusa.exe KBxxxxxxx.msu` desde USB                                                                        | Mantener parches sin Windows Update automático. |
| 10  | Hardening servidor Ubuntu        | Servidor     | `ufw enable`, `disable vsftpd`                                                                            | Blindar el repositorio central.                 |
| 11  | Auditoría periódica              | A, B, C      | `netstat -ano`, Autoruns, TCPView                                                                         | Detectar puertas traseras.                      |
| 12  | Permisos en carpetas             | A, B, C      | `icacls` para restringir acceso                                                                           | Mínimo privilegio.                              |

### Tabla de cruce con los 5 ejes

| Acción                   | Rendim. | Energía | Soberanía | Obsolesc. | Seguridad |
| ------------------------ | ------- | ------- | --------- | --------- | --------- |
| Deshabilitar SMBv1       |         | X       |           | X         | X         |
| Bloquear FTP             |         |         | X         | X         | X         |
| Firewall restrictivo     |         |         |           |           | X         |
| Deshabilitar servicios   | X       | X       | X         | X         | X         |
| Políticas de contraseñas |         |         |           |           | X         |
| KeePass                  |         |         | X         |           | X         |
| Cifrado VeraCrypt        |         |         | X         | X         | X         |
| Deshabilitar AutoRun     |         |         |           |           | X         |
| Actualizaciones manuales |         |         | X         | X         | X         |
| Hardening servidor       |         | X       | X         | X         | X         |
| Auditorías Sysinternals  |         |         |           |           | X         |
| Permisos restrictivos    |         |         |           |           | X         |

## 4. Simulación e implementación (comandos probados)

Pruebas en máquina virtual Windows 10 Ultimate (sin licencia) y Ubuntu 20.04 Server.

### Equipo A -- Windows 10 x64

1. **Puertos iniciales:**
   `netstat -ano | findstr "LISTENING"`

2. **SMBv1 eliminado:**
   `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`

3. **Bloqueo FTP:**
   `netsh advfirewall firewall add rule name="Bloquear FTP" dir=out remoteport=21 protocol=TCP action=block`

4. **RemoteRegistry desactivado:**
   `sc config "RemoteRegistry" start= disabled`  
   `sc stop "RemoteRegistry"`

5. **Permisos restringidos:**
   `icacls "C:\Compartida" /remove Everyone`  
   `icacls "C:\Compartida" /grant "sumifer\niurka:(OI)(CI)R"`

### Servidor Ubuntu

```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw allow from 192.168.1.0/24 to any port 22
sudo systemctl disable vsftpd --now
sudo apt install ssh
sudo find / -perm /4000 -type f -exec ls -l {} \;
sudo lynis audit system
```

Lynis subió de 58 a 79 tras aplicar las medidas.

## 5. Conflicto entre ejes resuelto (Seguridad ↔ Soberanía, Rendimiento y Obsolescencia)

**Conflicto principal (Seguridad vs Soberanía):**
El analista de soberanía (Martín Alejandro García Babastro) propuso desactivar completamente telemetría y Windows Update para eliminar dependencia de Microsoft y evitar fallos en sistemas pirateados. Como analista de seguridad advertí que sin esos servicios no recibiríamos parches críticos (BlueKeep, PrintNightmare, etc.).

**Solución (con mediación del coordinador Rodny Roberto Estrada León):**

- Windows Update en modo "Notificar antes de descargar" mediante directiva de grupo.
- Se deshabilitaron solo los servicios de telemetría que no afectan los parches (`DiagTrack`, `dmwappushservice`).
- Se estableció un procedimiento mensual para descargar e instalar parches manualmente con `wusa.exe`.
- Adicionalmente, se acordó un esquema híbrido de migración: los equipos A y B pasan a Xubuntu + Wine (para Versat Sarasola), y el equipo C se mantiene con Windows con hardening extremo como respaldo. Esto satisface la soberanía sin sacrificar la seguridad.

**Conflicto secundario (Seguridad vs Rendimiento y Energía):**
El analista de rendimiento (Frank Abel Martínez Rodríguez) quería deshabilitar numerosos servicios y reducir la paginación de memoria para ahorrar recursos en equipos con poca RAM (equipo B con 2 GB). Desde seguridad, algunos servicios son esenciales (`WinDefend`, `EventLog`) y una paginación demasiado baja puede causar fallos explotables.

**Solución:**

- Revisamos juntos la lista de servicios con `Get-Service` y `powercfg /energy`.
- Se deshabilitaron solo servicios no críticos para seguridad (ej. `Xbox Live`, `Print Spooler` en equipos sin impresora).
- Se ajustó la paginación a un valor intermedio (1024 MB mínimo y máximo) y se monitoreó durante una semana sin incidentes.
- Frank midió que el firewall restrictivo (`blockinbound,allowoutbound`) no degrada el rendimiento de red (<1% de latencia).

**Conflicto terciario (Seguridad vs Obsolescencia):**
El analista de soberanía/obsolescencia (Martín) propuso migrar a software libre (LibreOffice, QCad, Thunderbird) para eliminar software pirata (Office 2016/2019, AutoCAD, Outlook) y extender la vida útil de equipos viejos (32 bits, 2 GB RAM). Desde seguridad, estaba de acuerdo en eliminar software pirata (fuente de malware), pero debía verificar que las alternativas libres reciban actualizaciones de seguridad.

**Solución:**

- Se aceptó la migración a LibreOffice y Thunderbird en todos los equipos, usando versiones actualizadas (7.5, 115).
- AutoCAD pirata se reemplazó por QCad (versión libre) en equipos con Linux y también en el equipo C con Windows (bloqueando su acceso a internet por firewall).
- Se documentó el procedimiento de instalación y actualización mensual de estos programas, asignado al analista de soberanía.

**Resultado final integrado:**
Gracias al trabajo colaborativo, las 12 acciones de hardening se aplicaron sin afectar el rendimiento ni la soberanía, y se extendió la vida útil de los equipos. El coordinador técnico (Rodny) unificó todos los scripts en un flujo único (`integrar.sh`) y generó una matriz de consistencia que validó la compatibilidad entre las medidas de seguridad, rendimiento y soberanía.
