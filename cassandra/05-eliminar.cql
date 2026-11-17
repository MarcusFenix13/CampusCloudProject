USE campuscloud_eventos;

-- 1. Consultar el registro del 10 de noviembre para obtener su evento_id
SELECT estudiante_id, fecha_evento, evento_id, tipo_accion
FROM eventos_estudiante
WHERE estudiante_id = '24300101'
  AND fecha_evento = '2026-11-10 09:15:00+0000';

-- 2. Eliminación controlada (97cb2ca2-b654-4c6a-8148-9bacb1ce5a04)
DELETE FROM eventos_estudiante
WHERE estudiante_id = '24300101'
  AND fecha_evento = '2026-11-10 09:15:00+0000'
  AND evento_id = 97cb2ca2-b654-4c6a-8148-9bacb1ce5a04;

-- 3. Verificar que el estudiante ahora tiene 3 eventos en lugar de 4
SELECT estudiante_id, fecha_evento, tipo_accion, detalle
FROM eventos_estudiante
WHERE estudiante_id = '24300101';