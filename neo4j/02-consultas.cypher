// CONSULTA 1: Servicios usados por un estudiante específico (Peter Parker)
MATCH (e:Estudiante {nombre: "Peter Parker"})-[r:USA]->(s:Servicio)
RETURN e.nombre AS Estudiante, s.nombre AS Servicio, r.frecuencia AS Frecuencia, r.calificacion AS Calificacion;

// CONSULTA 2: Estudiantes que comparten un mismo servicio (Laboratorio de Desarrollo Cloud)
MATCH (e:Estudiante)-[r:USA]->(s:Servicio {servicio_sql_id: 102})
RETURN s.nombre AS ServicioCompartido, e.nombre AS Estudiante, e.carrera AS Carrera, r.frecuencia AS Uso;

// CONSULTA 3: Recomendación básica basada en relaciones (Filtrado colaborativo)
// Si otro estudiante usa los mismos servicios que Natasha Romanoff y además usa otro servicio que ella aún no usa, recomiéndaselo.
MATCH (natasha:Estudiante {nombre: "Natasha Romanoff"})-[:USA]->(sComun:Servicio)<-[:USA]-(compañero:Estudiante)-[:USA]->(sRecomendado:Servicio)
WHERE NOT (natasha)-[:USA]->(sRecomendado)
RETURN DISTINCT natasha.nombre AS ParaEstudiante, sRecomendado.nombre AS ServicioRecomendado, compañero.nombre AS BasadoEnCompanero;