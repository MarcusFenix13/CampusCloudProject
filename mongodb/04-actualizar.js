use('CampusCloud');

// Antes de actualizar
print("--- Estado ANTES de actualizar (servicio_sql_id: 104) ---");
printjson(db.detalles_servicios.findOne({ servicio_sql_id: 104 }));

// Actualización controlada
db.detalles_servicios.updateOne(
  { servicio_sql_id: 104 },
  {
    $set: {
      disponible: true,
      "ubicacion.cubiculo": "Sala Estudio 4"
    },
    $push: {
      etiquetas: "algebra"
    }
  }
);

// Después de actualizar
print("--- Estado DESPUÉS de actualizar (servicio_sql_id: 104) ---");
printjson(db.detalles_servicios.findOne({ servicio_sql_id: 104 }));