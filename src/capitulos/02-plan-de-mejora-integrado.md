# Plan de mejora integrado

## Enfoque

El plan de mejora propone acciones concretas que contribuyen simultáneamente a los cinco ejes: rendimiento, energía, soberanía, obsolescencia y seguridad. Cada acción fue consensuada entre los tres analistas y el coordinador, validando que no generen conflictos insalvables.

## Tabla de acciones por equipo

| #   | Acción                                                                                              | Equipo                              | Comandos / Herramientas                                                                                         | Ejes impactados                                                            | Resultado esperado                                                                                                    |
| --- | --------------------------------------------------------------------------------------------------- | ----------------------------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| 1   | **Migrar a distribuciones Linux ligeras** (Xubuntu 24.04 LTS en A y B, Ubuntu + LXQT en C)          | A, B, C                             | `dd` para crear USB booteable, instalación con particionado manual                                              | Soberanía +++, Obsolescencia +++, Rendimiento ++, Energía ++, Seguridad ++ | Eliminar dependencia de licencias pirata, extender vida útil 5+ años, reducir consumo de RAM (<1GB en A/B, <2GB en C) |
| 2   | **Configurar `powertop --auto-tune` y governor `powersave`**                                        | A, B, C (post-migración)            | `sudo powertop --auto-tune`, `cpufreq-set -g powersave`                                                         | Energía +++, Rendimiento +                                                 | Reducción del consumo idle de ~45W a ~28W por equipo (estimado), menor calor y ruido del ventilador                   |
| 3   | **Ajustar `vm.swappiness` y deshabilitar servicios innecesarios**                                   | A, B, C (Linux)                     | `sysctl vm.swappiness=10`, `systemctl disable bluetooth cups`                                                   | Rendimiento ++, Energía ++, Seguridad ++                                   | Menor uso de swap (mejora respuesta en equipos con poca RAM), menos superficie de ataque                              |
| 4   | **Migrar software propietario a alternativas libres**                                               | A, B, C                             | LibreOffice en lugar de MS Office, Firefox/Thunderbird, QCad en lugar de AutoCAD, GIMP para edición de imágenes | Soberanía +++, Obsolescencia ++, Seguridad ++                              | Eliminación de software pirata (fuente de malware), actualizaciones seguras desde repositorios oficiales              |
| 5   | **Configurar firewall estricto (UFW) con `deny incoming`**                                          | A, B, C (Linux) + servidor Ubuntu   | `ufw default deny incoming`, `ufw allow 22/tcp`, `ufw enable`                                                   | Seguridad +++, Rendimiento (sin impacto medible), Energía (sin impacto)    | Cierre de puertos no esenciales (FTP, SMB, RDP), solo SSH autorizado desde LAN                                        |
| 6   | **Deshabilitar telemetría y bloatware en los equipos que mantienen Windows (solo C temporalmente)** | C (hasta migración total)           | `sc config DiagTrack start=disabled`, `powershell Remove-AppxPackage *xbox*`                                    | Soberanía ++, Rendimiento +, Obsolescencia +                               | Reducción de tráfico de red a Microsoft, mejora de privacidad y rendimiento                                           |
| 7   | **Aplicar políticas de contraseñas robustas y gestor offline (KeePass)**                            | Todos                               | `passwd`, `chage -M 90`, KeePassXC                                                                              | Seguridad +++                                                              | Mitigación de ataques de fuerza bruta y robo de credenciales                                                          |
| 8   | **Cifrar datos sensibles con VeraCrypt**                                                            | Equipo C (nóminas), USB de respaldo | VeraCrypt (contenedor de 500MB para nóminas)                                                                    | Seguridad +++, Soberanía + (software libre)                                | Confidencialidad en caso de robo o pérdida de dispositivos                                                            |
| 9   | **Programar auditorías periódicas con Lynis y `netstat`**                                           | Todos                               | `sudo lynis audit system`, `ss -tulpn`                                                                          | Seguridad ++, Obsolescencia +                                              | Detección temprana de configuraciones inseguras o servicios no deshabilitados                                         |
| 10  | **Reemplazar FTP por SFTP (SSH) en el servidor**                                                    | Servidor Ubuntu                     | `sudo systemctl disable vsftpd`, `sudo systemctl enable ssh`                                                    | Seguridad +++, Soberanía ++                                                | Eliminación de credenciales en texto plano, cifrado de extremo a extremo                                              |

## Matriz de consistencia (cruce de acciones con ejes)

| Acción                            | Rendimiento | Energía | Soberanía | Obsolescencia | Seguridad |
| --------------------------------- | ----------- | ------- | --------- | ------------- | --------- |
| 1. Migración a Linux              | +2          | +1      | +3        | +3            | +2        |
| 2. powertop + powersave           | +1          | +3      | 0         | +1            | 0         |
| 3. swappiness + deshab. servicios | +2          | +2      | 0         | 0             | +1        |
| 4. Software libre                 | +1          | 0       | +3        | +2            | +2        |
| 5. Firewall UFW                   | 0           | 0       | 0         | 0             | +3        |
| 6. Deshab. telemetría (Windows)   | +1          | 0       | +2        | +1            | 0         |
| 7. Políticas contraseñas          | 0           | 0       | 0         | 0             | +3        |
| 8. Cifrado VeraCrypt              | -1 (mínimo) | 0       | +1        | 0             | +3        |
| 9. Auditorías periódicas          | 0           | 0       | 0         | +1            | +2        |
| 10. SFTP vs FTP                   | 0           | 0       | +2        | 0             | +3        |

Leyenda::: + impacto positivo, 0 neutro, - impacto negativo leve.

## Plan de implementación por fases

### Fase 1 (inmediata, 1 semana) – Sin migración

- Deshabilitar puertos innecesarios y servicios de telemetría en Windows.
- Configurar firewall de Windows (Equipo C) con reglas de bloqueo inbound.
- Cambiar contraseñas de todos los usuarios y activar políticas de complejidad.
- Instalar y configurar KeePassXC.

### Fase 2 (2 semanas) – Migración piloto

- Realizar backup completo de Equipo A y B.
- Instalar Xubuntu 24.04 LTS en Equipo A (Director General) en dual boot (o VM para prueba). Validar funcionamiento de Versat Sarasola con Wine.
- Capacitar al usuario en LibreOffice y Firefox.

### Fase 3 (1 mes) – Migración completa y hardening

- Extender migración a Equipo B y C (C podría mantener Windows solo si AutoCAD LT no corre bien en QCad, pero se documenta).
- Aplicar `powertop --auto-tune` y governor powersave en todos los Linux.
- Configurar UFW y fail2ban en el servidor Ubuntu.
- Verificar con Lynis que el hardening supere puntuación 70.

### Fase 4 (trimestral) – Mantenimiento

- Programa de actualizaciones mensuales (`apt update && apt upgrade`).
- Rotación de contraseñas cada 90 días.
- Revisión de logs de seguridad y puertos abiertos.

Este plan permite extender la vida útil de los equipos al menos 5 años, eliminar dependencias de software pirata y mejorar la postura de seguridad, todo sin inversión en hardware nuevo.
