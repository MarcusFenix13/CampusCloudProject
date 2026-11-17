import {MongoClient} from 'mongodb';
import {env} from './env.js';

// Construccion de la cadena de conexion a MongoDB
const usuario = encodeURIComponent(env.mongo.user); //El metodo encodeURIComponent() se utiliza para entender caracteres especiales en la cadena de conexion.
const password = encodeURIComponent(env.mongo.password);
const uri = `mongodb://${usuario}:${password}@${env.mongo.host}:${env.mongo.port}/?authSource=${encodeURIComponent(env.mongo.authsource)}`;
// const uri = `mongodb://${usuario}:${password}@${env.mongo.host}:${env.mongo.port}/${env.mongo.database}?authSource=${encodeURIComponent(env.mongo.authsource)}`;

// Creamos un cliente reutilizable de MongoDB
const client = new MongoClient(uri, {
    serverSelectionTimeoutMS: 5000
});

let database = null;

// Establecer la conexión a la base de datos
export async function conectarMongoDB() {
    await client.connect();
    database = client.db(env.mongo.database);
    // Comprobar que mongoDB responde correctamente
    await database.command({ ping: 1 });
    console.log(`Conexión exitosa a MongoDB en ${env.mongo.host}`);
    return database;
}

// Metodo que recupere la base de datos conectada
export function obtenerMongoDB() {
    if(!database) {
        throw new Error('MongoDB database no está conectado.');
    }
    return database;
}

// Cerrar la conexión a la base de datos
export async function cerrarMongoDB() {
    await client.close();
    database = null;
}


