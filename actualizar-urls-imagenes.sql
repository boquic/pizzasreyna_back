-- Script para actualizar las URLs de las imágenes sin perder datos
-- Ejecutar este script directamente en PostgreSQL

-- Actualizar URLs de ingredientes
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/mozzarella.jpg' WHERE nombre = 'Queso Mozzarella';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/pepperoni.jpg' WHERE nombre = 'Pepperoni';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/jamon.jpg' WHERE nombre = 'Jamón';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/champinones.jpg' WHERE nombre = 'Champiñones';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/aceitunas.jpg' WHERE nombre = 'Aceitunas';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/pimientos.jpg' WHERE nombre = 'Pimientos';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/cebolla.jpg' WHERE nombre = 'Cebolla';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/tomate.jpg' WHERE nombre = 'Tomate';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/pina.jpg' WHERE nombre = 'Piña';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/tocino.jpg' WHERE nombre = 'Tocino';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/salchicha.jpg' WHERE nombre = 'Salchicha';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/pollo.jpg' WHERE nombre = 'Pollo';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/carne.jpg' WHERE nombre = 'Carne Molida';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/albahaca.jpg' WHERE nombre = 'Albahaca';
UPDATE ingrediente SET imagen_url = 'TU_URL_AQUI/oregano.jpg' WHERE nombre = 'Orégano';

-- Actualizar URLs de pizzas
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/margarita.jpg' WHERE nombre = 'Margarita';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/pepperoni-pizza.jpg' WHERE nombre = 'Pepperoni';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/hawaiana.jpg' WHERE nombre = 'Hawaiana';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/cuatro-quesos.jpg' WHERE nombre = 'Cuatro Quesos';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/vegetariana.jpg' WHERE nombre = 'Vegetariana';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/suprema.jpg' WHERE nombre = 'Suprema';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/bbq-chicken.jpg' WHERE nombre = 'BBQ Chicken';
UPDATE pizza SET imagen_url = 'TU_URL_AQUI/meat-lovers.jpg' WHERE nombre = 'Meat Lovers';

-- Actualizar URLs de combos
UPDATE combo SET imagen_url = 'TU_URL_AQUI/combo-familiar.jpg' WHERE nombre = 'Combo Familiar';
UPDATE combo SET imagen_url = 'TU_URL_AQUI/combo-pareja.jpg' WHERE nombre = 'Combo Pareja';
UPDATE combo SET imagen_url = 'TU_URL_AQUI/combo-party.jpg' WHERE nombre = 'Combo Party';

-- Verificar cambios
SELECT nombre, imagen_url FROM pizza;
SELECT nombre, imagen_url FROM ingrediente;
SELECT nombre, imagen_url FROM combo;
