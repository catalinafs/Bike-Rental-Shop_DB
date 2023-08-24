CREATE DATABASE bike_rental_shop_db;

\c bike_rental_shop_db;

CREATE TABLE client(
    id SERIAL,
    dni CHARACTER VARYING(15) UNIQUE NOT NULL,
    first_name CHARACTER VARYING(40) NOT NULL,
    last_name CHARACTER VARYING(40) NOT NULL,
    cellphone NUMERIC NOT NULL,
    email CHARACTER VARYING(100),
    "address" CHARACTER VARYING(150) NOT NULL,
    CONSTRAINT client_pkey PRIMARY KEY (id)
);

CREATE TABLE bike(
    id SERIAL,
    rim INTEGER NOT NULL,
    places INTEGER NOT NULL,
    "type" CHARACTER VARYING(60),
    model CHARACTER VARYING(35),
    brand CHARACTER VARYING(45),
    hourly_price MONEY NOT NULL,
    available BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT bike_pkey PRIMARY KEY (id)
);

CREATE TABLE rental(
    id SERIAL,
    client_id INTEGER NOT NULL,
    date_rented TIMESTAMP NOT NULL DEFAULT now(),
    date_returned TIMESTAMP NOT NULL,
    CONSTRAINT rental_pkey PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE rental_bike(
    rental_id INTEGER NOT NULL,
    bike_id INTEGER NOT NULL,
    CONSTRAINT rental_bike_pkey PRIMARY KEY (rental_id, bike_id),
    FOREIGN KEY (rental_id) REFERENCES rental(id),
    FOREIGN KEY (bike_id) REFERENCES bike(id)
);

CREATE TABLE payment(
    id SERIAL,
    rental_id INTEGER NOT NULL UNIQUE,
    payment_method CHARACTER VARYING(15) NOT NULL DEFAULT 'Cash',
    amount MONEY NOT NULL,
    "date" TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT payment_pkey PRIMARY KEY (id),
    FOREIGN KEY (rental_id) REFERENCES rental(id)
);