// Importar express que se instalo previamente
import express from 'express';
// Importar el royuter salud
import saludRouter from './routes/salud.routes.js';

// Crear una instancia de express, a partir de este objeto se podran
// configurar rutas, middlewares, etc.
const app = express();

// Agrega un middleware que permite interpretar cuerpos JSON de las peticiones HTTP
app.use(express.json());

// Registrar la ruta
app.use(saludRouter);

export default app;