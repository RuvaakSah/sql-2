CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY, -- SERIAL aplica auto-incremento
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT
);

-- Insertar datos
INSERT INTO usuario (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

-- PASO 2: Crear tabla roles e insertar datos
CREATE TABLE roles (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

INSERT INTO roles (nombre_rol) VALUES ('Bronce'), ('Plata'), ('Oro'), ('Platino');

-- PASO 3: Añadir columna id_rol y clave foránea
ALTER TABLE usuario ADD COLUMN id_rol INT;

-- Rellenar roles aleatorios (ejemplo rápido)
UPDATE usuario SET id_rol = 1 WHERE id_usuario % 4 = 0;
UPDATE usuario SET id_rol = 2 WHERE id_usuario % 4 = 1;
UPDATE usuario SET id_rol = 3 WHERE id_usuario % 4 = 2;
UPDATE usuario SET id_rol = 4 WHERE id_usuario % 4 = 3;

-- Crear clave foránea
ALTER TABLE usuario ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);

-- PASO 4: Consulta JOIN
SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.edad, r.nombre_rol
FROM usuario u
JOIN roles r ON u.id_rol = r.id_rol;

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'), ('Ropa y Accesorios'), ('Libros'), ('Hogar y Cocina'), 
('Deportes'), ('Salud'), ('Herramientas'), ('Juguetes'), ('Automotriz'), ('Música');

-- PASO 2: Añadir columna id_categoria a usuarios
ALTER TABLE usuario ADD COLUMN id_categoria INT;

-- PASO 3: Asignar categorías
UPDATE usuario SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);

-- PASO 4: JOIN de las tres tablas
SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.edad, r.nombre_rol, c.nombre_categoria
FROM usuarios u
LEFT JOIN roles r ON u.id_rol = r.id_rol
LEFT JOIN categorias c ON u.id_categoria = c.id_categoria;

CREATE TABLE usuario_categorias (
    id_usuario_categoria SERIAL PRIMARY KEY,
    id_usuario INT,
    id_categoria INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- PASO 2: Asociar datos
INSERT INTO usuario_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);

-- PASO 3: Consulta final para ver la unión total
SELECT u.id_usuario, u.nombre, u.apellido, r.nombre_rol, c.nombre_categoria
FROM usuario u
JOIN roles r ON u.id_rol = r.id_rol
JOIN usuario_categorias uc ON u.id_usuario = uc.id_usuario
JOIN categorias c ON uc.id_categoria = c.id_categoria;