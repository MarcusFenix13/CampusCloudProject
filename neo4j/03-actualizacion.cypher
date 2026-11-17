// 1. Consultar estado ANTES de actualizar
MATCH (e:Estudiante {nombre: "Peter Parker"})-[r:USA]->(s:Servicio {servicio_sql_id: 103})
RETURN e.nombre AS Estudiante, s.nombre AS Servicio, r.frecuencia AS FrecuenciaAnterior, r.calificacion AS CalificacionAnterior;

// 2. Actualización controlada: Subir frecuencia a "Alta" y calificación a 5
MATCH (e:Estudiante {nombre: "Peter Parker"})-[r:USA]->(s:Servicio {servicio_sql_id: 103})
SET r.frecuencia = "Alta", r.calificacion = 5, r.actualizado = "2026-11-16"
RETURN e.nombre AS Estudiante, s.nombre AS Servicio, r.frecuencia AS FrecuenciaNueva, r.calificacion AS CalificacionNueva;