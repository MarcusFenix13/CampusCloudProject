# Comparación Arquitectónica: Despliegue Local vs. Servicios en la Nube

## 1. Diferencia Conceptual: Contenedores Locales vs. DBaaS
El entorno desplegado en CampusCloud utiliza **Docker Compose sobre una máquina local** para garantizar portabilidad, aislamiento y reproducibilidad académica. Sin embargo, **ejecutar bases de datos en contenedores locales no equivale a un servicio administrado en la nube (DBaaS)**. En un entorno local, el equipo de desarrollo asume la administración completa del motor, la red, el almacenamiento y la disponibilidad; mientras que en la nube pública el proveedor entrega motores gestionados con tolerancia a fallos, escalabilidad elástica y acuerdos de nivel de servicio (SLA). Asimismo, las equivalencias entre proveedores se plantean por **necesidad arquitectónica** y no como reemplazos idénticos uno a uno.

## 2. Alternativas por Necesidad en Proveedores Cloud

| Necesidad de CampusCloud | Implementación Local (Docker) | Amazon Web Services (AWS) | Microsoft Azure | Google Cloud Platform (GCP) |
| :--- | :--- | :--- | :--- | :--- |
| **Catálogo variable y flexible (Documentos)** | MongoDB (`mongo:latest`) | Amazon DocumentDB / MongoDB Atlas en AWS | Azure Cosmos DB (API para MongoDB) | Cloud Firestore / MongoDB Atlas en GCP |
| **Red de afinidades y recomendaciones (Grafos)** | Neo4j 5 Community (`neo4j:5-community`) | Amazon Neptune | Azure Cosmos DB (API para Apache Gremlin) | Neo4j AuraDB (integrado en GCP Marketplace) |
| **Bitácora cronológica de eventos (Columnas Anchas)** | Apache Cassandra (`cassandra:latest`) | Amazon Keyspaces (compatible con Apache Cassandra) | Azure Managed Instance for Apache Cassandra | Cloud Bigtable |
| **Núcleo transaccional (Relacional)** | SQL Server 2025 / PostgreSQL 16 | Amazon RDS (SQL Server / PostgreSQL) | Azure SQL Database / Azure Database for PostgreSQL | Cloud SQL |

## 3. Modelo de Responsabilidad Compartida en la Nube

### Actividades que Administra el Proveedor Cloud
* **Aprovisionamiento y mantenimiento:** Despliegue de instancias, actualizaciones del motor de base de datos y parches de seguridad del sistema operativo subyacente sin ventanas de inactividad prolongadas.
* **Alta disponibilidad y replicación:** Replicación síncrona o asíncrona entre múltiples Zonas de Disponibilidad (Multi-AZ) y conmutación automática por error (*failover*).
* **Respaldos y recuperación:** Generación automática de copias de seguridad incrementales y restauración a un punto específico en el tiempo (*Point-in-Time Recovery*).
* **Escalabilidad de infraestructura:** Ajuste dinámico de capacidad de cómputo, memoria y almacenamiento (IOPS o unidades de solicitud) ante picos de carga académica.

### Responsabilidades que Conserva el Cliente (Equipo CampusCloud)
* **Diseño del modelo de datos:** Definir estructuras documentales, índices en MongoDB, etiquetas/relaciones en Neo4j y claves de partición/agrupamiento en Cassandra (un mal diseño de *Partition Key* provoca particiones calientes incluso en servicios administrados).
* **Optimización de consultas y costos:** Escribir consultas eficientes que eviten escaneos completos de tabla (`ALLOW FILTERING` o búsquedas sin índice), ya que en la nube las lecturas/escrituras ineficientes impactan directamente en la facturación.
* **Seguridad de acceso y datos:** Administración de usuarios, roles (RBAC), rotación de contraseñas/llaves, cifrado a nivel de aplicación y configuración de perímetros de red (VPC, Security Groups o Firewalls).