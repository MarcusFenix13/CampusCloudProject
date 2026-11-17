export const obtenerSalud = (req, res) => {
    res.status(200).json({
        estado: "OK",
        aplicacion: "CampusCloud API",
        mensaje: "El Server está funcionando correctamente"
    });
}    