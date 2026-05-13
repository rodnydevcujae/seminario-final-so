# Acta de Reunión 3 – Equipo Sumifer-2026

**Fecha:** 6 de mayo de 2026  
**Modalidad:** Chat de WhatsApp (grupo "Sumifer-SO")  
**Asistentes:** Rodny, Frank, Martín, Alex  
**Duración aproximada:** 50 minutos

---

## Orden del día

1. Cierre del diagnóstico y plan de mejora.
2. Verificación de resultados de simulación (cada analista en su VM).
3. Resolución de último conflicto: ¿el firewall restrictivo de Alex afecta el `powertop --auto-tune` de Frank?
4. Revisión de anexos individuales y uniformidad de formato.

---

## Acuerdos y decisiones

| Punto | Decisión                                                                                                                                                                           |
| ----- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1     | Diagnóstico y plan de mejora finalizados. Se suben al repo en `src/capitulos/`.                                                                                                    |
| 2     | **Conflicto firewall vs powertop:** Alex y Frank prueban en la misma VM y confirman que no hay interferencia. Queda documentado en la matriz.                                      |
| 3     | Martín confirma que Versat Sarasola funciona con Wine (versión 9.0, configuración `windows 7`). Adjunta capturas al grupo.                                                         |
| 4     | Todos los anexos individuales usarán la plantilla `src/plantillas/individual.md` para mantener uniformidad. Rodny automatiza la generación de `.docx` con Pandoc y GitHub Actions. |
| 5     | Se acuerda el video de simulación: Rodny lo grabará y editará, mostrando un resumen de los cambios clave.                                                                          |

---

## Pendientes de cierre

- Alex: subir capturas de `lynis` antes/después.
- Frank: subir gráficos de consumo energético (simulado con `powertop`).
- Rodny: ejecutar `bash scripts/generate.sh`, subir los `.docx` a la release de GitHub y entregar en Moodle.

---

## Cierre

El equipo da por concluidas las reuniones de coordinación. Cualquier duda de última hora se resolverá por el mismo chat.

---

**Rodny Roberto Estrada León**  
Coordinador
