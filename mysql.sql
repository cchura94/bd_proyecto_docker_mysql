CREATE DATABASE bd_compras_ventas_inventario;

USE bd_compras_ventas_inventario;

CREATE TABLE personas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    genero VARCHAR(20),
    direccion TEXT,
    telefono VARCHAR(20),
    nacionalidad VARCHAR(50) NOT NULL
);

CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    status BOOLEAN,
    persona_id INT,
    FOREIGN KEY(persona_id) REFERENCES personas(id)
);

CREATE TABLE roles(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    detalle TEXT
);

CREATE TABLE permisos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    action VARCHAR(100),
    subject VARCHAR(100)
);

CREATE TABLE permiso_role(
    id INT AUTO_INCREMENT PRIMARY KEY,
    permiso_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY(permiso_id) REFERENCES permisos(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE role_user(
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);



CREATE TABLE documentos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL,
    archivo VARCHAR(255) NOT NULL,
    detalle TEXT,
    estado BOOLEAN,
    persona_id INT NOT NULL,
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

CREATE TABLE sucursales(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE sucursal_user(
    id INT AUTO_INCREMENT PRIMARY KEY,
    sucursal_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE almacenes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    sucursal_id INT NOT NULL,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

CREATE TABLE categorias(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado BOOLEAN
);

CREATE TABLE productos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio_venta_actual DECIMAL(12,2),
    imagen VARCHAR(255),
    estado BOOLEAN NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE almacen_producto(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cantidad_actual INT NOT NULL,
    almacen_id INT NOT NULL,
    producto_id INT NOT NULL,
    FOREIGN KEY (almacen_id) REFERENCES almacenes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE cliente_proveedor(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('cliente', 'proveedor') NOT NULL,
    razon_social VARCHAR(200),
    nro_identificacion VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    correo VARCHAR(200),
    estado BOOLEAN
);


CREATE TABLE notas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME,
    tipo_nota ENUM('COMPRA', 'VENTA', 'DEVOLUCION') NOT NULL,
    estado BOOLEAN,
    observaciones TEXT,
    user_id INT NOT NULL,
    cliente_proveedor_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (cliente_proveedor_id) REFERENCES cliente_proveedor(id)
);


CREATE TABLE movimientos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nota_id INT NOT NULL,
    producto_id INT NOT NULL,
    almacen_id INT NOT NULL,
    cantidad INT NOT NULL,
    tipo_movimiento ENUM('ingreso', 'salida', 'devolucion') NOT NULL,
    precio_compra DECIMAL(12,2),
    precio_venta DECIMAL(12,2),
    observaciones TEXT,
    FOREIGN KEY (nota_id) REFERENCES notas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (almacen_id) REFERENCES almacenes(id)
);




