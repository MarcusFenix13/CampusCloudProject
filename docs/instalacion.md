## 1. Arquitectura del Entorno en Docker
El despliegue se define de forma declarativa en `docker/compose.yaml` bajo el nombre de proyecto fijo `campuscloud`. Todos los servicios se comunican mediante la red externa `campus-network` y almacenan su estado en volúmenes externos administrados por Docker en el host, garantizando la permanencia de los datos ante recreaciones o reinicios de contenedores.

## 2. Inventario de Servicios y Conectividad Local

| Servicio Compose | Contenedor | Imagen Oficial | Puerto Host | Puerto Interno | Volumen Externo |
| :--- | :--- | :--- | :---: | :---: | :--- |
| `sql-cloud` | `campuscloud-sql` | `mcr.microsoft.com/mssql/server:2025-CU8-ubuntu-24.04` | `14330` | `1433` | `campuscloud-sql-data` |
| `postgres-cloud` | `campuscloud-postgres` | `postgres:16-bookworm` | `54320` | `5432` | `campuscloud-postgres-data` |
| `pgadmin-cloud` | `campuscloud-pgadmin` | `dpage/pgadmin4:6.17` | `8083` | `80` | `campuscloud-pgadmin-data` |
| `mongo-cloud` | `campuscloud-mongo` | `mongo:latest` | `27017` | `27017` | `campuscloud-mongo-data` |
| `neo4j-cloud` | `campuscloud-neo4j` | `neo4j:5-community` | `7474` / `7687` | `7474` / `7687` | `campuscloud-neo4j-data` |
| `cassandra-cloud` | `campuscloud-cassandra` | `cassandra:latest` | `9042` | `9042` | `campuscloud-cassandra-data` |

## 3. Procedimiento de Reproducción

### Paso 1: Configurar variables de entorno
Crear el archivo local `docker/.env` a partir de la plantilla `docker/.env.example` y asignar contraseñas seguras:
```bash
cp docker/.env.example docker/.env
```

### Paso 2: Crear red y volúmenes externos

```bash
docker network create campus-network
docker volume create campuscloud-postgres-data
docker volume create campuscloud-pgadmin-data
docker volume create campuscloud-sql-data
docker volume create campuscloud-mongo-data
docker volume create campuscloud-neo4j-data
docker volume create campuscloud-cassandra-data
```
### Paso 3: Operación de contenedores (desde la raíz del repositorio)

```bash
docker compose -f docker/compose.yaml up -d
```
