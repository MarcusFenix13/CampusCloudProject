# Arquitectura Políglota de CampusCloud

## 1. Planteamiento del Problema
En la primera etapa de CampusCloud, la persistencia se centralizó exclusivamente en **SQL Server**, resolviendo la integridad transaccional de las entidades núcleo: `Estudiantes`, `Servicios` y `Solicitudes`. Al ampliar las operaciones de la plataforma, surgieron tres requerimientos que degradan el rendimiento o complican el mantenimiento si se fuerzan dentro de un esquema relacional rígido:

1. **Perfiles descriptivos heterogéneos:** Cada categoría de servicio exige atributos distintos (inventario de hardware para laboratorios, horarios y modalidades para asesorías, o especificaciones técnicas para préstamos de equipo).
2. **Grafo de afinidades y recomendaciones:** Detectar qué servicios comparten los estudiantes y generar recomendaciones basadas en comportamiento requiere múltiples consultas recursivas (`JOIN`) de alto costo computacional en SQL.
3. **Bitácora continua de eventos de uso:** Registrar cada interacción produce un flujo constante de escrituras cronológicas que se consultan por estudiante y ventana de tiempo.

## 2. Diseño de Persistencia Políglota
La arquitectura mantiene a **SQL Server** como fuente única de verdad para identidad y transacciones, delegando las cargas especializadas a tres motores NoSQL mediante identificadores de referencia (`servicio_sql_id` y `estudiante_id`) sin duplicar información indiscriminadamente:

```text
                       [ Clientes / Aplicaciones CampusCloud ]
                                          │
        ┌───────────────────┬─────────────┴─────────────┬───────────────────┐
        ▼                   ▼                           ▼                   ▼
┌───────────────┐   ┌───────────────┐           ┌───────────────┐   ┌───────────────┐
│  SQL Server   │   │    MongoDB    │           │     Neo4j     │   │   Cassandra   │
│ (Relacional)  │   │ (Documental)  │           │   (Grafos)    │   │(Col. Anchas)  │
├───────────────┤   ├───────────────┤           ├───────────────┤   ├───────────────┤
│• Estudiantes  │   │• Fichas       │           │• Nodos        │   │• Eventos por  │
│• Servicios    │   │  extendidas   │           │  Estudiante   │   │  estudiante   │
│• Solicitudes  │   │• Arrays y     │           │• Relaciones   │   │• Series de    │
│• Transacción  │   │  subdocumentos│           │  USA/INTERESA │   │  tiempo       │
└───────┬───────┘   └───────┬───────┘           └───────┬───────┘   └───────┬───────┘
        │                   │                           │                   │
        └───────────────────┴─────────────┬─────────────┴───────────────────┘
                                          ▼
                        [ Red Docker: campus-network ]
                   [ Volúmenes Externos Persistentes (Host) ]