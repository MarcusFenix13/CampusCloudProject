use('CampusCloud');

print("--- Agregación: Conteo de servicios por categoría ---");
printjson(
  db.detalles_servicios.aggregate([
    {
      $group: {
        _id: "$categoria",
        total_servicios: { $sum: 1 },
        servicios_disponibles: {
          $sum: { $cond: [{ $eq: ["$disponible", true] }, 1, 0] }
        }
      }
    },
    {
      $sort: { total_servicios: -1 }
    }
  ]).toArray()
);