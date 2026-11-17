-- SELECCIONAR A MASTER Y CREAR LA BASE DE DATOS 

USE master
GO

CREATE DATABASE empresaVentas
GO

-- Verificar que la base de datos existe

SELECT 
	name,
	state_desc
FROM sys.databases
WHERE name = 'empresaVentas'
GO

USE empresaVentas
GO

CREATE TABLE dbo.productos (
	Idproductos INT PRIMARY KEY,
	Nombre VARCHAR(100) NOT NULL,
	Precio DECIMAL(10, 2) NOT NULL,
	Existencia INT NOT NULL
);

CREATE TABLE dbo.clientes (
	Idclientes INT PRIMARY KEY,
	Nombre VARCHAR(100) NOT NULL,
	Correo VARCHAR(150)
);

CREATE TABLE dbo.ventas (
	Idventas INT PRIMARY KEY,
	Idclient INT NOT NULL,
	Fecha DATE NOT NULL,
	Total DECIMAL(10,2) NOT NULL
);

USE empresaVentas
GO

CREATE SCHEMA rh
GO

CREATE TABLE rh.nomina(
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_nomina VARCHAR(50) NOT NULL UNIQUE,
	total DECIMAL (10,2) NOT NULL
	CHECK (total > 0.0)
)

INSERT INTO dbo.productos (Idproductos, Nombre, Precio, Existencia)
VALUES(1, 'Laptop', 18000.0, 10),
	  (2, 'Monitor', 4500.0, 20),
	  (3, 'Teclado', 850.0, 35),
	  (4, 'Mouse', 450.0, 50),
	  (5, 'Impresora', 6200.0, 8);

INSERT INTO dbo.clientes(Idclientes, Nombre, Correo)
VALUES(1, 'Empresa Alfa', 'Contacto@alfa.com'),
	  (2, 'Empresa Beta', 'Ventas@beta.com'),
	  (3, 'Comercial Gamma', 'Compras@gamma.com'),
	  (4, 'Servicios Delta', 'Servicios@delta.com'),
	  (5, 'Industrial Omega', 'Ventas@alfa.com');

INSERT INTO dbo.ventas(Idventas, Idclient, Fecha, Total)
VALUES(1, 1, '2026-10-01', 1800.0),
	  (2, 2, '2026-10-01', 4500.0),
	  (3, 3, '2026-10-01', 2800.0),
	  (4, 4, '2026-10-01', 6900.0),
	  (5, 5, '2026-10-01', 3000.0);

SELECT * FROM dbo.clientes;
SELECT * FROM dbo.productos;
SELECT * FROM dbo.ventas;

--- CREAR LOGIN OPERATIVO VENDEDOR 1

USE master
GO

SELECT DB_NAME() AS [Base de Datos Actual]
GO

--- LOGIN
CREATE LOGIN vendedor1
WITH PASSWORD = 'Vendedor?',
CHECK_POLICY = ON;

--- VERIFICAR LOGIN
SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'vendedor1';

-- VERIFICAR QUE ESTE LOGIN NO SEA SYSADMIN

SELECT
	IS_SRVROLEMEMBER('sysadmin', 'vendedor1') AS EsSysAdmin;

-- CREAR USER

USE empresaVentas
GO

CREATE USER vendedor1 
FOR LOGIN vendedor1;

SELECT
	name,
	type_desc,
	authentication_type_desc
FROM sys.database_principals
WHERE name = 'vendedor1';

-- CONCEDER PERMISOS DE SELECT DIRECTAMENTE AL USUARIO

GRANT SELECT
ON dbo.productos
TO vendedor1;

REVOKE SELECT
ON dbo.productos
FROM vendedor1;

SELECT
	pr.name AS Principal,
	pe.permission_name AS Permiso,
	pe.state_desc AS Estado,
	OBJECT_NAME(pe.major_id) AS Objecto
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'vendedor1';

--- CONCEDER VARIOS PERMISOS AL USUARIO

GRANT SELECT
ON dbo.productos
TO vendedor1;

GRANT SELECT
ON dbo.clientes
TO vendedor1;

GRANT SELECT
ON dbo.ventas
TO vendedor1;

GRANT INSERT
ON dbo.ventas
TO vendedor1;

GRANT SELECT, INSERT
ON rh.nomina
TO vendedor1;

-- Crear un rol_vendedor y administracion de permisos mediante roles
USE empresaVentas;
GO
-- Crear el rol
CREATE ROLE rol_vendedor;
GO
-- Verificar el rol
SELECT 
	name,
	type_desc
FROM sys.database_principals
WHERE name = 'rol_vendedor'
-- Quitar el permiso de SELECT a vendedor1 de la tabla productos
REVOKE SELECT 
ON dbo.productos
FROM vendedor1;
-- Agregar vendedor1 al rol rol_vendedor
ALTER ROLE rol_vendedor
ADD MEMBER vendedor1;
-- Verificar la membresia del usuario en el rol
SELECT
	r.name AS [Rol],
	u.name AS [Usuario]
FROM sys.database_role_members AS drm
INNER JOIN sys.database_principals AS r
ON drm.role_principal_id = r.principal_id
INNER JOIN sys.database_principals AS u
ON drm.member_principal_id = u.principal_id
WHERE r.name = 'rol_vendedor'

-- Conceder permisos de SELECT sobre productos al ROL
GRANT SELECT 
ON dbo.productos
TO rol_vendedor;
GO

-- QUITAR TODOS LOS PERMISOS AL VENDEDOR1
REVOKE SELECT, INSERT
ON dbo.ventas
TO vendedor1;

REVOKE SELECT
ON dbo.productos
FROM vendedor1;

REVOKE SELECT
ON dbo.clientes
FROM vendedor1;

REVOKE SELECT, INSERT
ON rh.nomina
TO vendedor1;

-- AGREGAR LOS PERMISOS AL ROL

GRANT SELECT 
ON dbo.productos
TO rol_vendedor;
GO

GRANT SELECT, INSERT
ON dbo.ventas
TO rol_vendedor;
GO

GRANT SELECT, INSERT, UPDATE
ON dbo.clientes
TO rol_vendedor;
GO

GRANT SELECT, INSERT
ON rh.nomina
TO rol_vendedor;
GO

-- Creacion del vendedor 2
CREATE LOGIN vendedor2
WITH PASSWORD = 'vendedorDos?',
CHECK_POLICY = ON;

USE empresaVentas;
GO

CREATE USER vendedor2
FOR LOGIN vendedor2

ALTER ROLE rol_vendedor
ADD MEMBER vendedor2;

-- CONSULTAR LOS PERMISOS DEL ROL

SELECT
	pr.name AS Principal,
	pe.permission_name AS Permiso,
	pe.state_desc AS Estado,
	OBJECT_NAME(pe.major_id) AS Objeto
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'rol_vendedor'
