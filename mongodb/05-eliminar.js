use('CampusCloud');

// 1. Verificar el documento antes de eliminar
print("--- Documento a eliminar ---");
printjson(db.detalles_servicios.findOne({ servicio_sql_id: 104 }));

// 2. Eliminación directa por su identificador de servicio
print("--- Resultado de eliminación ---");
printjson(db.detalles_servicios.deleteOne({ servicio_sql_id: 104 }));

// 3. Verificar conteo restante (deben quedar 5 documentos)
print("Total de documentos restantes: " + db.detalles_servicios.countDocuments());