USE airlines
-- ¿Que 5 aerolineas tienes el tamaño de flota más grande? 

SELECT 
    aerolinea, MAX(fleet_size) AS FLota_mas_grande
FROM
    aerolineas
GROUP BY aerolinea
ORDER BY Flota_mas_grande DESC
LIMIT 5

-- ¿Que distancia (en millas) tardaría en ir desde ATL a JAN? --

SELECT 
    distancia_millas AS dist_ATL_JAN
FROM
    distancias
WHERE
    aeropuerto_origen = 'ATL'
        AND aeropuerto_destino = 'JAN'

-- ¿Cual es la distancia más grande entre 2 aeropuertos?

SELECT 
    aeropuerto_origen, aeropuerto_destino, distancia_millas
FROM
    distancias
WHERE
    distancia_millas = (SELECT 
            MAX(distancia_millas)
        FROM
            distancias)
LIMIT 1;

-- ¿Qué ciudad tiene más aeropuertos?

SELECT 
    ciudad, COUNT(*) AS mayor_numero_aeropuertos
FROM
    aeropuertos
GROUP BY ciudad
ORDER BY mayor_numero_aeropuertos DESC
LIMIT 1;

-- Usando la tabla de vuelos, ¿Que aerolinea tuvo la mayor cantidad de vuelos en todas las fechas?

SELECT 
    t2.aerolinea, t2.ICAO, COUNT(t2.ICAO) AS total_vuelos
FROM
    vuelos t1
        JOIN
    aerolineas t2 ON t1.aerolinea = t2.ICAO
GROUP BY t2.ICAO , t1.aerolinea
ORDER BY total_vuelos DESC
LIMIT 1

-- ¿Cuantas millas se recorrieron en total el día 2021-12-31?
SELECT 
    SUM(t2.distancia_millas) AS total_millas
FROM
    vuelos t1
        JOIN
    distancias t2 ON t1.aeropuerto_origen = t2.aeropuerto_origen
        AND t1.aeropuerto_destino = t2.aeropuerto_destino
WHERE
    t1.fecha = '2021-12-31';

-- Muestra en orden los 5 días con más retrasos y la media de retraso para cada día.

SELECT 
    fecha, count(*) AS cantidad_vuelos,
    (SUM(tiempo_retraso_aerolinea) + SUM(tiempo_retraso_clima) + SUM(tiempo_retraso_sistema_aviacion) + SUM(tiempo_retraso_seguridad) + SUM(retraso_llegada) + SUM(retraso_salida)) AS total_retraso,
    (SUM(tiempo_retraso_aerolinea) + SUM(tiempo_retraso_clima) + SUM(tiempo_retraso_sistema_aviacion) + SUM(tiempo_retraso_seguridad) + SUM(retraso_llegada) + SUM(retraso_salida)) / COUNT(*) AS media_retraso
FROM
    vuelos
GROUP BY fecha
ORDER BY total_retraso DESC
LIMIT 5;

-- Muestra los nombres de las 10 aerolineas que tenga menos retraso que la media.


	SELECT 
    t2.aerolinea,
    (SUM(tiempo_retraso_aerolinea) + SUM(tiempo_retraso_clima) + SUM(tiempo_retraso_sistema_aviacion) + SUM(tiempo_retraso_seguridad) + SUM(retraso_llegada) + SUM(retraso_salida)) / COUNT(*) AS media_retraso_general
FROM
    vuelos t1
        JOIN
    aerolineas t2 ON t1.aerolinea = t2.ICAO
GROUP BY t2.aerolinea
HAVING media_retraso_general < (SELECT 
        (SUM(tiempo_retraso_aerolinea) + SUM(tiempo_retraso_clima) + SUM(tiempo_retraso_sistema_aviacion) + SUM(tiempo_retraso_seguridad) + SUM(retraso_llegada) + SUM(retraso_salida)) / COUNT(*) AS media_retraso_aerolinea
    FROM
        vuelos t1)
ORDER BY media_retraso_general ASC
LIMIT 10;
    
    
    SELECT *
    FROM vuelos
    LIMIT 10;
     








