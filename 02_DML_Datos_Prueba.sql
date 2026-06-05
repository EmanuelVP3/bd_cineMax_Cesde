USE CineMax_CESDE;
GO

-- insertando datos de catalogo
INSERT INTO tblGeneros (PK_Genero, descripcion) VALUES ('M', 'Masculino'), ('F', 'Femenino'), ('O', 'Otro');
INSERT INTO tblTiposSala (descripcion, precioBase) VALUES ('2D Estándar', 15000), ('3D Experiencia', 20000), ('VIP Premium', 35000);
INSERT INTO tblSalas (nombre, FK_TipoSala, capacidad) VALUES ('Sala 1', 1, 50), ('Sala 2', 2, 40), ('Sala VIP', 3, 20);

INSERT INTO tblAsientos (FK_Sala, fila, numero) VALUES 
(1, 'A', 1), (1, 'A', 2), (1, 'A', 3), (1, 'A', 4),
(1, 'B', 1), (1, 'B', 2), (1, 'B', 3), (1, 'B', 4),
(2, 'A', 1), (2, 'A', 2), (2, 'B', 1), (2, 'B', 2),
(3, 'V', 1), (3, 'V', 2);

INSERT INTO tblPeliculas (PK_Pelicula, titulo, clasificacion, precio) VALUES 
('PEL-001', 'Dune: Parte 2', 'Adultos', 22000),
('PEL-002', 'Godzilla vs. Kong', 'General', 22000),
('PEL-003', 'Inside Out 2', 'Niños', 15000),
('PEL-004', 'Oppenheimer', 'Adultos', 19000),
('PEL-005', 'Deadpool & Wolverine', 'Adultos', 20000);

INSERT INTO tblFunciones (FK_Pelicula, FK_Sala, fechaHora) VALUES 
('PEL-001', 1, '2026-06-10 18:00:00'),
('PEL-003', 2, '2026-06-10 14:00:00'),
('PEL-005', 3, '2026-06-10 20:30:00');

INSERT INTO tblConfiteria (PK_Producto, nombre, precio) VALUES 
('CONF-01', 'Combo Pareja', 35000),
('CONF-02', 'Palomitas Medianas', 12000),
('CONF-03', 'Gaseosa Pequeña', 6000),
('CONF-04', 'Chocolatina', 4500);

-- insertando usuarios
INSERT INTO tblUsuarios (nombreCompleto, correo, contrasena, fechaNacimiento, FK_Genero) VALUES 
('Juan Perez', 'juan.perez@cesde.net', '12345', '1995-05-10', 'M'),
('Maria Gomez', 'maria.gomez@cesde.net', 'abcde', '2001-08-22', 'F'),
('Carlos Ruiz', 'carlos.ruiz@cesde.net', '12345', '1988-11-05', 'M'),
('Ana Martinez', 'ana.martinez@cesde.net', '12345', '1998-02-14', 'F'),
('Luis Torres', 'luis.torres@cesde.net', 'abcde', '2000-12-01', 'M'),
('Jorge Sanchez', 'jorge@cesde.net', 'pass1', '1990-03-12', 'M'),
('Lucia Fernandez', 'lucia@cesde.net', 'pass2', '1995-07-22', 'F'),
('Pedro Morales', 'pedro@cesde.net', 'pass3', '2001-11-05', 'M'),
('Marta Gomez', 'marta@cesde.net', 'pass4', '1988-01-30', 'F'),
('Diego Ramirez', 'diego@cesde.net', 'pass5', '1999-09-15', 'M'),
('Sofia Castro', 'sofia@cesde.net', 'pass6', '2002-04-18', 'F'),
('Miguel Rojas', 'miguel@cesde.net', 'pass7', '1993-08-25', 'M'),
('Paula Vargas', 'paula@cesde.net', 'pass8', '1997-12-10', 'F'),
('Andres Silva', 'andres.s@cesde.net', 'pass9', '1991-05-05', 'M'),
('Carolina Herrera', 'carolina@cesde.net', 'pass10', '1996-10-20', 'F');
GO

-- probando transacciones y registros
DECLARE @Pago INT, @Venta INT;

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Credito', 'Aprobado', 79000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (1, @Pago, GETDATE(), 79000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 1, 1, 22000), (@Venta, 1, 2, 22000);
INSERT INTO tblDetalleConfiteria (FK_Venta, FK_Producto, cantidad, subtotal) VALUES (@Venta, 'CONF-01', 1, 35000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Nequi', 'Aprobado', 15000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (2, @Pago, GETDATE(), 15000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 2, 9, 15000); 

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Efectivo', 'Aprobado', 70000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (3, @Pago, GETDATE(), 70000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 3, 13, 35000), (@Venta, 3, 14, 35000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Debito', 'Aprobado', 16500);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (4, @Pago, GETDATE(), 16500);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleConfiteria (FK_Venta, FK_Producto, cantidad, subtotal) VALUES (@Venta, 'CONF-02', 1, 12000), (@Venta, 'CONF-04', 1, 4500);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Nequi', 'Aprobado', 22000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (5, @Pago, GETDATE(), 22000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 1, 3, 22000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Credito', 'Aprobado', 15000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (6, @Pago, GETDATE(), 15000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 2, 10, 15000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Efectivo', 'Aprobado', 20000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (7, @Pago, GETDATE(), 20000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 3, 11, 20000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Debito', 'Aprobado', 22000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (8, @Pago, GETDATE(), 22000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 1, 4, 22000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Nequi', 'Aprobado', 15000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (9, @Pago, GETDATE(), 15000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 2, 11, 15000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Credito', 'Aprobado', 20000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (10, @Pago, GETDATE(), 20000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 3, 12, 20000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Efectivo', 'Aprobado', 22000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (11, @Pago, GETDATE(), 22000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 1, 5, 22000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Nequi', 'Aprobado', 15000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (12, @Pago, GETDATE(), 15000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 2, 12, 15000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Debito', 'Aprobado', 20000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (13, @Pago, GETDATE(), 20000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 3, 13, 20000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Tarjeta Credito', 'Aprobado', 22000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (14, @Pago, GETDATE(), 22000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 1, 6, 22000);

INSERT INTO tblPagos (metodo, estado, montoTotal) VALUES ('Efectivo', 'Aprobado', 15000);
SET @Pago = SCOPE_IDENTITY();
INSERT INTO tblVentas (FK_Usuario, FK_Pago, fechaVenta, totalVenta) VALUES (15, @Pago, GETDATE(), 15000);
SET @Venta = SCOPE_IDENTITY();
INSERT INTO tblDetalleTickets (FK_Venta, FK_Funcion, FK_Asiento, subtotal) VALUES (@Venta, 2, 13, 15000);
GO

-- actualizando precio
UPDATE tblConfiteria SET precio = 38000 WHERE PK_Producto = 'CONF-01';

-- borrando asiento
DELETE FROM tblAsientos WHERE FK_Sala = 1 AND fila = 'B' AND numero = 4;
GO
