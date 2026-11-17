USE campuscloud_eventos;

-- Eventos del Estudiante 1: Peter Parker (24300101) - 4 eventos
INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300101', '2026-11-10 09:15:00+0000', uuid(), 102, 'RESERVA_LAB', 'Acceso a Laboratorio Cloud', 'Web Desktop');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300101', '2026-11-12 11:30:00+0000', uuid(), 103, 'SOLICITUD_ASESORIA', 'Consulta de arquitectura NoSQL', 'Mobile App');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300101', '2026-11-14 16:00:00+0000', uuid(), 102, 'USO_CONTENEDOR', 'Despliegue de práctica Docker', 'Web Desktop');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300101', '2026-11-16 18:20:00+0000', uuid(), 105, 'PRESTAMO_EQUIPO', 'Solicitud Kit Arduino Mega', 'Kiosco Campus');

-- Eventos del Estudiante 2: Wanda Maximoff (24300102) - 4 eventos
INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300102', '2026-11-11 08:00:00+0000', uuid(), 101, 'RESERVA_LAB', 'Práctica de switching Cisco', 'Web Desktop');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300102', '2026-11-13 10:45:00+0000', uuid(), 101, 'ENTREGA_PRACTICA', 'Subida de topología Packet Tracer', 'Web Desktop');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300102', '2026-11-15 13:10:00+0000', uuid(), 102, 'RESERVA_LAB', 'Acceso a servidor Linux', 'Mobile App');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300102', '2026-11-16 19:00:00+0000', uuid(), 102, 'CIERRE_SESION', 'Finalización de entorno virtual', 'Web Desktop');

-- Eventos del Estudiante 3: Tony Stark (24300103) - 4 eventos
INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300103', '2026-11-09 12:00:00+0000', uuid(), 105, 'PRESTAMO_EQUIPO', 'Retiro de sensores IoT', 'Kiosco Campus');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300103', '2026-11-11 15:30:00+0000', uuid(), 105, 'DEVOLUCION_EQUIPO', 'Entrega sin daños reportados', 'Kiosco Campus');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300103', '2026-11-14 17:40:00+0000', uuid(), 102, 'CONSULTA_CATALOGO', 'Revisión de disponibilidad GPU', 'Mobile App');

INSERT INTO eventos_estudiante (estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle, dispositivo)
VALUES ('24300103', '2026-11-16 20:05:00+0000', uuid(), 106, 'PRESTAMO_EQUIPO', 'Reserva Laptop Workstation', 'Web Desktop');