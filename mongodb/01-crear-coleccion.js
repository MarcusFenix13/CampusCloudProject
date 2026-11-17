// Seleccionar o crear la base de datos
use('CampusCloud');

// Crear la colección para detalles variables de los servicios
db.createCollection('detalles_servicios', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['servicio_sql_id', 'nombre', 'categoria'],
      properties: {
        servicio_sql_id: {
          bsonType: 'int',
          description: 'ID de referencia en la tabla Servicios de SQL Server'
        },
        nombre: {
          bsonType: 'string'
        },
        categoria: {
          bsonType: 'string'
        }
      }
    }
  }
});

// Índice único para evitar duplicar la ficha extendida de un mismo servicio de SQL
db.detalles_servicios.createIndex({ servicio_sql_id: 1 }, { unique: true });

print("Colección detalles_servicios creada exitosamente.");