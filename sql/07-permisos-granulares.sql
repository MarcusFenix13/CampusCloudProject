
-- PERMISOS SOBRE TABLAS Y VISTAS
--- ASIGNACION DIRECRA A USUARIOS O ROLES A TABLAS ESPECIFICAS

SELECT SUSER_NAME() AS LOGIN, USER_NAME() AS UsuarioActual;

USE CampusCloud;
GO

CREATE VIEW v_solicitudes_2026
AS
SELECT e.nombre, s.fecha, s.estado
FROM Estudiantes AS e
INNER JOIN Solicitudes AS s
ON e.id_estudiante = s.id_estudiante
WHERE DATEPART(YEAR, s.fecha) = '2026'

SELECT * FROM v_solicitudes_2026

-- Permitir la lectura en una tabla especifica
GRANT SELECT ON dbo.Estudiantes TO admin_sql3;

EXECUTE AS USER = 'admin_sql3'

SELECT * FROM dbo.Servicios;

REVERT;

-- PERMITIR INSERCION Y ACTUALIZACION EN UNA TABLA (Servicios)

GRANT INSERT, UPDATE ON dbo.Servicios TO admin_sql3;

EXECUTE AS USER = 'admin_sql3'

SELECT * FROM dbo.Estudiantes;

INSERT INTO Servicios
VALUES(5, 'Becas', 'Te dan mucho dinero GG');

UPDATE Servicios 
SET descripcion = 'Poco Dinero'
WHERE id_servicio = 5;

REVERT;

GRANT SELECT ON dbo.Servicios TO admin_sql3;

EXECUTE AS USER = 'admin_sql3'

UPDATE Servicios 
SET descripcion = 'Poco Dinero'
WHERE id_servicio = 5;

SELECT * FROM Servicios;

-- Permiso total de codigo sql DML sobre una tabla
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Solicitudes TO admin_sql3;

SELECT * FROM Solicitudes;

INSERT INTO Solicitudes
VALUES(1003, 2, 1, '2026-10-23', 'Terminado');

UPDATE Solicitudes
SET estado = 'Pendiente'
WHERE id_solicitud = 1003;

DELETE Solicitudes
WHERE id_solicitud = 1003;

-- DENEGAR EXPLICITAMENTE LA ELIMINACION DE REGISTROS (BLOQUEO)

DENY DELETE ON dbo.Solicitudes TO admin_sql3;

EXECUTE AS USER = 'admin_sql3'

-- QUITAR LOS PERMISOS 
REVOKE UPDATE, DELETE, INSERT, SELECT ON dbo.Solicitudes FROM admin_sql3;

REVERT;
GO

