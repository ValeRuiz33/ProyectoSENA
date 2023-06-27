Create database SenaProyecto
go 

Use SenaProyecto
Go

Create table Cliente(
	NumeroDocumento int primary key, 
	TipoDocumento nvarchar (50)not null, 
	Nombre nvarchar (50)not null,
	Apellido nvarchar(50) not null,
	Correo nvarchar(50) not null, 
	Telefono nvarchar(50) not null,
	
)

 Create table Usuario(
	IdUsuario int primary key, 
	TipoUsuario nvarchar (50)not null, 
	NombreUsuario nvarchar (50)not null,
	Contraseña nvarchar (50)not null, 
	Nombre nvarchar(50) not null,
	Apellido nvarchar(50) not null, 
	Contacto nvarchar(50) not null, 
	Dirección nvarchar(50) not null,
	NumeroDocumento int not null,
	Foreign key (NumeroDocumento) References Cliente(NumeroDocumento) 
)

Create table Factura(
	IdFactura int primary key, 
	Fecha datetime not null, 
	NumeroDocumento int not null,
	Foreign key (NumeroDocumento) References Cliente(NumeroDocumento)
)

Create table MetodoPago(
	IdMetodoPago int primary key, 
	Fechapago datetime not null, 
	IdFactura int not null,
	Foreign key (IdFactura) References Factura(IdFactura)
	
)

Create table EntidadBancaria(
	IdEnBancaria int primary key, 
	Nombre nvarchar(50)not null, 
	Monto float not null, 
	IdMetodoPago int not null,
	foreign key (IdMetodoPago) References MetodoPago(IdMetodoPago)
)

 Create table Efectivo(
	ValorPago int primary key,
	IdMetodoPago int not null,
	Foreign key (IdMetodoPago) References MetodoPago(IdMetodoPago)
)

Create table DetalleFactura(
	IdDetalle int primary key, 
	IdProducto int not null, 
	Producto nvarchar (50) not null, 
	Cantidad int not null, 
	PrecioUnt float (50)not null, 
	Iva float (50) not null,  
	Subtotal float (50)not null, 
	Total float (50)not null, 
	IdFactura int not null,
	Foreign key (IdFactura) References Factura(IdFactura)
)

Create table Factura_Proveedor (
    ID_Factura int primary key,
    Fecha date

)

Create table Categoria (
    ID_Categoria int primary key,
    Nombre_Categoria nvarchar(50)
)

Create table Factura_DetalleProveedor (
    ID_Detalle int primary key,
    Cantidad int,
    Precio float not null,
    Iva float not null,
    SubTotal float not null,
    Total float not null,
    ID_Factura int,
	Foreign key (ID_Factura) References Factura_Proveedor(ID_Factura)
)

Create table Productos (
    ID_Productos int primary key,
    Nombre nvarchar(50),
    Cantidad int,
    Precio float not null,
    Estado nvarchar(50),
    Lugar nvarchar(50),
    ID_Categoria int,
	ID_Detalle int, 
	IdDetalle int,
	Foreign key (ID_Categoria) References Categoria(ID_Categoria),
	Foreign key (ID_Detalle) References Factura_DetalleProveedor(ID_Detalle),
	Foreign key (IdDetalle) References DetalleFactura(IdDetalle)
)

Create table Stock (
    ID_Stock int primary key,
    Cantidad_Real int,
    Cantidad_Ideal int,
    Cantidad_Minima int,
    Cantidad_Alarma int,
    Fecha_Ingreso date,
    ID_Productos int,
	Foreign key (ID_Productos) References Productos(ID_Productos)
)

Create table Proveedor (
    ID_Proveedor int primary key,
    Nombre nvarchar(50),
    Apellido nvarchar(50),
    Correo nvarchar(50),
    Contacto nvarchar(50),
    Direccion nvarchar(100),
	Id_Factura int,
	Foreign key (ID_Factura) References Factura_Proveedor(ID_Factura)
)

Create table Precio (
    ID_Productos int primary key,
    Precio_Compra float not null,
    Precio_Venta float not null,
    Precio_Descuento float not null,
    Fecha_Descuento date,
    Estado nvarchar(50),
	Foreign key (ID_Productos) References Productos(ID_Productos)
)




-- CRUD
--Table Cliente 
--Registros
Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
values (12345, 'CC', 'Pepito', 'Perez', 'Pepito1@gmail.com', 3216788485);

Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
values (67890, 'CC', 'Maria', 'Sanchez', 'Maria0z@gmail.com', 3210788481);

Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
values (54321, 'CC', 'Michael', 'Olaya', 'Michael0@gmail.com', 3116710445);

Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
values (98765, 'CC', 'Vanessa', 'Camacho', 'VanessaC@gmail.com', 3146788478);

Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
values (24680, 'CC', 'Luis', 'Torrez', 'Luisito7@gmail.com', 3046711054);

--PROCEDIMIENTOS ALMACENADOS CLIENTE
--Insertar
Create Procedure InsertarCliente
	@NumeroDocumento int, 
	@TipoDocumento nvarchar, 
	@Nombre nvarchar,
	@Apellido nvarchar, 
	@Correo nvarchar,
	@Telefono nvarchar
As
Begin
    Insert into Cliente(NumeroDocumento, TipoDocumento, Nombre, Apellido, Correo, Telefono)
    values (@NumeroDocumento, @TipoDocumento, @Nombre,@Apellido, @Correo, @Telefono)
End

--Consultar
Create Procedure ConsultarCliente
	@NumeroDocumento int
As
Begin 
     Select * From Cliente Where NumeroDocumento = @NumeroDocumento; 
End

--Modificar
Create Procedure ActualizarCliente
    @NumeroDocumento int, 
	@TipoDocumento nvarchar, 
	@Nombre nvarchar,
	@Apellido nvarchar, 
	@Correo nvarchar,
	@Telefono nvarchar
As
Begin
    Update Cliente
    Set NumeroDocumento = @NumeroDocumento, 
		TipoDocumento=@TipoDocumento, 
		Nombre=@Nombre,
		Apellido=@Apellido, 
		Correo=@Correo, 
		Telefono=@Telefono
    Where NumeroDocumento = @NumeroDocumento
End

-- Eliminar
Create Procedure EliminarCliente
    @NumeroDocumento int
As
Begin
    Delete from Cliente
    Where NumeroDocumento = @NumeroDocumento
End

--Vistas
Create view VCliente
As
Select * from Cliente 





--Table Usuario 
--Insertar 
Insert into Usuario(IdUsuario, TipoUsuario, NombreUsuario, Contraseña, Nombre, Apellido, Contacto, Dirección, NumeroDocumento)
values (1,'Cliente', 'Pepito23', Encryptbypassphrase('Pepito123', 'Contraseña1' ), 'Pepito', 'Perez', 3216788485, 'Calle 24 sur', 12345); 

Insert into Usuario(IdUsuario, TipoUsuario, NombreUsuario,Contraseña, Nombre, Apellido, Contacto, Dirección, NumeroDocumento)
values (2,'Cliente', 'MariaS', Encryptbypassphrase('Maria123', 'Contraseña2'), 'Maria', 'Sanchez', 3210788481, 'Calle 10 sur', 67890); 

Insert into Usuario(IdUsuario, TipoUsuario, NombreUsuario, Contraseña, Nombre, Apellido, Contacto, Dirección, NumeroDocumento)
values (3,'Cliente', 'Luisito33',  Encryptbypassphrase('Luisito123', 'Contraseña3'), 'Luis', 'Torrez', 3046711054, 'Calle 90 sur', 24680); 

Insert into Usuario(IdUsuario, TipoUsuario, NombreUsuario, Contraseña, Nombre, Apellido, Contacto, Dirección, NumeroDocumento)
values (4,'Cliente', 'MichaleO0', Encryptbypassphrase('Michael123', 'Contraseña4'), 'Michael', 'Olaya', 3116710445, 'Calle 56 sur', 54321); 

Insert into Usuario(IdUsuario, TipoUsuario, NombreUsuario, Contraseña, Nombre, Apellido, Contacto, Dirección, NumeroDocumento)
values (5,'Cliente', 'Vanessa21', Encryptbypassphrase('Vanesa123', 'Contraseña5'), 'Vanessa', 'Camacho', 3146788478, 'Calle 96 sur', 98765); 

----PROCEDIMIENTOS ALMACENADOS USUARIO
--Insertar
Alter Procedure InsertarUsuario
	@IdUsuario int, 
	@TipoUsuario nvarchar, 
	@NombreUsuario nvarchar,
	@Contraseña nvarchar,
	@Nombre nvarchar,
	@Apellido nvarchar, 
	@Contacto nvarchar, 
	@Dirección nvarchar,
	@NumeroDocumento int

As
Begin 
	Set @Contraseña= (Encryptbypassphrase(@Contraseña)); 
	Insert into usuario 
	(IdUsuario, TipoUsuario, NombreUsuario,Contraseña, Nombre,Apellido, Contacto, Dirección)
	values 
	(@IdUsuario, @TipoUsuario, @NombreUsuario, @Contraseña, @Nombre, @Apellido, @Contacto, @Dirección, @NumeroDocumento) 
End

--Modificar
Create Procedure ActualizarUsuario
    @IdUsuario int, 
	@TipoUsuario nvarchar, 
	@NombreUsuario nvarchar,
	@Contraseña nvarchar,
	@Nombre nvarchar,
	@Apellido nvarchar, 
	@Contacto nvarchar, 
	@Dirección nvarchar,
	@NumeroDocumento int
As
Begin
    Update Usuario
    Set IdUsuario = @IdUsuario, 
		TipoUsuario=@TipoUsuario, 
		NombreUsuario=@NombreUsuario,
		Contraseña=@Contraseña, 
		Nombre=@Nombre,
		Apellido=@Apellido, 
		Contacto=@Contacto, 
		Dirección=@Dirección,
		NumeroDocumento=@NumeroDocumento 
    Where IdUsuario = IdUsuario
End

-- Eliminar
Create Procedure EliminarUsuario
    @IdUsuario int
As
Begin
    Delete from Usuario
    Where IdUsuario = IdUsuario
End

--Vistas
Create view VUsuario
As
Select * from Usuario 






--Table Factura 
--Insertar 
Insert into Factura(IdFactura, Fecha, NumeroDocumento)
Values (1,'2023-06-14 10:00:00', 12345);

Insert into Factura(IdFactura, Fecha, NumeroDocumento)
Values (2,'2023-06-15 11:30:00', 67890);

Insert into Factura(IdFactura, Fecha, NumeroDocumento)
Values (3,'2023-06-16 15:45:00', 54321);

Insert into Factura(IdFactura, Fecha, NumeroDocumento)
Values (4,'2023-06-17 09:15:00', 98765);

Insert into Factura(IdFactura, Fecha, NumeroDocumento)
Values (5,'2023-06-18 14:20:00', 24680);

--PROCEDIMIENTOS ALMACENADOS FACTURA
--Insertar
Create Procedure RegistrarFactura
   @Fecha datetime,
   @NumeroDocumento int,
   @IdFactura int
As
Begin
   Insert into Factura ( Fecha, NumeroDocumento, IdFactura)
   values (@Fecha, @NumeroDocumento, @IdFactura)
End

--Consultar
Create Procedure ConsultarFactura
   @IdFactura int
As
Begin
   Select * from Factura
   Where IdFactura = @IdFactura
End

--ACTUALIZAR
Create Procedure ActualizarFactura
   @IdFactura int,
   @Fecha datetime,
   @NumeroDocumento int
As
Begin
   Update Factura
   Set Fecha = @Fecha, NumeroDocumento = @NumeroDocumento
   Where IdFactura = @IdFactura
End

--ELIMINAR
Create Procedure EliminarFactura
   @IdFactura int
As
Begin
   Delete from Factura
   Where IdFactura = @IdFactura
End

--Vistas
Create view VFactura
As
Select * from Factura 



--Table MetodoPago
--Insertar 
Insert into MetodoPago(IdMetodoPago, Fechapago,IdFactura)
Values(1,'2023-05-23' , 1);

Insert into MetodoPago(IdMetodoPago, Fechapago,IdFactura)
Values(2,'2023-06-20' , 2);

Insert into MetodoPago(IdMetodoPago, Fechapago,IdFactura)
Values(3,'2023-05-2' , 3);

Insert into MetodoPago(IdMetodoPago, Fechapago,IdFactura)
Values(4,'2023-06-3' , 4);

Insert into MetodoPago(IdMetodoPago, Fechapago,IdFactura)
Values(5,'2023-06-10' , 5);

--PROCEDIMIENTOS ALMACENADOS METODOPAGO
--Insertar
Create Procedure RegistrarMetodoPago
    @IdMetodoPago int,
    @FechaPago datetime,
	@IdFactura int
As
Begin
    Insert into MetodoPago(IdMetodoPago, FechaPago, IdFactura)
    values (@IdMetodoPago, @FechaPago, @IdFactura)
End

--Consultar
Create Procedure ConsultarMetodoPago
As
Begin
    Select * from MetodoPago
End

--Modificar
Create Procedure ActualizarMetodoPago
   @IdMetodoPago int,
   @FechaPago date,
   @IdFactura int
As
Begin
   Update MetodoPago
   Set @FechaPago = @FechaPago, @IdFactura = @IdFactura
   Where @IdMetodoPago = @IdMetodoPago
End

--Eliminar
Create Procedure EliminarMetodoPago
   @IdMetodoPago int
As
Begin
   Delete from MetodoPago
   Where @IdMetodoPago = @IdMetodoPago
End

--Vistas
Create view VMetodoPago
As
Select * from MetodoPago 


--Table EntidadBancaria 
--Insertar 
Insert into EntidadBancaria(IdEnBancaria, Nombre, Monto, IdMetodoPago)
Values (1,'BancoCajaSocial', 150000, 1);

Insert into EntidadBancaria(IdEnBancaria, Nombre, Monto, IdMetodoPago)
Values (2,'Bancolombia', 3000000, 2);

Insert into EntidadBancaria(IdEnBancaria, Nombre, Monto, IdMetodoPago)
Values (3,'nequi', 150000, 3);

Insert into EntidadBancaria(IdEnBancaria, Nombre, Monto, IdMetodoPago)
Values (4,'BancoCajaSocial', 4000000, 4); 

Insert into EntidadBancaria(IdEnBancaria, Nombre, Monto, IdMetodoPago)
Values (5,'Bancolombia', 150000, 5);

--PROCEDIMIENTOS ALMACENADOS ENTIDAD BANCARIA
--Insertar
Create Procedure RegistrarEntidadBancaria
   @Nombre nvarchar,
   @Monto float,
   @IdMetodoPago int
As
Begin
   Insert into EntidadBancaria (Nombre, Monto, IdMetodoPago)
   values (@Nombre, @Monto, @IdMetodoPago)
End

--Consultar
Create Procedure ConsultarEntidadBancaria
   @IdEnBancaria int
As
Begin
   Select * From EntidadBancaria
   Where IdEnBancaria = @IdEnBancaria
End

--Modificar
Create Procedure ActualizarEntidadBancaria
   @IdEnBancaria int,
   @Nombre nvarchar,
   @Monto float,
   @IdMetodoPago int
As
Begin
   Update EntidadBancaria
   Set Nombre = @Nombre, Monto = @Monto, IdMetodoPago = @IdMetodoPago
   Where IdEnBancaria = @IdEnBancaria
End

--Eliminar
Create Procedure EliminarEntidadBancaria
   @IdEnBancaria int
As
Begin
   Delete from EntidadBancaria
   Where IdEnBancaria = @IdEnBancaria
End

--Vistas
Create view VEntidadBancaria
As
Select * from EntidadBancaria 



--Table Efectivo 
--Insertar 
Insert into Efectivo(ValorPago,IdMetodoPago)
Values(150000,1);

Insert into Efectivo(ValorPago,IdMetodoPago)
Values(200000,2);

Insert into Efectivo(ValorPago,IdMetodoPago)
Values(23900,3);

Insert into Efectivo(ValorPago,IdMetodoPago)
Values(23740,4);

Insert into Efectivo(ValorPago,IdMetodoPago)
Values(44940,5);

--PROCEDIMIENTOS ALMACENADOS EFECTIVO
--Insertar 
Create Procedure RegistrarPagoEfectivo
    @ValorPago int,
    @IdMetodoPago int
As
Begin
    Insert into  Efectivo (ValorPago, IdMetodoPago)
    values (@ValorPago, @IdMetodoPago)
End

--Consultar
Create Procedure ConsultarPagosEfectivo
As
Begin
    Select * from Efectivo
End

--Modificar
Create Procedure ActualizarPagoEfectivo
    @ValorPago int,
    @IdMetodoPago int
As
Begin
    Update Efectivo
    Set IdMetodoPago = @IdMetodoPago
    Where ValorPago = @ValorPago
End

--Eliminar
Create Procedure EliminarPagoEfectivo
    @ValorPago int
As
Begin
    Delete from Efectivo
    Where ValorPago = @ValorPago
End

--Vistas
Create view VEfectivo
As
Select * from Efectivo 


--Table DetalleFactura 
--Insertar
Insert into DetalleFactura(IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
values (1,1, 'Computador Samsung 2018', 2, 2600000, 0.019, 5200000, 5298800, 1); 

Insert into DetalleFactura(IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
values (2,2, 'Audifonos inalambricos', 2, 250000, 0.019, 500000, 509500, 2); 

Insert into DetalleFactura(IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
values (3,3, 'Mouse inalambrico', 4, 50000, 0.019, 200000, 203800, 3); 

Insert into DetalleFactura(IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
values (4,4, 'Celular Samsung Galaxy A21S', 1, 700000, 0.019, 700000, 713300, 4); 

Insert into DetalleFactura(IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
values (5,5, 'Pantalla 14" Dell', 3, 150000, 0.019, 450000, 458550, 5); 

--PROCEDIMIENTOS ALMACENADOS DETALLEFACTURA
--Insertar
Create Procedure RegistrarDetalleFactura
    @IdDetalle int,
    @IdProducto int,
    @Producto nvarchar(50),
    @Cantidad int,
    @PrecioUnt float,
    @Iva float,
    @Subtotal float,
    @Total float,
    @IdFactura int
As
Begin
    Insert into DetalleFactura (IdDetalle, IdProducto, Producto, Cantidad, PrecioUnt, Iva, Subtotal, Total, IdFactura)
    values (@IdDetalle, @IdProducto, @Producto, @Cantidad, @PrecioUnt, @Iva, @Subtotal, @Total, @IdFactura)
End

--Consultar
Create Procedure ConsultarDetallesFactura
    @IdDetalle int
As
Begin
    Select * from DetalleFactura
	Where IdDetalle= @IdDetalle
End

--Modificar
Create Procedure ActualizarDetalleFactura
    @IdDetalle int,
    @IdProducto int,
    @Producto nvarchar(50),
    @Cantidad int,
    @PrecioUnt float,
    @Iva float,
    @Subtotal float,
    @Total float,
    @IdFactura int
As
Begin
    Update DetalleFactura
    Set IdProducto = @IdProducto,
        Producto = @Producto,
        Cantidad = @Cantidad,
        PrecioUnt = @PrecioUnt,
        Iva = @Iva,
        Subtotal = @Subtotal,
        Total = @Total,
        IdFactura = @IdFactura
    Where IdDetalle = @IdDetalle
End

--Eliminar
Create Procedure EliminarDetalleFactura
    @IdDetalle int
As
Begin
    Delete from DetalleFactura
    Where IdDetalle = @IdDetalle
End

--VISTAS 
Create view VDetalleFactura
As
Select * from DetalleFactura



--Table Factura_Proveedor
--Insertar 
insert into Factura_Proveedor(ID_Factura,Fecha)
values(1,'2023-06-14');

insert into Factura_Proveedor(ID_Factura,Fecha)
values(2,'2023-06-15');

insert into Factura_Proveedor(ID_Factura,Fecha)
values(3,'2023-06-16');

insert into Factura_Proveedor(ID_Factura,Fecha)
values(4,'2023-06-17');

insert into Factura_Proveedor(ID_Factura,Fecha)
values(5,'2023-06-18');

--PROCEDIMIENTOS ALMACENADOS FACTURA_PROVEEDOR
--Insertar
Create Procedure RegistrarFacturaProveedor
    @ID_Factura int,
    @Fecha date
As
Begin
    Insert into Factura_Proveedor (ID_Factura, Fecha)
    values (@ID_Factura, @Fecha)
End

--Consultar
Create Procedure ConsultarFacturaProveedor
	@ID_Factura int
As
Begin 
     Select * From Factura_Proveedor Where ID_Factura = @ID_Factura; 
End

--Modificar
Create Procedure ActualizarFacturaProveedor
    @ID_Factura int,
    @Fecha date
As
Begin
    Update Factura_Proveedor
    Set ID_Factura = @ID_Factura,
		Fecha= @Fecha
    Where ID_Factura = @ID_Factura
End

-- Eliminar
Create Procedure EliminarFacturaProveedor
    @ID_Factura int
As
Begin
    Delete from Factura_Proveedor
    Where ID_Factura = @ID_Factura
End

--Vistas
Create view VFactura_Proveedor
As
Select * from Factura_Proveedor 



--Table Categoria 
--Insertar 
insert into Categoria(ID_Categoria,Nombre_Categoria)
values(1,'portatil');

insert into Categoria(ID_Categoria,Nombre_Categoria)
values(2,'Implementarios');

insert into Categoria(ID_Categoria,Nombre_Categoria)
values(3,'Auriculares');

insert into Categoria(ID_Categoria,Nombre_Categoria)
values(4,'ComputadorMesa');

insert into Categoria(ID_Categoria,Nombre_Categoria)
values(5,'Celular');

--PROCEDIMIENTOS ALMACENADOS CATEGORIA
--Insertar
Create Procedure RegistrarCategoria
    @ID_Categoria int,
    @Nombre_Categoria nvarchar
As
Begin
    Insert into Categoria (ID_Categoria, Nombre_Categoria)
    values (@ID_Categoria, @Nombre_Categoria)
End

--Consultar
Create Procedure ConsultarCategorias
	@ID_Categoria int
As
Begin 
     Select * From Categoria Where ID_Categoria = @ID_Categoria; 
End

--Modificar
Create Procedure ActualizarCategoria
    @ID_Categoria int,
    @Nuevo_Nombre nvarchar
As
Begin
    Update Categoria
    Set ID_Categoria = @ID_Categoria,
		Nombre_Categoria= @Nuevo_Nombre
    Where ID_Categoria = @ID_Categoria
End

-- Eliminar
Create Procedure EliminarCategoria
    @ID_Categoria int
As
Begin
    Delete from Categoria
    Where ID_Categoria = @ID_Categoria
End

--Vistas
Create view VCategoria
As
Select * from Categoria 




--Table Factura_DetalleProveedor
--Insertar
Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
values (1,10,2600000, 0.019, 26000000, 26494000,1);

Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
values (2,10,250000, 0.019, 2500000, 2547500,2);

Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
values (3,10,50000, 0.019, 500000, 509500,3);

Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
values (4,5,700000, 0.019, 3500000, 3566500,4);

Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
values (5,10,150000, 0.019, 1500000, 1528500,5);

--PROCEDIMIENTOS ALMACENADOS FACTURA_DETALLEPROVEEDOR
--Insertar
Create Procedure InsertarDetalleProveedor
    @ID_Detalle int,
    @Cantidad int,
    @Precio float,
    @Iva float,
    @SubTotal float,
    @Total float,
    @ID_Factura int
As
Begin
    Insert into Factura_DetalleProveedor(ID_Detalle, Cantidad, Precio, Iva, SubTotal, Total, ID_Factura)
    values (@ID_Detalle, @Cantidad, @Precio, @Iva, @SubTotal, @Total, @ID_Factura)
End
--Consultar 
Create Procedure ConsultarDetalleProveedor
	@ID_Detalle int
As
Begin
    Select * From Factura_DetalleProveedor Where ID_Detalle = @ID_Detalle; 
End

--Modificar 
Create Procedure ActualizarDetalleProveedor
    @ID_Detalle int,
    @Cantidad int,
    @Precio float,
    @Iva float,
    @SubTotal float,
    @Total float,
    @ID_Factura int
As
Begin
    Update Factura_DetalleProveedor
    Set ID_Detalle = @ID_Detalle,
		Cantidad = @Cantidad,
		Precio = @Precio,
		Iva = @Iva,
		Subtotal = @SubTotal,
		Total = @Total,
		ID_Factura = @ID_Factura 
    Where ID_Detalle = @ID_Detalle
End

--Eliminar
Create Procedure EliminarDetalleProveedor
    @ID_Detalle int
As
Begin
    Delete from Factura_DetalleProveedor
    Where ID_Detalle = @ID_Detalle
End

--Vistas
Create view VFactura_DetalleProveedor
As
Select * from Factura_DetalleProveedor 



--Table Productos 
--Insertar 
Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
values (1, 'Computador Samsung 2018', 1, 2600000, 'Activo', 'Estante 2', 1, 1, 1); 

Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
values (2, 'Audifonos inalambricos', 1, 250000, 'Activo', 'Estante 1', 3, 2, 2); 

Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
values (3, 'Mouse inalambrico', 1, 50000, 'Activo', 'Estante 3', 2, 3, 3); 

Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
values (4, 'Celular Samsung Galaxy A21S', 1, 700000, 'Activo', 'Estante 4', 5, 4, 4); 

Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
values (5, 'Pantalla 14" Dell', 1, 150000, 'Activo', 'Estante 3', 2, 5, 5); 

--PROCEDIMIENTOS ALMACENADOS PRODUCTOS
--Insertar
Create Procedure InsertarProducto
    @ID_Productos int,
    @Nombre nvarchar,
    @Cantidad int,
    @Precio float,
    @Estado nvarchar,
    @Lugar nvarchar,
    @ID_Categoria int,
	@ID_Detalle int, 
	@IdDetalle int
As
Begin
    Insert into Productos(ID_Productos, Nombre, Cantidad, Precio, Estado, Lugar, ID_Categoria, ID_Detalle, IdDetalle)
    values (@ID_Productos,@Nombre,@Cantidad,@Precio,@Estado,@Lugar,@ID_Categoria,@ID_Detalle, @IdDetalle)
End

--Consultar 
Create Procedure ConsultarProducto
	@ID_Productos int
As
Begin
    Select * From Productos Where ID_Productos = @ID_Productos; 
End

--Modificar 
Create Procedure ActualizarProducto
    @ID_Productos int,
    @Nombre nvarchar,
    @Cantidad int,
    @Precio float,
    @Estado nvarchar,
    @Lugar nvarchar,
    @ID_Categoria int,
	@ID_Detalle int, 
	@IdDetalle int
As
Begin
    Update Productos
    Set ID_Productos = @ID_Productos,
		Nombre = Nombre,
		Cantidad = @Cantidad,
		Precio = @Precio,
		Estado = @Estado,
		ID_Categoria = @ID_Categoria,
		ID_Detalle = @ID_Detalle,
		IdDetalle = IdDetalle
    Where ID_Productos = @ID_Productos
End

--Eliminar
Create Procedure EliminarProducto
    @ID_Productos int
As
Begin
    Delete from Productos
    Where ID_Productos = @ID_Productos
End

--Vistas
Create view VProductos
As
Select * from Productos 


--Table Stock 
--Insertar 
Insert into Stock(ID_Stock, Cantidad_Real,Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
Values (1, 150, 50, 20, 5, '2023-06-14', 1);

Insert into Stock(ID_Stock, Cantidad_Real,Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
Values (2, 250, 100, 30, 5, '2023-06-15', 2);

Insert into Stock(ID_Stock, Cantidad_Real,Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
Values (3, 80, 40, 10, 5, '2023-06-16', 3);

Insert into Stock(ID_Stock, Cantidad_Real,Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
Values (4, 350, 200, 50, 5, '2023-06-17', 4);

Insert into Stock(ID_Stock, Cantidad_Real,Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
Values (5, 150, 80, 30, 5, '2023-06-18', 5);

--PROCEDIMIENTOS ALMACENADOS STOCK
--Insertar
Create Procedure InsertarProductoStock
    @Cantidad_Real int,
    @Cantidad_Ideal int,
    @Cantidad_Minima int,
    @Cantidad_Alarma int,
    @Fecha_Ingreso date,
    @ID_Productos int
As
Begin
    Insert into Stock (Cantidad_Real, Cantidad_Ideal, Cantidad_Minima, Cantidad_Alarma, Fecha_Ingreso, ID_Productos)
    values (@Cantidad_Real, @Cantidad_Ideal, @Cantidad_Minima, @Cantidad_Alarma, @Fecha_Ingreso, @ID_Productos)
End
--Consultar 
Create Procedure ConsultarProductoStock
	@ID_Productos int
As
Begin
    Select * From Stock Where ID_Productos = @ID_Productos; 
End

--Modificar 
Create Procedure ActualizarProductoStock
    @ID_Stock int,
    @Cantidad_Real int,
    @Cantidad_Ideal int,
    @Cantidad_Minima int,
    @Cantidad_Alarma int,
    @Fecha_Ingreso date,
    @ID_Productos int
As
Begin
    Update Stock
    Set Cantidad_Real = @Cantidad_Real,
        Cantidad_Ideal = @Cantidad_Ideal,
        Cantidad_Minima = @Cantidad_Minima,
        Cantidad_Alarma = @Cantidad_Alarma,
        Fecha_Ingreso = @Fecha_Ingreso,
        ID_Productos = @ID_Productos
    Where ID_Stock = @ID_Stock
End

--Eliminar
Create Procedure EliminarProductoStock
    @ID_Stock int
As
Begin
    Delete from Stock
    Where ID_Stock = @ID_Stock
End

--Vistas
Create view VStock
As
Select * from Stock 




--Table proveedor 
--Insertar 
Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion)
Values (1,'Juan', 'Gómez', 'juangomez@example.com', 'Juan Gómez', 'Calle Principal, Ciudad');

Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion)
Values (2, 'María', 'López', 'marialopez@example.com', 'María López', 'Avenida Central, Pueblo');

Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion)
Values (3, 'Pedro', 'Rodríguez', 'pedrorodriguez@example.com', 'Pedro Rodríguez', 'Carrera 123, Villa');

Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion)
Values (4, 'Ana', 'Pérez', 'anaperez@example.com', 'Ana Pérez', 'Calle Secundaria, Poblado');

Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion)
Values (5, 'Luis', 'García', 'luisgarcia@example.com', 'Luis García', 'Plaza Mayor, Localidad');

--PROCEDIMIENTOS ALMACENADOS PROVEEDOR
--Insertar 
Create Procedure InsertarProveedor 
	@ID_Proveedor int, 
	@Nombre nvarchar(50), 
	@Apellido nvarchar(50), 
	@Correo nvarchar(50), 
	@Contacto nvarchar(50), 
	@Direccion nvarchar(50), 
	@Id_Factura int 
As 
Begin
	Insert into Proveedor(ID_Proveedor, Nombre, Apellido, Correo, Contacto, Direccion, Id_Factura)
    values (@ID_Proveedor, @Nombre, @Apellido, @Correo, @Contacto, @Direccion, @Id_Factura)
End

--Consultar 
Create Procedure ConsultarProveedor
	@ID_Proveedor int
As
Begin
    Select * From Proveedor Where ID_Proveedor = @ID_Proveedor; 
End

--Modificar
Create Procedure ActualizarProveedor
    @ID_Proveedor int,
    @Nombre nvarchar(50),
    @Apellido nvarchar(50),
    @Correo nvarchar(50),
    @Contacto nvarchar(50),
    @Direccion nvarchar(50),
    @Id_Factura int
As
Begin
    Update Proveedor
    Set Nombre = @Nombre,
        Apellido = @Apellido,
        Correo = @Correo,
        Contacto = @Contacto,
        Direccion = @Direccion,
        Id_Factura = @Id_Factura
    Where ID_Proveedor = @ID_Proveedor
End

--Eliminar
Create Procedure EliminarProveedor
    @ID_Proveedor int
As
Begin
    Delete from Proveedor
    Where ID_Proveedor = @ID_Proveedor
End 

--Vistas
Create view VProveedor
As
Select * from Proveedor 



--Table precios
--Insertar 
Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
values (1, 1800000, 2600000, 0, '2023-01-01', 'Activo');

Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
values (2, 200000, 250000, 0, '2023-01-02', 'Activo');

Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
values (3, 20000, 50000, 0, '2023-01-03', 'Activo');

Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
values (4, 500000, 700000, 0, '2023-01-04', 'Activo');

Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
values (5, 100000, 150000, 0, '2023-01-05', 'Activo');

--PROCEDIMIENTOS ALMACENADOS PRECIO
--Insertar 
Create Procedure InsertarPrecio
	@ID_Productos int,
    @Precio_Compra float,
    @Precio_Venta float,
    @Precio_Descuento float,
    @Fecha_Descuento date,
    @Estado nvarchar(50)
As 
Begin
	Insert into Precio(ID_Productos, Precio_Compra, Precio_Venta, Precio_Descuento, Fecha_Descuento, Estado)
    values (@ID_Productos, @Precio_Compra, @Precio_Venta, @Precio_Descuento, @Fecha_Descuento, @Estado)
End

--Consultar 
Create Procedure ConsultarPrecio
	@ID_Productos int
As
Begin
    Select * From Precio Where ID_Productos = @ID_Productos; 
End

--Modificar
Create Procedure ActualizarPrecio
    @ID_Productos int,
    @Precio_Compra float,
    @Precio_Venta float,
    @Precio_Descuento float,
    @Fecha_Descuento date,
    @Estado nvarchar(50)
As
Begin
    Update Precio
    Set ID_Productos = @ID_Productos,
		Precio_Compra = @Precio_Compra,
		Precio_Venta = @Precio_Venta,
		Precio_Descuento = @Precio_Descuento,
		Fecha_Descuento = @Fecha_Descuento,
		Estado= @Estado
    Where ID_Productos = @ID_Productos
End

--Eliminar
Create Procedure EliminarPrecio
    @ID_Productos int
As
Begin
    Delete from Precio
    Where ID_Productos = @ID_Productos
End 

--Vistas
Create view VPrecio
As
Select * from Precio 





