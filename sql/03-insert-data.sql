USE CampusCloud;
GO

INSERT INTO Estudiantes (id_estudiante, matricula, nombre, correo)
VALUES (1, '2026001','Ana Lopez', 'ana@uttt.mx'),
	   (2, '2026002','Pedro Lopez', 'pedro@uttt.mx');
GO

INSERT INTO Servicios(id_servicio, nombre, descripcion)
VALUES (1, 'Constancia de Estudio','Solicitud de Constancia Academica'),
	   (2, 'Prestamo de Laboratorio','Se Reservo el Equipo de Laboratorio');
GO

INSERT INTO Solicitudes(id_solicitud,id_estudiante, id_servicio, fecha, estado)
VALUES (1001, 1, 1,'2026-10-21', 'Pendiente'),
	   (1002, 2, 2, '2026-10-22', 'Pendiente');
GO

SELECT * FROM Estudiantes;
SELECT * FROM Servicios;
SELECT * FROM Solicitudes;

