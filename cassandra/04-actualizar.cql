USE campuscloud_eventos;

-- 1. Consultar el registro para obtener su evento_id exacto
SELECT estudiante_id, fecha_evento, evento_id, detalle, dispositivo
FROM eventos_estudiante
WHERE estudiante_id = '24300101'
  AND fecha_evento = '2026-11-16 18:20:00+0000';

-- 2. Actualización controlada (5543bf65-f546-49a2-aff6-01b65b85c273)
UPDATE eventos_estudiante
SET detalle = 'Solicitud Kit Arduino Mega (Aprobada por Lab)',
    dispositivo = 'Web Desktop'
WHERE estudiante_id = '24300101'
  AND fecha_evento = '2026-11-16 18:20:00+0000'
  AND evento_id = 5543bf65-f546-49a2-aff6-01b65b85c273;

-- 3. Verificar el cambio aplicado
SELECT estudiante_id, fecha_evento, evento_id, detalle, dispositivo
FROM eventos_estudiante
WHERE estudiante_id = '24300101'
  AND fecha_evento = '2026-11-16 18:20:00+0000';