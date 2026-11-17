# Bitácora de Pruebas, Controles de Seguridad y Diagnóstico

## 1. Matriz de Conectividad, Persistencia y Acceso Básico

| Gestor | Cliente Utilizado | Host y Puerto | Control de Acceso / Autenticación | Prueba de Persistencia |
| :--- | :--- | :--- | :--- | :--- |
| **MongoDB** | MongoDB Compass / `mongosh` | `localhost:27017` | Autenticación SCRAM contra `authSource=admin` con usuario administrador (`root`). | Reinicio con `docker restart campuscloud-mongo`; los 5 documentos restantes permanecieron íntegros. |
| **Neo4j** | Neo4j Browser (Web) | `localhost:7474` (HTTP) / `7687` (Bolt) | Autenticación nativa habilitada mediante variable `NEO4J_AUTH` (`neo4j/<password>`). | Reinicio con `docker restart campuscloud-neo4j`; los 9 nodos y 10 relaciones se mantuvieron intactos. |
| **Cassandra** | Consola interactiva `cqlsh` | `localhost:9042` | Acceso local en contenedor aislado (`AllowAllAuthenticator` por defecto en desarrollo). | Almacenamiento respaldado en el volumen externo `campuscloud-cassandra-data` (`/var/lib/cassandra`). |

## 2. Ejecución de Pruebas por Módulo (`evidencias/unidad-ii/`)

### A. Módulo MongoDB (`mongodb/01` a `06` | `evidencias/unidad-ii/mongodb/`)
* **Conexión y Autenticación (`01-conexion.png`, `08-autenticacion.png`):** Validación de enlace desde MongoDB Compass y verificación de sesión activa mediante `db.runCommand({ connectionStatus: 1 })`.
* **Diseño y Carga (`02-documentos-insertados.png`):** Creación de la base `CampusCloud` y la colección `detalles_servicios` con esquema validador (`$jsonSchema`). Inserción de 6 documentos distribuidos en 3 categorías (`Laboratorio`, `Asesoría` y `Préstamo de Equipo`), incluyendo arreglos (`etiquetas`) y subdocumentos (`ubicacion`, `especificaciones`).
* **Consultas y Agregación (`03-consultas-filtros.png`, `06-agregacion.png`):** Ejecución de 3 filtros distintos (por igualdad de categoría, operador `$in` sobre arreglos y notación de punto sobre subdocumentos) y una tubería de agregación (`$group` + `$sum`) para contabilizar servicios totales y disponibles por categoría.
* **Mutaciones y Persistencia (`04-actualizacion-antes-despues.png`, `05-eliminacion.png`, `07-persistencia.png`):** Actualización controlada del registro `104` (disponibilidad y cubículo), eliminación directa del mismo registro y comprobación de persistencia tras reiniciar el servicio.

### B. Módulo Neo4j (`neo4j/01` a `03` | `evidencias/unidad-ii/neo4j/`)
* **Construcción del Grafo (`01-conexion.png`, `02-grafo-nodos-relaciones.png`):** Creación de 5 nodos `:Estudiante`, 4 nodos `:Servicio` y 10 relaciones dirigidas (`:USA` y `:LE_INTERESA`) con propiedades de frecuencia, fecha y calificación.
* **Consultas Cypher (`03-consultas-cypher.png`):** Ejecución de tres consultas clave: (1) servicios utilizados por un estudiante específico, (2) estudiantes que coinciden en un mismo laboratorio, y (3) sistema de recomendación por filtrado colaborativo mediante patrones de caminos (`WHERE NOT (natasha)-[:USA]->(sRecomendado)`).
* **Modificación y Persistencia (`04-actualizacion.png`, `05-persistencia.png`):** Actualización controlada de propiedades en una relación con `SET` y verificación del conteo de nodos tras reiniciar el contenedor.

### C. Módulo Cassandra (`cassandra/01` a `05` | `evidencias/unidad-ii/cassandra/`)
* **Modelo Orientado a Consultas (`01-conexion-y-tabla.png`):** Creación del keyspace `campuscloud_eventos` (`SimpleStrategy`, factor 1) y la tabla `eventos_estudiante` con `PRIMARY KEY ((estudiante_id), fecha_evento, evento_id)` y ordenamiento `CLUSTERING ORDER BY (fecha_evento DESC, evento_id ASC)`.
* **Carga y Operaciones CQL (`02-insertar-eventos.png` a `05-eliminar.png`):** Inserción de 12 eventos repartidos entre 3 estudiantes, consulta filtrada por rango de fechas (`>=` y `<=`), actualización (`UPDATE`) y eliminación (`DELETE`) especificando la clave primaria completa.
* **Limitación Técnica Demostrada:** Al intentar filtrar por columnas fuera de la clave primaria (por ejemplo, `WHERE dispositivo = 'Mobile App'`), Cassandra rechaza la consulta indicando que requiere `ALLOW FILTERING`. Esto demuestra que el motor evita escaneos completos entre nodos para proteger el rendimiento, obligando a diseñar las tablas en función exacta de las consultas previstas.

## 3. Incidencias Diagnosticadas y Soluciones Aplicadas

### Incidencia 1: Error de manifiesto de arquitectura al descargar imagen de MongoDB
* **Descripción del error:** Al ejecutar `docker run -d --name mongo2025 mongo:9.0.4-windowsservercore-ltsc2025`, el daemon devolvió: `no matching manifest for linux/amd64/v3 in the manifest list entries: no match for platform in manifest: not found`.
* **Diagnóstico:** Docker Desktop operaba bajo el motor de contenedores Linux (WSL2), mientras que la etiqueta solicitada corresponde exclusivamente a contenedores nativos de Windows Server.
* **Solución:** Se configuró la etiqueta oficial multi-arquitectura `mongo:latest` dentro de `docker/compose.yaml`, logrando una descarga y ejecución compatibe con `linux/amd64`.

### Incidencia 2: Conflicto de nombres de contenedor al reestructurar directorios
* **Descripción del error:** Tras mover `compose.yaml` a la subcarpeta `docker/` y ejecutar `docker compose up -d`, Docker reportó: `Conflict. The container name "/campuscloud-neo4j" is already in use`.
* **Diagnóstico:** Docker Compose deriva el nombre del proyecto a partir del directorio de trabajo; al cambiar de la raíz a `docker/`, intentó instanciar un proyecto nuevo colisionando con los `container_name` fijos ya existentes.
* **Solución:** Se ejecutó `docker compose down` sobre el despliegue anterior (preservando intactos los volúmenes externos) y se declaró explícitamente `name: campuscloud` en la cabecera de `docker/compose.yaml`.