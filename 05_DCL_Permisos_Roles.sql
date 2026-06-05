USE CineMax_CESDE;
GO

-- creacion del rol para la aplicacion
CREATE ROLE AppCineMaxRole;
GO

-- permisos sobre tablas transaccionales
GRANT SELECT, INSERT, UPDATE, DELETE ON tblVentas TO AppCineMaxRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDetalleTickets TO AppCineMaxRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDetalleConfiteria TO AppCineMaxRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPagos TO AppCineMaxRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblUsuarios TO AppCineMaxRole;

-- permisos de solo lectura sobre tablas de catalogo
GRANT SELECT ON tblPeliculas TO AppCineMaxRole;
GRANT SELECT ON tblFunciones TO AppCineMaxRole;
GRANT SELECT ON tblSalas TO AppCineMaxRole;
GRANT SELECT ON tblAsientos TO AppCineMaxRole;
GRANT SELECT ON tblTiposSala TO AppCineMaxRole;
GRANT SELECT ON tblGeneros TO AppCineMaxRole;
GRANT SELECT ON tblConfiteria TO AppCineMaxRole;

-- permisos de ejecucion sobre los procedimientos
GRANT EXECUTE ON OBJECT::sp_ProcesarCompra TO AppCineMaxRole;
GRANT EXECUTE ON OBJECT::sp_RegistrarUsuario TO AppCineMaxRole;
GRANT EXECUTE ON OBJECT::sp_ActualizarPrecioPelicula TO AppCineMaxRole;
GRANT EXECUTE ON OBJECT::sp_CalcularTaquillaPorPelicula TO AppCineMaxRole;
GRANT EXECUTE ON OBJECT::sp_RegistrarConfiteriaVenta TO AppCineMaxRole;
GO
