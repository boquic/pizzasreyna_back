-- Insertar usuario administrador (password: admin123)
INSERT INTO usuario (nombre, apellido, email, password, telefono, direccion, rol_id, activo)
VALUES ('Admin', 'Sistema', 'admin@pizzasreyna.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCu', '999888777', 'Oficina Central', 1, true);

-- Insertar ingredientes
INSERT INTO ingrediente (nombre, descripcion, precio_adicional, disponible, imagen_url) VALUES
('Queso Mozzarella', 'Queso mozzarella de alta calidad', 2.00, true, 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400'),
('Pepperoni', 'Pepperoni italiano premium', 3.50, true, 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400'),
('Jamón', 'Jamón ahumado', 3.00, true, 'https://images.unsplash.com/photo-1624191249343-c7a4b2c5e9b6?w=400'),
('Champiñones', 'Champiñones frescos', 2.50, true, 'https://images.unsplash.com/photo-1614961234441-64dbb6a0e8a2?w=400'),
('Aceitunas', 'Aceitunas negras', 2.00, true, 'https://images.unsplash.com/photo-1452251889946-8ff5ea7f27f3?w=400'),
('Pimientos', 'Pimientos rojos y verdes', 2.00, true, 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400'),
('Cebolla', 'Cebolla morada', 1.50, true, 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=400'),
('Tomate', 'Tomate fresco', 1.50, true, 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400'),
('Piña', 'Piña en trozos', 2.50, true, 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=400'),
('Tocino', 'Tocino crujiente', 3.50, true, 'https://images.unsplash.com/photo-1528607929212-2636ec44253e?w=400'),
('Salchicha', 'Salchicha italiana', 3.00, true, 'https://images.unsplash.com/photo-1612927601601-6638404737ce?w=400'),
('Pollo', 'Pollo a la parrilla', 4.00, true, 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=400'),
('Carne Molida', 'Carne molida sazonada', 4.00, true, 'https://images.unsplash.com/photo-1603048588665-791ca8aea617?w=400'),
('Albahaca', 'Albahaca fresca', 1.00, true, 'https://images.unsplash.com/photo-1618375569909-3c8616cf7733?w=400'),
('Orégano', 'Orégano seco', 0.50, true, 'https://images.unsplash.com/photo-1583487960151-c5c29836b1b5?w=400');

-- Insertar pizzas predefinidas
INSERT INTO pizza (nombre, descripcion, precio_base, tamanio, disponible, imagen_url, es_personalizada) VALUES
('Margarita', 'Pizza clásica con salsa de tomate, mozzarella y albahaca', 25.00, 'MEDIANA', true, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800', false),
('Pepperoni', 'Pizza con abundante pepperoni y queso mozzarella', 30.00, 'MEDIANA', true, 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=800', false),
('Hawaiana', 'Pizza con jamón, piña y queso mozzarella', 32.00, 'MEDIANA', true, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', false),
('Cuatro Quesos', 'Mezcla de mozzarella, parmesano, gorgonzola y provolone', 35.00, 'MEDIANA', true, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800', false),
('Vegetariana', 'Pizza con champiñones, pimientos, cebolla, aceitunas y tomate', 28.00, 'MEDIANA', true, 'https://images.unsplash.com/photo-1511689660979-10d2b1aada49?w=800', false),
('Suprema', 'Pizza con pepperoni, salchicha, champiñones, pimientos y cebolla', 38.00, 'GRANDE', true, 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=800', false),
('BBQ Chicken', 'Pollo a la parrilla con salsa BBQ, cebolla y queso', 36.00, 'GRANDE', true, 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800', false),
('Meat Lovers', 'Pizza con pepperoni, jamón, tocino, salchicha y carne molida', 42.00, 'GRANDE', true, 'https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=800', false);

-- Relacionar ingredientes con pizzas
-- Margarita (id: 1)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(1, 1), -- Mozzarella
(1, 8), -- Tomate
(1, 14); -- Albahaca

-- Pepperoni (id: 2)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(2, 1), -- Mozzarella
(2, 2); -- Pepperoni

-- Hawaiana (id: 3)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(3, 1), -- Mozzarella
(3, 3), -- Jamón
(3, 9); -- Piña

-- Cuatro Quesos (id: 4)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(4, 1); -- Mozzarella (representando los 4 quesos)

-- Vegetariana (id: 5)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(5, 1), -- Mozzarella
(5, 4), -- Champiñones
(5, 5), -- Aceitunas
(5, 6), -- Pimientos
(5, 7), -- Cebolla
(5, 8); -- Tomate

-- Suprema (id: 6)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(6, 1), -- Mozzarella
(6, 2), -- Pepperoni
(6, 11), -- Salchicha
(6, 4), -- Champiñones
(6, 6), -- Pimientos
(6, 7); -- Cebolla

-- BBQ Chicken (id: 7)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(7, 1), -- Mozzarella
(7, 12), -- Pollo
(7, 7); -- Cebolla

-- Meat Lovers (id: 8)
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES
(8, 1), -- Mozzarella
(8, 2), -- Pepperoni
(8, 3), -- Jamón
(8, 10), -- Tocino
(8, 11), -- Salchicha
(8, 13); -- Carne Molida

-- Insertar combos
INSERT INTO combo (nombre, descripcion, precio, descuento, disponible, imagen_url) VALUES
('Combo Familiar', '2 pizzas grandes + 2 bebidas de 1.5L', 75.00, 10.00, true, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
('Combo Pareja', '1 pizza mediana + 2 bebidas personales', 35.00, 5.00, true, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800'),
('Combo Party', '3 pizzas grandes + 3 bebidas de 1.5L', 110.00, 15.00, true, 'https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=800');

-- Relacionar pizzas con combos (ejemplo)
INSERT INTO combo_pizza (combo_id, pizza_id, cantidad) VALUES
(1, 6, 2), -- Combo Familiar: 2 Supremas
(2, 2, 1), -- Combo Pareja: 1 Pepperoni
(3, 8, 3); -- Combo Party: 3 Meat Lovers
