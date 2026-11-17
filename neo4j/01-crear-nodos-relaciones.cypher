// Limpiar nodos previos si se vuelve a ejecutar el script
MATCH (n) DETACH DELETE n;

// Crear 5 nodos Estudiante
CREATE (e1:Estudiante {matricula: "24300101", nombre: "Peter Parker", carrera: "TIC - Desarrollo de Software", semestre: 5})
CREATE (e2:Estudiante {matricula: "24300102", nombre: "Wanda Maximoff", carrera: "TIC - Redes y Cloud", semestre: 5})
CREATE (e3:Estudiante {matricula: "24300103", nombre: "Tony Stark", carrera: "Ingeniería Mecatrónica", semestre: 7})
CREATE (e4:Estudiante {matricula: "24300104", nombre: "Natasha Romanoff", carrera: "Ciberseguridad", semestre: 6})
CREATE (e5:Estudiante {matricula: "24300105", nombre: "Bruce Banner", carrera: "Ciencia de Datos", semestre: 8})

// Crear 4 nodos Servicio (vinculados a los IDs de SQL Server)
CREATE (s1:Servicio {servicio_sql_id: 101, nombre: "Laboratorio de Redes Cisco", categoria: "Laboratorio"})
CREATE (s2:Servicio {servicio_sql_id: 102, nombre: "Laboratorio de Desarrollo Cloud", categoria: "Laboratorio"})
CREATE (s3:Servicio {servicio_sql_id: 103, nombre: "Asesoría de Arquitectura de Software", categoria: "Asesoría"})
CREATE (s4:Servicio {servicio_sql_id: 105, nombre: "Kit de Robótica Arduino Mega", categoria: "Préstamo de Equipo"})

// Crear 10 relaciones con propiedades útiles (superando el mínimo de 8)
CREATE (e1)-[:USA {frecuencia: "Alta", ultima_vez: "2026-11-10", calificacion: 5}]->(s2)
CREATE (e1)-[:USA {frecuencia: "Media", ultima_vez: "2026-11-12", calificacion: 4}]->(s3)
CREATE (e1)-[:LE_INTERESA {motivo: "Proyecto IoT"}]->(s4)

CREATE (e2)-[:USA {frecuencia: "Alta", ultima_vez: "2026-11-14", calificacion: 5}]->(s1)
CREATE (e2)-[:USA {frecuencia: "Alta", ultima_vez: "2026-11-15", calificacion: 5}]->(s2)

CREATE (e3)-[:USA {frecuencia: "Alta", ultima_vez: "2026-11-11", calificacion: 5}]->(s4)
CREATE (e3)-[:USA {frecuencia: "Baja", ultima_vez: "2026-11-05", calificacion: 4}]->(s2)

CREATE (e4)-[:USA {frecuencia: "Alta", ultima_vez: "2026-11-16", calificacion: 5}]->(s1)
CREATE (e4)-[:LE_INTERESA {motivo: "Auditoria de contenedores"}]->(s2)

CREATE (e5)-[:USA {frecuencia: "Media", ultima_vez: "2026-11-13", calificacion: 5}]->(s3)

// Retornar el grafo completo para visualización
RETURN e1, e2, e3, e4, e5, s1, s2, s3, s4;