

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

CREATE TABLE models (
    id SERIAL PRIMARY KEY,
    brand_id INTEGER REFERENCES brands(id),
    name VARCHAR(100),
    price NUMERIC(10, 2),
    discount NUMERIC(10, 2),
    fiscal_power INTEGER,
    displacement NUMERIC(10, 2)
);


CREATE TABLE standardequipment (
    id SERIAL PRIMARY KEY,
    model_id INTEGER REFERENCES models(id),
    feature VARCHAR(255)
);


CREATE TABLE extras (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price NUMERIC(10, 2)
);

CREATE TABLE extraspermodel (
    id SERIAL PRIMARY KEY,
    model_id INTEGER REFERENCES models(id),
    extra_id INTEGER REFERENCES extras(id)
);


CREATE TABLE carsinstock (
    chassis_number VARCHAR(50) PRIMARY KEY,
    model_id INTEGER REFERENCES models(id),
    location VARCHAR(100) 
);

CREATE TABLE officialservices (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    INE VARCHAR(50)
);

CREATE TABLE sellers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    INE VARCHAR(50),
    address VARCHAR(255)
);


CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    car_chassis_number VARCHAR(50) REFERENCES carsinstock(chassis_number),
    seller_id INTEGER REFERENCES sellers(id),
    official_service_id INTEGER REFERENCES officialservices(id),
    sale_price NUMERIC(10, 2),
    payment_method VARCHAR(50), 
    delivery_date DATE,
    license_plate VARCHAR(20),
    is_stock BOOLEAN 
);


CREATE TABLE salesextras (
    id SERIAL PRIMARY KEY,
    sale_id INTEGER REFERENCES sales(id),
    extra_id INTEGER REFERENCES extras(id),
    extra_price NUMERIC(10, 2)
);

INSERT INTO brands(name)
VALUES ('volkswagen');

INSERT INTO models(name, price,discount, fiscal_power,displacement)
VALUES ('herbie', 25012.8, 0.0, 16, 4 )

UPDATE models
SET brand_id = 1
WHERE id =1;

INSERT INTO standardequipment(model_id, feature)
VALUES (1, 'carro compacto, dos puertas, competidor de carreras NASCAR, se conduce solo, siempre encuentra una solucion');

INSERT INTO extras(name, price)
VALUES ('bolsas de aire', 250.5);

INSERT INTO extras(name, price)
VALUES ('faros de niebla', 1050.5);

INSERT INTO extraspermodel(model_id, extra_id)
VALUES (1,2);


INSERT INTO carsinstock(chassis_number, model_id, location)
VALUES (0192837465, 1, 'miami');

INSERT INTO officialservices(name, address, INE)
VALUES ('orko', 'selvas de eternia', 'qwerty678');

INSERT INTO sellers(name, address, INE)
VALUES ('skeletor', 'montana serpiente', 'qwertz098');

INSERT INTO sales(car_chassis_number, seller_id, sale_price, payment_method, delivery_date, license_plate, is_stock)
VALUES (0192837465,1, 25012.8, 'financiamiento', '2024-04-04','full-90-w56', true);

INSERT INTO salesextras(sale_id, extra_id, extra_price)
VALUES (1, 2, 1050.5);

SELECT 
    s.name AS seller_name,
    m.name AS car_name,
    m.price AS car_price,
    e.name AS extra_name,
    e.price AS extra_price,
    ste.feature AS standard_feature
FROM 
    sales sa
JOIN 
    sellers s ON sa.seller_id = s.id
JOIN 
    carsinstock c ON sa.car_chassis_number = c.chassis_number
JOIN 
    models m ON c.model_id = m.id
LEFT JOIN 
    salesextras se ON sa.id = se.sale_id
LEFT JOIN 
    extras e ON se.extra_id = e.id
LEFT JOIN 
    standardequipment ste ON m.id = ste.model_id;



