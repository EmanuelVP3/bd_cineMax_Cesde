USE master;
GO

CREATE DATABASE CineMax_CESDE;
GO

USE CineMax_CESDE;
GO

-- creacion de tablas principales
CREATE TABLE tblGeneros (
    PK_Genero CHAR(1) PRIMARY KEY,
    descripcion VARCHAR(20) NOT NULL
);

CREATE TABLE tblUsuarios (
    PK_Usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombreCompleto VARCHAR(100) NOT NULL,
    correo VARCHAR(80) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fechaNacimiento DATE,
    FK_Genero CHAR(1),
    CONSTRAINT FK_tblUsuarios_tblGeneros FOREIGN KEY (FK_Genero) REFERENCES tblGeneros(PK_Genero)
);

CREATE TABLE tblTiposSala (
    PK_TipoSala INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL,
    precioBase DECIMAL(18,2) NOT NULL CHECK (precioBase >= 0)
);

CREATE TABLE tblSalas (
    PK_Sala INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    FK_TipoSala INT,
    capacidad INT NOT NULL CHECK (capacidad > 0),
    CONSTRAINT FK_tblSalas_tblTiposSala FOREIGN KEY (FK_TipoSala) REFERENCES tblTiposSala(PK_TipoSala)
);

CREATE TABLE tblAsientos (
    PK_Asiento INT IDENTITY(1,1) PRIMARY KEY,
    FK_Sala INT,
    fila CHAR(1) NOT NULL,
    numero INT NOT NULL,
    CONSTRAINT FK_tblAsientos_tblSalas FOREIGN KEY (FK_Sala) REFERENCES tblSalas(PK_Sala)
);

CREATE TABLE tblPeliculas (
    PK_Pelicula VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    clasificacion VARCHAR(20) NOT NULL,
    precio DECIMAL(18,2) NOT NULL CHECK (precio >= 0)
);

CREATE TABLE tblFunciones (
    PK_Funcion INT IDENTITY(1,1) PRIMARY KEY,
    FK_Pelicula VARCHAR(20),
    FK_Sala INT,
    fechaHora DATETIME NOT NULL,
    CONSTRAINT FK_tblFunciones_tblPeliculas FOREIGN KEY (FK_Pelicula) REFERENCES tblPeliculas(PK_Pelicula),
    CONSTRAINT FK_tblFunciones_tblSalas FOREIGN KEY (FK_Sala) REFERENCES tblSalas(PK_Sala)
);

CREATE TABLE tblConfiteria (
    PK_Producto VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(18,2) NOT NULL CHECK (precio >= 0)
);

-- tablas de pagos y ventas
CREATE TABLE tblPagos (
    PK_Pago INT IDENTITY(1,1) PRIMARY KEY,
    metodo VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    montoTotal DECIMAL(18,2) NOT NULL
);

CREATE TABLE tblVentas (
    PK_Venta INT IDENTITY(1,1) PRIMARY KEY,
    FK_Usuario INT,
    FK_Pago INT,
    fechaVenta DATETIME NOT NULL DEFAULT GETDATE(),
    totalVenta DECIMAL(18,2),
    CONSTRAINT FK_tblVentas_tblUsuarios FOREIGN KEY (FK_Usuario) REFERENCES tblUsuarios(PK_Usuario),
    CONSTRAINT FK_tblVentas_tblPagos FOREIGN KEY (FK_Pago) REFERENCES tblPagos(PK_Pago)
);

-- tablas detalle
CREATE TABLE tblDetalleTickets (
    PK_DetalleTicket INT IDENTITY(1,1) PRIMARY KEY,
    FK_Venta INT,
    FK_Funcion INT,
    FK_Asiento INT,
    subtotal DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_tblDetalleTickets_tblVentas FOREIGN KEY (FK_Venta) REFERENCES tblVentas(PK_Venta),
    CONSTRAINT FK_tblDetalleTickets_tblFunciones FOREIGN KEY (FK_Funcion) REFERENCES tblFunciones(PK_Funcion),
    CONSTRAINT FK_tblDetalleTickets_tblAsientos FOREIGN KEY (FK_Asiento) REFERENCES tblAsientos(PK_Asiento)
);

CREATE TABLE tblDetalleConfiteria (
    PK_DetalleConfiteria INT IDENTITY(1,1) PRIMARY KEY,
    FK_Venta INT,
    FK_Producto VARCHAR(20),
    cantidad SMALLINT NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_tblDetalleConfiteria_tblVentas FOREIGN KEY (FK_Venta) REFERENCES tblVentas(PK_Venta),
    CONSTRAINT FK_tblDetalleConfiteria_tblConfiteria FOREIGN KEY (FK_Producto) REFERENCES tblConfiteria(PK_Producto)
);
GO

-- modificacion de tabla
ALTER TABLE tblUsuarios ADD puntosFidelidad INT DEFAULT 0;
GO
