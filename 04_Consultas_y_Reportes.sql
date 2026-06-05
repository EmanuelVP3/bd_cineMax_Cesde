USE CineMax_CESDE;
GO

-- historial detallado de todas las ventas
SELECT 
    V.PK_Venta,
    U.nombreCompleto AS Cliente,
    P.titulo AS Pelicula,
    S.nombre AS Sala,
    CONCAT('Fila ', A.fila, ' - Asiento ', A.numero) AS Silla,
    CAST(DT.subtotal AS INT) AS Pagado,
    PG.metodo AS MetodoPago
FROM tblVentas V
INNER JOIN tblUsuarios U ON V.FK_Usuario = U.PK_Usuario
INNER JOIN tblPagos PG ON V.FK_Pago = PG.PK_Pago
INNER JOIN tblDetalleTickets DT ON V.PK_Venta = DT.FK_Venta
INNER JOIN tblFunciones F ON DT.FK_Funcion = F.PK_Funcion
INNER JOIN tblPeliculas P ON F.FK_Pelicula = P.PK_Pelicula
INNER JOIN tblSalas S ON F.FK_Sala = S.PK_Sala
INNER JOIN tblAsientos A ON DT.FK_Asiento = A.PK_Asiento;

-- total recaudado
SELECT 
    COUNT(PK_Venta) AS TotalFacturasEmitidas,
    CAST(SUM(totalVenta) AS INT) AS DineroTotalRecaudado,
    CAST(AVG(totalVenta) AS INT) AS PromedioPorFactura
FROM tblVentas;

-- boletas vendidas por pelicula
SELECT 
    P.titulo AS Pelicula,
    COUNT(DT.PK_DetalleTicket) AS BoletasVendidas,
    CAST(SUM(DT.subtotal) AS INT) AS DineroGenerado
FROM tblDetalleTickets DT
INNER JOIN tblFunciones F ON DT.FK_Funcion = F.PK_Funcion
INNER JOIN tblPeliculas P ON F.FK_Pelicula = P.PK_Pelicula
GROUP BY P.titulo
ORDER BY BoletasVendidas DESC;

-- peliculas con mas de 30mil
SELECT 
    P.titulo AS Pelicula,
    CAST(SUM(DT.subtotal) AS INT) AS TotalTaquilla
FROM tblDetalleTickets DT
INNER JOIN tblFunciones F ON DT.FK_Funcion = F.PK_Funcion
INNER JOIN tblPeliculas P ON F.FK_Pelicula = P.PK_Pelicula
GROUP BY P.titulo
HAVING SUM(DT.subtotal) > 30000;
GO
