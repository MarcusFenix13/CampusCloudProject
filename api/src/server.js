import app from './app.js';
import {env} from './config/env.js';


const PORT = env.port;

app.listen(PORT, () => {
    console.log(`CampusCloud API escuchando en http://localhost:${PORT}`)
});