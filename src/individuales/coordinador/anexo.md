# Anexo Individual – Sistema Operativo y Trabajo por Roles

- **Nombre del estudiante:** Rodny Roberto Estrada León
- **Rol desempeñado:** Coordinador Técnico
- **Nombre del equipo:** Sumifer-2026
- **Fecha de entrega:** 10 de mayo de 2026

---

## 1. Descripción concreta de mis aportes (máximo 300 palabras)

| #   | Acción concreta                                                                                                                                                      | Equipo            | Resultado medible                                                                                                                                                                                                                   |
| :-- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Organicé y facilité 3 reuniones de sincronización (actas adjuntas)                                                                                                   | Equipos A, B, C   | Se resolvieron 4 conflictos inter‑rol (ej. telemetría vs parches, Versat Sarasola en Linux, paginación vs seguridad).                                                                                                               |
| 2   | Creé la **matriz de consistencia** cruzando acciones de los tres analistas con los 5 ejes (rendimiento, energía, soberanía, obsolescencia, seguridad)                | Todos             | Se detectaron 2 incompatibilidades iniciales (firewall restrictivo vs consumo energético en Eth, desactivación de servicios vs necesidad de auditoría). Se ajustaron a tiempo.                                                      |
| 3   | Redacté el **informe ejecutivo** simulado para la dirección de Sumifer                                                                                               | -                 |                                                                                                                                                                                                                                     |
| 4   | Unifiqué los scripts de los tres analistas en un solo flujo `integrar.sh` (para la simulación en VM)                                                                 | VM con Windows 10 | Reducción del tiempo de aplicación de medidas de 45 min a 12 min (automatización).                                                                                                                                                  |
| 5   | **Creé y administré el repositorio GitHub** del equipo: [`https://github.com/rodnydevcujae/seminario-final-so`](https://github.com/rodnydevcujae/seminario-final-so) | Todos             | Unificación de todos los informes (grupales e individuales) en un solo lugar. Automatización de la generación de `.docx` con Pandoc + GitHub Actions (releases automáticas). Uniformidad de formato para los 4 anexos individuales. |

---

## 2. Conflictos entre ejes y cómo los resolvimos (máximo 200 palabras)

**Conflicto identificado (Seguridad vs Soberanía):**  
El analista de soberanía (Martín) quería desactivar por completo Windows Update y telemetría en los equipos que se quedaban con Windows (Equipo C), para eliminar dependencia de Microsoft. El analista de seguridad (Alex) advertía que sin parches críticos (PrintNightmare, BlueKeep) el riesgo era inasumible.

_Ejes en conflicto:_ Soberanía – Seguridad – Obsolescencia (parches alargan vida útil).

**Solución aplicada (mediación del coordinador):**  
Acordamos un modelo **híbrido**:

- Equipos A y B migran a Xubuntu + Wine para Versat Sarasola (soberanía + rendimiento).
- Equipo C mantiene Windows con política de _“notificar antes de descargar”_ y parches manuales mensuales vía `wusa.exe`.
- Se deshabilitaron solo los servicios de telemetría no vinculados a parches (`DiagTrack`, `dmwappushservice`).
- Se documentó el procedimiento en la matriz de consistencia y se verificó con `lynis` que no se introdujeron nuevas brechas.

**Conflicto secundario (Rendimiento vs Seguridad – paginación y firewall):**  
Frank (rendimiento) quería reducir la paginación al mínimo y Alex (seguridad) necesitaba logs y firewall activo. Se ajustó `vm.swappiness` a un valor intermedio y se comprobó que `ufw` / `netsh advfirewall` no consumen más del 1% de CPU. Quedó resuelto en el acta de la segunda reunión.

---

## 3. Si hiciera este proyecto solo/a, ¿qué cambiaría? (máximo 150 palabras)

Trabajando solo, lo primero que cambiaría sería **el orden de las tareas**: dedicaría una semana entera solo a la automatización y a las pruebas en un único entorno virtual replicable (Vagrant + VirtualBox), en lugar de tener que coordinar tres visiones distintas. También unificaría el diagnóstico desde el principio con una batería de scripts que cubriera rendimiento, seguridad y soberanía de una sola pasada (algo que conseguimos al final, pero con retraso).

Perdería la **riqueza de los conflictos**: gran parte de las mejores soluciones (como el uso de Wine para Versat Sarasola o el ajuste fino de servicios) surgieron de las discusiones entre roles. Solo, probablemente habría sido más conservador y habría migrado todo a Linux sin considerar las limitaciones reales del software cubano, o habría dejado Windows sin los parches de seguridad. La desventaja principal del equipo fue la necesidad de sincronización continua (3 reuniones), pero la ventaja en calidad técnica supera con creces ese costo.

**El repositorio GitHub** también lo habría creado igual, pero la diferencia es que trabajando en equipo el flujo de trabajo con Pull Requests y revisiones cruzadas mejoró notablemente la calidad final de los anexos individuales (cada analista revisó el formato del otro antes de fusionar).

---

## 4. Aprendizajes inesperados sobre mi rol (máximo 150 palabras)

Como coordinador, aprendí que **los conflictos técnicos casi nunca son binarios** (esto o aquello), sino que se pueden convertir en soluciones híbridas si se escuchan las evidencias de cada rol. No esperaba que la matriz de consistencia fuera tan reveladora: cruzando acciones vi que el `powertop --auto-tune` sugerido por Frank podía abrir puertos inesperados (no fue el caso, pero lo verificamos con `ss -tulpn` gracias a Alex).

**Sorpresa con GitHub Actions:** Implementar el flujo de CI/CD para que cada `push` a la rama `main` generara automáticamente los `.docx` y creara una pre-release me ahorró horas de trabajo manual. Además, al usar una plantilla común (`plantillas/individual.md`) y un mismo script `generate.sh`, los cuatro anexos individuales quedaron con **uniformidad tipográfica, numeración de tablas y estilo de código** idénticos. Eso es algo que en un trabajo manual es muy difícil de lograr.

También descubrí la importancia de **documentar las decisiones** no solo con capturas, sino con un pequeño registro de por qué se tomó cada una (en el README del repositorio). En la empresa real, ese registro servirá para que el próximo técnico no tenga que redescubrir la solución. Por último, valoré el poder de un _script integrador_: al juntar los comandos de los tres analistas en un solo flujo, aumentamos la reproducibilidad y la confianza de la dirección en la propuesta.

---

## 5. Autoevaluación y coevaluación

### Autoevaluación (marca con X)

| Criterio                             | Excelente (5) | Bien (4) | Regular (3) | Mal (2) |
| :----------------------------------- | :-----------: | :------: | :---------: | :-----: |
| Cumplí con las tareas de mi rol      |       X       |          |             |         |
| Colaboré con otros roles             |       X       |          |             |         |
| Documenté correctamente mis acciones |       X       |          |             |         |
| Aporté soluciones creativas          |       X       |          |             |         |

**Nota final que me pongo (2 a 5):** 5  
**Justificación breve:** Entregué todas las actas, la matriz de consistencia, el informe ejecutivo y el video. Facilité la resolución de los conflictos mayores y unifiqué el trabajo de los tres analistas sin que se pisaran. Además, el repositorio GitHub con automatización CI/CD garantizó uniformidad documental y entregas perfectas. La única mejora posible hubiera sido una reunión más al inicio para alinear mejor la simulación.

### Coevaluación (a cada compañero de equipo)

| Compañero/a                      | Rol                                   | Aspecto positivo (1)                                                                                                              | Área de mejora (1)                                                                                                   | Nota (2 a 5) |
| :------------------------------- | :------------------------------------ | :-------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------- | :----------- |
| Frank Abel Martínez Rodríguez    | Analista de Rendimiento y Energía     | Métricas muy precisas (powercfg, vmstat) y voluntad para ajustar la paginación consensuada                                        | Mergeó en github sus informes un día después del plazo acordado, pero con calidad excelente                                   | 5            |
| Martín Alejandro García Babastro | Analista de Soberanía y Obsolescencia | Investigó a fondo Wine y las alternativas libres (QCad, LibreOffice) – solución creativa al Versat Sarasola                       | Documentación de las pruebas con Wine un poco escasa por no decir nulas, lo mejoraremos en próximos trabajos                            | 4.5          |
| Alex Dayan Rodríguez Hernández   | Analista de Seguridad                 | Hardening muy bueno, detectó vulnerabilidades reales de las activaciones no oficiales, cooperó en el conflicto telemetría/parches | Podría haber automatizado la comprobación de puertos abiertos después de cada cambio (lo hizo manual, pero completo) | 5            |

**Comentario adicional para el profesor:**  
El equipo funcionó mejor de lo esperado. El conflicto más complicado (Versat Sarasola) se resolvió con la propuesta de Martín (Wine) y la verificación de seguridad de Alex. La matriz de consistencia (entregable del coordinador) se adjunta como archivo separado en la carpeta grupal. Agradecemos la oportunidad de aplicar los conceptos de SO a un caso realista.

**Detalle sobre el repositorio:**  
El repositorio [`https://github.com/rodnydevcujae/seminario-final-so`](https://github.com/rodnydevcujae/seminario-final-so) es público, contiene el 100% de los informes en Markdown, las evidencias (capturas, logs, scripts) y el flujo de automatización. Los releases generados automáticamente por GitHub Actions están en la pestaña "Releases". Esto permite que la evaluación sea completamente reproducible y transparente.

---

## 6. Declaración de integridad académica

Declaro que este anexo refleja mi trabajo individual y que las contribuciones reportadas son verídicas.

**Nombre y fecha:** Rodny Roberto Estrada León – 9 de mayo de 2026
