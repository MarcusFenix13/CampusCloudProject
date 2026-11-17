USE campuscloud_eventos;

-- 1. Consultar toda la actividad de un estudiante (ordenada del evento más reciente al más antiguo)
SELECT estudiante_id, fecha_evento, evento_id, tipo_accion, detalle, dispositivo
FROM eventos_estudiante
WHERE estudiante_id = '24300101';

-- 2. Consultar actividad de un estudiante dentro de un periodo específico (12 al 16 de noviembre)
SELECT estudiante_id, fecha_evento, evento_id, servicio_sql_id, tipo_accion, detalle
FROM eventos_estudiante
WHERE estudiante_id = '24300101'
  AND fecha_evento >= '2026-11-12 00:00:00+0000'
  AND fecha_evento <= '2026-11-16 23:59:59+0000';