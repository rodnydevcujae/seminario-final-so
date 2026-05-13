# Acta de Reunión 2 – Equipo Sumifer-2026

**Fecha:** 2 de mayo de 2026  
**Modalidad:** Chat de WhatsApp (grupo "Sumifer-SO")  
**Asistentes:** Rodny, Frank, Martín, Alex  
**Duración aproximada:** 1 hora 15 minutos

---

## Orden del día

1. Consolidación de los diagnósticos individuales en un documento único.
2. Discusión del **conflicto principal**: Windows Update vs telemetría vs soberanía.
3. Propuesta de migración a Linux (Martín) y el problema del Versat Sarasola.
4. Ajustes de paginación y firewall (Frank vs Alex).

---

## Acuerdos y decisiones

| Punto | Decisión                                                                                                                                                              |
| ----- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1     | Se consolida el diagnóstico en un solo archivo Markdown dentro del repo (`src/capitulos/01-diagnostico-integrado.md`).                                                |
| 2     | **Conflicto Windows Update / telemetría:** se acuerda modelo híbrido (ver tabla).                                                                                     |
| 3     | **Versat Sarasola en Linux:** Martín probará Wine en una VM y reportará resultados antes del 4/05.                                                                    |
| 4     | **Paginación:** se fija un valor intermedio (1024 MB min/max) y Frank medirá impacto.                                                                                 |
| 5     | **Firewall:** Alex muestra que `netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound` no degrada rendimiento (menos del 1% de CPU). Se acepta. |

### Modelo híbrido para Windows Update

| Equipo | Sistema                   | Acción                                                                                                                                                |
| ------ | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| A y B  | Migrarán a Xubuntu + Wine | Sin Windows Update (se confía en actualizaciones de paquetes Linux)                                                                                   |
| C      | Windows 10 (se mantiene)  | Windows Update en modo "notificar antes de descargar". Deshabilitar solo `DiagTrack` y `dmwappushservice`. Parches manuales mensuales con `wusa.exe`. |

---

## Próximos pasos

- Frank: mediciones de rendimiento/energía con y sin firewall.
- Martín: pruebas de Wine + Versat Sarasola, capturas al grupo.
- Alex: script de hardening básico para equipos A, B, C.
- Rodny: redactar matriz de consistencia y preparar plantilla de anexos individuales.

---

**Rodny Roberto Estrada León**  
Coordinador
