# Informe ejecutivo – Sumifer

**Para:** Dirección de Sumifer  
**De:** Equipo de optimización de Sistemas Operativos  
**Fecha:** 9 de mayo de 2026  
**Asunto:** Propuesta de mejora tecnológica sin compra de hardware

## Resumen ejecutivo

Hemos analizado los tres equipos de la empresa (Director General, Directora Económica y Técnica de RRHH) mediante un entorno simulado que replica las condiciones de hardware y software. Se detectaron problemas de lentitud, alto consumo eléctrico estimado, dependencia de software sin licencia y riesgos de seguridad importantes (contraseñas débiles, puertos abiertos, falta de actualizaciones).

**Sin comprar un solo componente nuevo**, proponemos un plan que podría extender la vida útil de los equipos alrededor de **5 años más**, reducir el consumo eléctrico en un **25-30 %** y mejorar drásticamente la seguridad y la soberanía tecnológica.

## ¿Qué problemas había?

- **Rendimiento**: Equipos A y B lentos (HDD mecánicos, poca RAM, procesos innecesarios). El equipo C funcionaba mejor pero con software pesado (AutoCAD no oficial).
- **Seguridad**: Contraseñas en papel, puertos abiertos (FTP, SMB sin cifrar), sin firewall, versiones no genuinas de Windows y Office que no reciben parches críticos.
- **Dependencia tecnológica**: Todo el software es de grandes corporaciones extranjeras, sin licencias oficiales, con telemetría activa que envía datos sin control.
- **Obsolescencia**: Windows 10 está fuera de soporte; los equipos A y B son de 2015 y 2009 respectivamente, pero aún tienen potencial con software ligero.

## ¿Qué hicimos sin comprar hardware nuevo?

1. **Migración a Linux** (Xubuntu) en los equipos A y B, y recomendación para el equipo C. Linux es gratuito, ligero y con actualizaciones de seguridad ilimitadas.
2. **Reemplazo del software pirata** por alternativas libres:
   - LibreOffice en lugar de Microsoft Office.
   - QCad en lugar de AutoCAD (suficiente para planos básicos).
   - Thunderbird y Firefox en lugar de Outlook/Chrome.
3. **Configuración del firewall** (UFW en Linux, firewall de Windows en el equipo C temporal) bloqueando todo el tráfico entrante excepto el necesario.
4. **Políticas de contraseñas robustas** y un gestor de contraseñas local (KeePass) para eliminar las claves en papel.
5. **Cifrado de nóminas** y documentos sensibles con VeraCrypt (software libre).
6. **Optimización del consumo energético** con `powertop` y configuraciones de suspensión de discos y USB.

## ¿Cuántos años más de vida útil estimamos?

- **Equipo A (2015)**: Con Xubuntu y LibreOffice, podría funcionar sin problemas hasta al menos 2031 (6 años más).
- **Equipo B (2009)**: El hardware es muy antiguo, pero Xubuntu con 2 GB RAM es usable para tareas administrativas. Esperamos extender su uso entre **3 y 5 años más**.
- **Equipo C (2017)**: Con Linux o incluso con Windows optimizado, fácilmente llegaría a 2032 (6 años más).

Promedio estimado: **5 años adicionales**, cumpliendo el objetivo.

## ¿Cuánto ahorro energético anual (kWh y USD)?

Las siguientes son estimaciones basadas en perfiles de consumo típicos para el hardware descrito y en los resultados de simulación con `powertop`:

| Equipo    | Consumo estimado actual (W idle) | Consumo esperado tras mejora (W idle) | Reducción estimada | Ahorro anual (kWh) | Ahorro anual (USD)* |
| --------- | -------------------------------- | ------------------------------------- | ------------------ | ------------------ | -------------------- |
| A         | ~65                              | ~45                                   | ~31 %              | 58 kWh             | $7.5                 |
| B         | ~55                              | ~38                                   | ~31 %              | 50 kWh             | $6.5                 |
| C         | ~70                              | ~52                                   | ~26 %              | 66 kWh             | $8.6                 |
| **Total** |                                  |                                       |                    | **174 kWh**        | **$22.6**            |

\*Tarifa eléctrica orientativa para el sector estatal en Cuba (~0.13 USD/kWh). El ahorro monetario es modesto, pero la reducción de huella de carbono y la menor generación de calor son beneficios adicionales.

## ¿Cómo mejoró la soberanía tecnológica?

- **Cero dependencia de Microsoft o Autodesk**: Todo el software propuesto es de código abierto (Linux, LibreOffice, QCad, VeraCrypt).
- **Actualizaciones controladas**: La empresa decidirá cuándo aplicar parches, sin telemetría ni envío de datos a terceros.
- **Sin licencias ni activadores ilegales**: Se elimina el riesgo legal y la posibilidad de malware inyectado por cracks.
- **Formación interna**: Se contempla la capacitación del personal en las nuevas herramientas, fomentando la autonomía tecnológica.

## ¿Qué riesgos de seguridad se redujeron?

| Riesgo original                       | Estado después del plan                 |
| ------------------------------------- | --------------------------------------- |
| Contraseñas en papel                  | ++ Eliminado (KeePass)                  |
| Puertos abiertos (FTP, SMB)           | ++ Cerrados (solo SSH)                  |
| Software sin parches (Windows pirata) | ++ Migrado a Linux actualizado          |
| USB AutoRun (propagación de malware)  | ++ Deshabilitado                        |
| Datos sensibles sin cifrar            | ++ Cifrados con VeraCrypt               |
| Falta de firewall                     | ++ Activo en todos los equipos          |
| Cuentas con contraseña vacía          | ++ Eliminadas, políticas de complejidad |

**Riesgo residual**: El equipo C mantendrá Windows temporalmente hasta validar que QCad cumple los requisitos de AutoCAD. Durante ese periodo, se aplicarán reglas estrictas de firewall y actualizaciones manuales mensuales.

## Conclusión

La solución propuesta es **económica, sostenible y alinea la tecnología de Sumifer con los principios de soberanía y seguridad**. No se necesita hardware nuevo, se reduciría el consumo eléctrico, se alargaría la vida útil de los equipos más de 5 años y se protegería la información de la empresa. Recomendamos implementar el plan por fases (inmediata, piloto, completa) con un seguimiento trimestral.

El equipo técnico queda a disposición para la ejecución del plan o para cualquier consulta adicional.

**Rodny Roberto Estrada León**  
Coordinador del equipo de Sistemas Operativos  
`rrodnyestrada1@gmail.com`