use('CampusCloud');

db.detalles_servicios.insertMany([
  {
    servicio_sql_id: 101,
    nombre: "Laboratorio de Redes Cisco",
    categoria: "Laboratorio",
    disponible: true,
    etiquetas: ["redes", "cisco", "switching", "routing"],
    ubicacion: {
      edificio: "Edificio Docencia 2",
      planta: "Alta",
      aula: "L-204"
    },
    equipamiento: {
      routers: 8,
      switches: 12,
      capacidad_alumnos: 25
    }
  },
  {
    servicio_sql_id: 102,
    nombre: "Laboratorio de Desarrollo Cloud",
    categoria: "Laboratorio",
    disponible: true,
    etiquetas: ["docker", "linux", "backend", "bases de datos"],
    ubicacion: {
      edificio: "Edificio TIC",
      planta: "Baja",
      aula: "L-101"
    },
    software_instalado: ["Docker Desktop", "VS Code", "PostgreSQL", "MongoDB Compass"]
  },
  {
    servicio_sql_id: 103,
    nombre: "Asesoría de Arquitectura de Software",
    categoria: "Asesoría",
    disponible: true,
    etiquetas: ["arquitectura", "sql", "nosql", "patrones"],
    modalidad: ["Presencial", "Teams"],
    ubicacion: {
      edificio: "Edificio TIC",
      cubiculo: "C-05"
    },
    horarios_disponibles: [
      { dia: "Lunes", hora: "10:00 - 12:00" },
      { dia: "Miércoles", hora: "14:00 - 16:00" }
    ]
  },
  {
    servicio_sql_id: 104,
    nombre: "Asesoría de Cálculo y Estadística",
    categoria: "Asesoría",
    disponible: false,
    etiquetas: ["matematicas", "calculo", "probabilidad"],
    modalidad: ["Presencial"],
    ubicacion: {
      edificio: "Biblioteca Central",
      cubiculo: "Sala Estudio 2"
    }
  },
  {
    servicio_sql_id: 105,
    nombre: "Kit de Robótica Arduino Mega",
    categoria: "Préstamo de Equipo",
    disponible: true,
    etiquetas: ["iot", "arduino", "sensores", "hardware"],
    especificaciones: {
      microcontrolador: "ATmega2560",
      incluye_bateria: true,
      piezas: 35
    },
    ubicacion: {
      edificio: "Almacén TIC",
      estante: "E-12"
    }
  },
  {
    servicio_sql_id: 106,
    nombre: "Laptop Workstation para Render y Virtualización",
    categoria: "Préstamo de Equipo",
    disponible: true,
    etiquetas: ["laptop", "virtualizacion", "ram32gb"],
    especificaciones: {
      procesador: "Ryzen 7",
      ram_gb: 32,
      almacenamiento: "1TB NVMe"
    },
    ubicacion: {
      edificio: "Almacén TIC",
      estante: "Bóveda 1"
    }
  }
]);

print("6 documentos insertados correctamente.");