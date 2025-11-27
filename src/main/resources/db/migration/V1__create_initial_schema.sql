-- Tabla de Roles
CREATE TABLE rol (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Usuarios
CREATE TABLE usuario (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    rol_id BIGINT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES rol(id)
);

-- Tabla de Ingredientes
CREATE TABLE ingrediente (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    precio_adicional DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    disponible BOOLEAN DEFAULT TRUE,
    imagen_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Pizzas
CREATE TABLE pizza (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_base DECIMAL(10, 2) NOT NULL,
    tamanio VARCHAR(20) NOT NULL CHECK (tamanio IN ('PEQUEÑA', 'MEDIANA', 'GRANDE', 'FAMILIAR')),
    disponible BOOLEAN DEFAULT TRUE,
    imagen_url VARCHAR(500),
    es_personalizada BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla intermedia Pizza-Ingrediente
CREATE TABLE pizza_ingrediente (
    pizza_id BIGINT NOT NULL,
    ingrediente_id BIGINT NOT NULL,
    PRIMARY KEY (pizza_id, ingrediente_id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id) ON DELETE CASCADE
);

-- Tabla de Combos
CREATE TABLE combo (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    descuento DECIMAL(5, 2) DEFAULT 0.00,
    disponible BOOLEAN DEFAULT TRUE,
    imagen_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla intermedia Combo-Pizza
CREATE TABLE combo_pizza (
    combo_id BIGINT NOT NULL,
    pizza_id BIGINT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    PRIMARY KEY (combo_id, pizza_id),
    FOREIGN KEY (combo_id) REFERENCES combo(id) ON DELETE CASCADE,
    FOREIGN KEY (pizza_id) REFERENCES pizza(id) ON DELETE CASCADE
);

-- Tabla de Estados de Pedido
CREATE TABLE estado_pedido (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    orden INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Repartidores
CREATE TABLE repartidor (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL UNIQUE,
    vehiculo VARCHAR(50),
    placa VARCHAR(20),
    disponible BOOLEAN DEFAULT TRUE,
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Tabla de Pedidos
CREATE TABLE pedido (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    repartidor_id BIGINT,
    estado_id BIGINT NOT NULL,
    direccion_entrega TEXT NOT NULL,
    telefono_contacto VARCHAR(20) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    costo_envio DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(10, 2) NOT NULL,
    notas TEXT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_entrega_estimada TIMESTAMP,
    fecha_entrega_real TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (repartidor_id) REFERENCES repartidor(id),
    FOREIGN KEY (estado_id) REFERENCES estado_pedido(id)
);

-- Tabla de Detalle de Pedido
CREATE TABLE pedido_detalle (
    id BIGSERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL,
    pizza_id BIGINT,
    combo_id BIGINT,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    notas TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE,
    FOREIGN KEY (pizza_id) REFERENCES pizza(id),
    FOREIGN KEY (combo_id) REFERENCES combo(id),
    CHECK ((pizza_id IS NOT NULL AND combo_id IS NULL) OR (pizza_id IS NULL AND combo_id IS NOT NULL))
);

-- Tabla de Ingredientes Personalizados en Pedido
CREATE TABLE pedido_detalle_ingrediente (
    pedido_detalle_id BIGINT NOT NULL,
    ingrediente_id BIGINT NOT NULL,
    PRIMARY KEY (pedido_detalle_id, ingrediente_id),
    FOREIGN KEY (pedido_detalle_id) REFERENCES pedido_detalle(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id)
);

-- Tabla de Carrito
CREATE TABLE carrito (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- Tabla de Items del Carrito
CREATE TABLE carrito_item (
    id BIGSERIAL PRIMARY KEY,
    carrito_id BIGINT NOT NULL,
    pizza_id BIGINT,
    combo_id BIGINT,
    cantidad INT NOT NULL DEFAULT 1,
    notas TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (carrito_id) REFERENCES carrito(id) ON DELETE CASCADE,
    FOREIGN KEY (pizza_id) REFERENCES pizza(id),
    FOREIGN KEY (combo_id) REFERENCES combo(id),
    CHECK ((pizza_id IS NOT NULL AND combo_id IS NULL) OR (pizza_id IS NULL AND combo_id IS NOT NULL))
);

-- Tabla de Ingredientes Personalizados en Carrito
CREATE TABLE carrito_item_ingrediente (
    carrito_item_id BIGINT NOT NULL,
    ingrediente_id BIGINT NOT NULL,
    PRIMARY KEY (carrito_item_id, ingrediente_id),
    FOREIGN KEY (carrito_item_id) REFERENCES carrito_item(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id)
);

-- Tabla de Pagos
CREATE TABLE pago (
    id BIGSERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL UNIQUE,
    metodo_pago VARCHAR(50) NOT NULL CHECK (metodo_pago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'YAPE', 'PLIN')),
    monto DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(30) NOT NULL CHECK (estado IN ('PENDIENTE', 'PROCESANDO', 'COMPLETADO', 'FALLIDO', 'REEMBOLSADO')),
    transaccion_id VARCHAR(255),
    fecha_pago TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

-- Tabla de Historial de Estados de Pedido
CREATE TABLE pedido_estado_historial (
    id BIGSERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL,
    estado_id BIGINT NOT NULL,
    comentario TEXT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_id) REFERENCES estado_pedido(id)
);

-- Insertar roles por defecto
INSERT INTO rol (nombre, descripcion) VALUES
('ADMIN', 'Administrador del sistema'),
('USUARIO', 'Cliente del sistema'),
('REPARTIDOR', 'Repartidor de pedidos');

-- Insertar usuarios admin adicionales de ejemplo
-- Contraseña para admin1@pizzasreyna.com: admin123
-- Contraseña para admin2@pizzasreyna.com: admin123
INSERT INTO usuario (nombre, apellido, email, password, telefono, direccion, rol_id, activo) VALUES
('Admin', 'Uno', 'admin1@pizzasreyna.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '999888777', 'Av. Principal 123', 1, true),
('Admin', 'Dos', 'admin2@pizzasreyna.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '999777666', 'Av. Secundaria 456', 1, true);

-- Insertar estados de pedido por defecto
INSERT INTO estado_pedido (nombre, descripcion, orden) VALUES
('PENDIENTE', 'Pedido recibido, esperando confirmación', 1),
('CONFIRMADO', 'Pedido confirmado, en preparación', 2),
('EN_PREPARACION', 'Pedido en preparación', 3),
('LISTO', 'Pedido listo para entrega', 4),
('EN_CAMINO', 'Pedido en camino al cliente', 5),
('ENTREGADO', 'Pedido entregado al cliente', 6),
('CANCELADO', 'Pedido cancelado', 7);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_usuario_rol ON usuario(rol_id);
CREATE INDEX idx_pedido_usuario ON pedido(usuario_id);
CREATE INDEX idx_pedido_estado ON pedido(estado_id);
CREATE INDEX idx_pedido_repartidor ON pedido(repartidor_id);
CREATE INDEX idx_pedido_fecha ON pedido(fecha_pedido);
CREATE INDEX idx_carrito_usuario ON carrito(usuario_id);
CREATE INDEX idx_pago_pedido ON pago(pedido_id);
CREATE INDEX idx_pago_estado ON pago(estado);
