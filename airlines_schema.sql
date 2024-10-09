CREATE DATABASE IF NOT EXISTS airlines;

CREATE TABLE aerolineas (
    icao VARCHAR(3),
    aerolinea VARCHAR(255),
    iata VARCHAR(2),
    country VARCHAR(255),
    founded INT,
    started_operations INT,
    air_group VARCHAR(255),
    base VARCHAR(255),
    fleet_size FLOAT,
    average_fleet_age FLOAT,
    official_site VARCHAR(255),
    PRIMARY KEY (icao)
);

CREATE TABLE estados (
    estado VARCHAR(2),
    nombre_estado VARCHAR(255),
    PRIMARY KEY (estado)
);

CREATE TABLE aeropuertos (
    codigo_aeropuerto VARCHAR(3),
    nombre_aeropuerto VARCHAR(255),
    ciudad VARCHAR(255),
    estado VARCHAR(2),
    latitud FLOAT,
    longitude FLOAT,
    direccion VARCHAR(255),
    PRIMARY KEY (codigo_aeropuerto),
    FOREIGN KEY (estado) REFERENCES estados (estado)
);

CREATE TABLE distancias (
    distancia_millas FLOAT,
    aeropuerto_origen VARCHAR(3),
    aeropuerto_destino VARCHAR(3),
    PRIMARY KEY (aeropuerto_origen , aeropuerto_destino),
    FOREIGN KEY (aeropuerto_origen) REFERENCES aeropuertos (codigo_aeropuerto),
    FOREIGN KEY (aeropuerto_destino) REFERENCES aeropuertos (codigo_aeropuerto)
    );

CREATE TABLE vuelos (
    aerolinea VARCHAR(3) NOT NULL,
    fecha DATE,
    numero_vuelo INT,
    numero_cola VARCHAR(255),
    hora_salida_programada TIME,
    hora_salida_real TIME,
    duracion_programada_vuelo INT,
    duracion_real INT,
    retraso_salida INT,
    hora_despegue TIME,
    tiempo_pista_salida INT,
    tiempo_retraso_aerolinea INT,
    tiempo_retraso_clima INT,
    tiempo_retraso_sistema_aviacion INT,
    tiempo_retraso_seguridad INT,
    retraso_llegada INT,
    aeropuerto_origen VARCHAR(3),
    hora_llegada_real TIME,
    festivos TINYINT,
    aeropuerto_destino VARCHAR(3),
    PRIMARY KEY (numero_vuelo),
    FOREIGN KEY (aerolinea) REFERENCES aerolineas (icao),
    FOREIGN KEY (aeropuerto_origen) REFERENCES aeropuertos (codigo_aeropuerto),
    FOREIGN KEY (aeropuerto_destino) REFERENCES aeropuertos (codigo_aeropuerto)
);