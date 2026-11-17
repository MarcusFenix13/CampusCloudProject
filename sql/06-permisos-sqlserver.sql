-- 1. Gestion de Roles Fijos

-- A) A nivel de Servidor

USE master;
GO

CREATE LOGIN admin_sql2
WITH PASSWORD = 'AdminSQL2?';
GO

-- AGREGAR UN INICIO DE SESION(LOGIN) AL ROL DE ADMINISTRADOR DE SERVIDOR
ALTER SERVER ROLE sysadmin
ADD MEMBER admin_sql2;
GO

CREATE LOGIN admin_sql3
WITH PASSWORD = 'AdminSQL3?';
GO

SELECT * FROM Servicios;

DELETE FROM Servicios WHERE id_servicio = 2;

-- AGREGAR AL ROL DE CREADOR DE BASE DE DATOS
ALTER SERVER ROLE dbcreator ADD MEMBER admin_sql3;
GO

DROP LOGIN admin_sql3

-- B) A nivel de base de datos

USE CampusCloud;
GO

CREATE USER admin_sql3
FOR LOGIN admin_sql3;

-- Permitir solo lectura (SELECT EN TODAS LAS TABLAS Y VISTAS)
ALTER ROLE db_datareader
ADD MEMBER admin_sql3;

EXECUTE AS USER = 'admin_sql3';

USE CampusCloud;
GO

ALTER ROLE db_datareader
DROP MEMBER admin_sql3;
GO

-- Permitir solo escritura (INSERT, UPDATE, DELETE en todas las tablas)

ALTER ROLE db_datawriter
ADD MEMBER admin_sql3;

ALTER ROLE db_datareader
DROP MEMBER admin_sql3;

EXECUTE AS USER = 'admin_sql3';
REVERT;

SELECT * FROM Servicios;

SELECT SUSER_NAME() AS LOGIN, USER_NAME() AS UsuarioActual;

INSERT INTO Servicios
VALUES (3, 'Cafeteria', 'Pura comida buena');

UPDATE Servicios
SET nombre = 'cafeteria2'
WHERE id_servicio = 3; ---> El datawriter no permite usar el WHERE porque tambien es de select

DELETE FROM Servicios;

REVERT;
GO

-- ESTE PERMITE ADMINIDISTRACION DE OBJETOS (DDL: CREATE, ALTER, DROP)

ALTER ROLE db_ddladmin 
ADD MEMBER admin_sql3;
GO

EXECUTE AS USER = 'admin_sql3';

SELECT * FROM Estudiantes;

CREATE TABLE prueba (
	id INT NOT NULL,
	nombre VARCHAR(100)
);

ALTER TABLE prueba
ADD edad INT NOT NULL;

DROP TABLE prueba;
GO

REVERT;
GO

