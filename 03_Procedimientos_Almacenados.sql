USE CineMax_CESDE;
GO

CREATE PROCEDURE sp_ProcesarCompra
    @FK_Usuario INT,
    @metodoPago VARCHAR(50),
    @FK_Funcion INT,
    @FK_Asiento INT,
    @totalCompra DECIMAL(18,2) OUTPUT
AS
BEGIN
    DECLARE @precioPelicula DECIMAL(18,2);
    DECLARE @PK_Venta INT;
    DECLARE @PK_Pago INT;

    SELECT @precioPelicula = P.precio 
    FROM tblFunciones F
    INNER JOIN tblPeliculas P ON F.FK_Pelicula = P.PK_Pelicula
    WHERE F.PK_Funcion = @FK_Funcion;

    INSERT INTO tblPagos (metodo, estado, montoTotal)
    VALUES (@metodoPago, 'Aprobado', @precioPelicula);
    
    SET @PK_Pago = SCOPE_IDENTITY();

    INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta)
    VALUES (@FK_Usuario, @PK_Pago, GETDATE(), @precioPelicula);
    
    SET @PK_Venta = SCOPE_IDENTITY();

    INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal)
    VALUES (@PK_Venta, @FK_Funcion, @FK_Asiento, @precioPelicula);

    SET @totalCompra = @precioPelicula;
END;
GO

CREATE PROCEDURE sp_RegistrarUsuario
    @nombre VARCHAR(100),
    @correo VARCHAR(80),
    @contrasena VARCHAR(255),
    @fechaNacimiento DATE,
    @FK_Genero CHAR(1),
    @nuevo_PK_Usuario INT OUTPUT
AS
BEGIN
    INSERT INTO tblUsuarios (nombreCompleto, correo, contrasena, fechaNacimiento, FK_Genero)
    VALUES (@nombre, @correo, @contrasena, @fechaNacimiento, @FK_Genero);
    
    SET @nuevo_PK_Usuario = SCOPE_IDENTITY();
END;
GO

CREATE PROCEDURE sp_ActualizarPrecioPelicula
    @PK_Pelicula VARCHAR(20),
    @nuevoPrecio DECIMAL(18,2),
    @filasAfectadas INT OUTPUT
AS
BEGIN
    UPDATE tblPeliculas
    SET precio = @nuevoPrecio
    WHERE PK_Pelicula = @PK_Pelicula;
    
    SET @filasAfectadas = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE sp_CalcularTaquillaPorPelicula
    @PK_Pelicula VARCHAR(20),
    @totalRecaudado DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @totalRecaudado = SUM(DT.subtotal)
    FROM tblDetalleTickets DT
    INNER JOIN tblFunciones F ON DT.FK_Funcion = F.PK_Funcion
    WHERE F.FK_Pelicula = @PK_Pelicula;
    
    IF @totalRecaudado IS NULL
        SET @totalRecaudado = 0;
END;
GO

CREATE PROCEDURE sp_RegistrarConfiteriaVenta
    @FK_Venta INT,
    @FK_Producto VARCHAR(20),
    @cantidad SMALLINT,
    @subtotal DECIMAL(18,2) OUTPUT
AS
BEGIN
    DECLARE @precioProducto DECIMAL(18,2);
    
    SELECT @precioProducto = precio 
    FROM tblConfiteria 
    WHERE PK_Producto = @FK_Producto;

    SET @subtotal = @precioProducto * @cantidad;

    INSERT INTO tblDetalleConfiteria (FK_Venta, FK_Producto, cantidad, subtotal)
    VALUES (@FK_Venta, @FK_Producto, @cantidad, @subtotal);
END;
GO
