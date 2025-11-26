-- Insertar usuario administrador (password: admin123)
INSERT INTO usuario (nombre, apellido, email, password, telefono, direccion, rol_id, activo)
VALUES ('Admin', 'Sistema', 'admin@pizzasreyna.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCu', '999888777', 'Oficina Central', 1, true);

-- Insertar ingredientes
INSERT INTO ingrediente (nombre, descripcion, precio_adicional, disponible, imagen_url) VALUES
('Queso Mozzarella', 'Queso mozzarella de alta calidad', 2.00, true, 'https://example.com/mozzarella.jpg'),
('Pepperoni', 'Pepperoni italiano premium', 3.50, true, 'https://example.com/pepperoni.jpg'),
('Jamón', 'Jamón ahumado', 3.00, true, 'https://example.com/jamon.jpg'),
('Champiñones', 'Champiñones frescos', 2.50, true, 'https://example.com/champinones.jpg'),
('Aceitunas', 'Aceitunas negras', 2.00, true, 'https://example.com/aceitunas.jpg'),
('Pimientos', 'Pimientos rojos y verdes', 2.00, true, 'https://example.com/pimientos.jpg'),
('Cebolla', 'Cebolla morada', 1.50, true, 'https://example.com/cebolla.jpg'),
('Tomate', 'Tomate fresco', 1.50, true, 'https://example.com/tomate.jpg'),
('Piña', 'Piña en trozos', 2.50, true, 'https://example.com/pina.jpg'),
('Tocino', 'Tocino crujiente', 3.50, true, 'https://example.com/tocino.jpg'),
('Salchicha', 'Salchicha italiana', 3.00, true, 'https://example.com/salchicha.jpg'),
('Pollo', 'Pollo a la parrilla', 4.00, true, 'https://example.com/pollo.jpg'),
('Carne Molida', 'Carne molida sazonada', 4.00, true, 'https://example.com/carne.jpg'),
('Albahaca', 'Albahaca fresca', 1.00, true, 'https://example.com/albahaca.jpg'),
('Orégano', 'Orégano seco', 0.50, true, 'https://example.com/oregano.jpg');

-- Insertar pizzas predefinidas
INSERT INTO pizza (nombre, descripcion, precio_base, tamanio, disponible, imagen_url, es_personalizada) VALUES
('Margarita', 'Pizza clásica con salsa de tomate, mozzarella y albahaca', 25.00, 'MEDIANA', true, 'https://example.com/margarita.jpg', false),
('Pepperoni', 'Pizza con abundante pepperoni y queso mozzarella', 30.00, 'MEDIANA', true, 'https://example.com/pepperoni-pizza.jpg', false),
('Hawaiana', 'Pizza con jamón, piña y queso mozzarella', 32.00, 'MEDIANA', true, 'https://example.com/hawaiana.jpg', false),
('Cuatro Quesos', 'Mezcla de mozzarella, parmesano, gorgonzola y provolone', 35.00, 'MEDIANA', true, 'https://example.com/cuatro-quesos.jpg', false),
('Vegetariana', 'Pizza con champiñones, pimientos, cebolla, aceitunas y tomate', 28.00, 'MEDIANA', true, 'https://example.com/vegetariana.jpg', false),
('Suprema', 'Pizza con pepperoni, salchicha, champiñones, pimientos y cebolla', 38.00, 'GRANDE', true, 'https://example.com/suprema.jpg', false),
('BBQ Chicken', 'Pollo a la parrilla con salsa BBQ, cebolla y queso', 36.00, 'GRANDE', true, 'https://example.com/bbq-chicken.jpg', false),
('Meat Lovers', 'Pizza con pepperoni, jamón, tocino, salchicha y carne molida', 42.00, 'GRANDE', true, 'https://example.com/meat-lovers.jpg', false);

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
('Combo Familiar', '2 pizzas grandes + 2 bebidas de 1.5L', 75.00, 10.00, true, 'https://example.com/combo-familiar.jpg'),
('Combo Pareja', '1 pizza mediana + 2 bebidas personales', 35.00, 5.00, true, 'https://example.com/combo-pareja.jpg'),
('Combo Party', '3 pizzas grandes + 3 bebidas de 1.5L', 110.00, 15.00, true, 'https://example.com/combo-party.jpg');

-- Relacionar pizzas con combos (ejemplo)
INSERT INTO combo_pizza (combo_id, pizza_id, cantidad) VALUES
(1, 6, 2), -- Combo Familiar: 2 Supremas
(2, 2, 1), -- Combo Pareja: 1 Pepperoni
(3, 8, 3); -- Combo Party: 3 Meat Lovers
