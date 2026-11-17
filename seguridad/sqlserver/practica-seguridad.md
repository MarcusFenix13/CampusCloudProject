# Administracion de seguridad en SQLSERVER

## Fundamentos

| Concepto | Nivel | Proposito | Ejemplo |
|---|---|---|---|
|**Login**| Instancia de SQL Server | Autenticar una identidad ante el servidor | `admin_sql` |
|**User**| Base de Datos | Representa la identidad ante el servidor | `dbo` |
|**Rol de Servidor**| Instancia | Agrupa privilegios administrados a nivel de servidor | `sysadmin` |
|**Base de Datos Actual**| Sesion | Determinar el contexto de ejecucion de una consulta  | `master` |

# 1. Diagnostico de la conexion Administrativa

```sql
-- Comprobar el login actual

SELECT SUSER_NAME() AS LoginActual;

-- Verificar los permisos sysadmin

SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin];
```

| Resultado | Interpretacion |
|--|--|
|1|Pertenece al rol consultado|
|0|No pertenece a ese rol|
|Null|No se puede determinar el resultado| 

```sql

SELECT 
	SUSER_NAME() AS LoginActual,
	IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin]
GO

-- Consultar el estado de sa

SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';
```
| Resultado | Interpretacion |
|--|--|
|name|es el nombre del principal|
|type_desc|tipo de principal, para este caso el principal es SQL_LOGIN|
|is_disabled|0 significa habilitado y 1 el deshabilitado| 

```sql
-- Verificar la base de datos actual

SELECT
	DB_NAME() AS BaseActual
GO

-- Consulta completa del contexto

SELECT
	SUSER_SNAME() AS LoginActual,
	USER_NAME() AS UsuarioBase,
	DB_NAME() AS BaseActual,
	IS_SRVROLEMEMBER('sysadmin') AS EsSysadmin;
```

**CREACION Y PRUEBA DE UN ADMINISTRADOR ALTERNATIVO**

```sql
-- Para hacer un login siempre debemos estar en master

USE master
GO

-- Crear el login admin_sql

CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin@Cloud12',
CHECK_POLICY = ON;
```

`CREATE LOGIN admin_sql` : crea una identidad que pueda autenticarse ante la instancia

`WITH PASSWORD` : Define una contrasena de autenticacion SQL Server

`CHECK_POLICY` : Solicita aplicar la politica de contrasena correspondiente cuando esta disponible

**Deshabilitacion controlada de sa**

```sql
-----------------------------------------
------- PARTE DEL LOGIN admin_sql -------
-----------------------------------------

------ Deshabilitacion controlada de SA
-- COMPROBAR

SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';

-- DESHABILITAR SA
ALTER LOGIN sa DISABLE;
```

