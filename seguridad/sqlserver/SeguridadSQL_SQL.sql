-- Comprobar el login actual

SELECT SUSER_NAME() AS LoginActual;

-- Verificar los permisos sysadmin

SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin];

---- El 1 -> Pertenece al rol consultado
---- El 0 -> No pertenece a ese rol
---- Null -> No se puede determinar el resultado

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

-- name -> es el nombre del principal
-- type_desc -> tipo de principal, para este caso el principal es SQL_LOGIN
-- is_disabled -> 0 significa habilitado y 1 el 1 deshabilitado

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

-- Creacion y Prueba de un administrador alternativo

-- Para hacer un login siempre debemos estar en master

USE master
GO

-- Crear el login admin_sql

CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin@Cloud12',
CHECK_POLICY = ON;

-- Verificar si existe y esta habilitado

SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'admin_sql'
GO

-- Demostrar que crear un login no lo hace administrador

SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysadmin

-- Agregar admin_sql al rol de servidor sysadmin

ALTER SERVER ROLE sysadmin
ADD MEMBER admin_sql
GO

-- Validar la nueva membresia

SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysadmin



