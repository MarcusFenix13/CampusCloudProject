# CampusCloud

Proyecto académico de la asignatura Bases de Datos en la Nube (Universidad Tecnológica de Tula-Tepeji).

## Objetivo

Construir progresivamente una Nube Académica Local que permita comprender:

- bases de datos relacionales;
- bases de datos NoSQL;
- persistencia;
- usuarios, roles y privilegios;
- conexión local y remota;
- integración mediante API;
- Docker y Docker Compose como herramientas de soporte.

---

## Unidad I

Primera implementación:

`PC → Docker → SQL Server → Volumen → CampusCloud`

Tecnología inicial:

- Docker Desktop
- SQL Server 2025
- Cliente SQL
- Git
- Visual Studio Code

---

## Unidad II: Persistencia Políglota (SQL + NoSQL)

Ampliación de la arquitectura para complementar el núcleo relacional de SQL Server con tres motores NoSQL especializados sin duplicar datos innecesariamente[cite: 1]:

`PC → Docker Compose → Red Externa (campus-network) → [SQL Server | PostgreSQL | MongoDB | Neo4j | Cassandra] → Volúmenes Externos`

### Servicios Utilizados y Puertos Locales
* **SQL Server 2025 
* **PostgreSQL 16 + pgAdmin 4 
* **MongoDB 
* **Neo4j 5 Community 
* **Apache Cassandra 

### Requisitos Previos
* Docker Desktop y Docker Compose v2 activos.
* Clientes: MongoDB Compass, navegador web (Neo4j Browser) y terminal con acceso a `cqlsh`.
* Archivo `docker/.env` configurado localmente.