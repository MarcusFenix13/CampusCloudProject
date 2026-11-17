SELECT * FROM Estudiantes;

INSERT INTO Estudiantes
VALUES(3,'2045001', 'J ANGEL', 'ja@uttt.mx');

UPDATE Estudiantes
SET nombre = 'Enfermera J Angel'
WHERE id_estudiante = 3;

DELETE Estudiantes 
WHERE id_estudiante = 3;

--- CAMBIAR AL CONTEXTO DEL USUARIO

EXECUTE AS USER = 'consulta_campus';
GO

SELECT * FROM Estudiantes;

INSERT INTO Estudiantes
VALUES(4,'2045001', 'J ANGEL', 'ja@uttt.mx');

UPDATE Estudiantes
SET nombre = 'Enfermera J Angel'
WHERE id_estudiante = 4;

REVERT;
GO

-- CAMBIAR A OPERADOR

EXECUTE AS USER = 'operador_campus';
GO

SELECT
	SYSTEM_USER AS [Login_Original],
	CURRENT_USER AS [USUARIO_DB_ACTUAL],
	USER_NAME() AS [NOMBRE_USUARIO]


SELECT * FROM Estudiantes;

INSERT INTO Estudiantes
VALUES(3,'2045001', 'J ANGEL', 'ja@uttt.mx');

UPDATE Estudiantes
SET nombre = 'Enfermera J Angel'
WHERE id_estudiante = 3;

DELETE Estudiantes 
WHERE id_estudiante = 3;

REVERT;
GO

