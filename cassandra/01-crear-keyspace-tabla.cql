-- 1. Crear el Keyspace para entorno de nodo único
CREATE KEYSPACE IF NOT EXISTS campuscloud_eventos
WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};

USE campuscloud_eventos;

-- 2. Crear tabla orientada a consultar actividad por estudiante y periodo
CREATE TABLE IF NOT EXISTS eventos_estudiante (
  estudiante_id text,
  fecha_evento timestamp,
  evento_id uuid,
  servicio_sql_id int,
  tipo_accion text,
  detalle text,
  dispositivo text,
  PRIMARY KEY ((estudiante_id), fecha_evento, evento_id)
) WITH CLUSTERING ORDER BY (fecha_evento DESC, evento_id ASC);