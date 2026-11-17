use('CampusCloud');

// Consulta 1: Filtro simple por categoría y disponibilidad
print("--- 1. Servicios de categoría 'Laboratorio' disponibles ---");
printjson(
  db.detalles_servicios.find(
    { categoria: "Laboratorio", disponible: true },
    { _id: 0, servicio_sql_id: 1, nombre: 1, "ubicacion.aula": 1 }
  ).toArray()
);

// Consulta 2: Filtro por elemento dentro de un array (etiquetas)
print("--- 2. Servicios etiquetados con 'docker' o 'iot' ---");
printjson(
  db.detalles_servicios.find(
    { etiquetas: { $in: ["docker", "iot"] } },
    { _id: 0, nombre: 1, categoria: 1, etiquetas: 1 }
  ).toArray()
);

// Consulta 3: Filtro por campo dentro de un subdocumento (dot notation)
print("--- 3. Servicios ubicados en el 'Edificio TIC' ---");
printjson(
  db.detalles_servicios.find(
    { "ubicacion.edificio": "Edificio TIC" },
    { _id: 0, servicio_sql_id: 1, nombre: 1, ubicacion: 1 }
  ).toArray()
);