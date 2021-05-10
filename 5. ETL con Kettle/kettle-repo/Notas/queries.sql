SELECT
    c.ID_CLIENTE AS id_cliente,
    COMO_CONOCISTE AS Descubrimiento,
    FAMILIA_NUMEROSA AS tiene_familia_numerosa,
    PAIS_RESIDENCIA AS pais_residencia,
    FECHA_NACIMIENTO AS fecha_nacimiento,
    GENERO AS genero,
    NACIONALIDAD AS nacionalidad,
    ES_VIP AS es_cliente_vip,
    ESTADO_CIVIL AS situacion_civil,
    MEDIO_TRANSPORTE AS medio_transporte,

    GREATEST( c.ULTIMA_ACTUALIZACION,
        GREATEST(
            h.ULTIMA_ACTUALIZACION,
            p.ULTIMA_ACTUALIZACION
        )
    ) AS ultima_actualizacion_huesped
FROM 
    cliente c, huesped h, persona p
WHERE
    c.ID_CLIENTE = h.ID_CLIENTE AND p.NUM_ID = h.NUM_ID
    GREATEST( c.ULTIMA_ACTUALIZACION,
        GREATEST(
            h.ULTIMA_ACTUALIZACION,
            p.ULTIMA_ACTUALIZACION
        )
    ) > ?


SELECT
    ID_RESERVA as id_reserva,
    ID_CLIENTE as id_cliente,
    ID_ESPACIO as id_espacio,
    FECHA_RESERVA as fecha_reserva,
    FECHA_ENTRADA as fecha_entrada,
    FECHA_SALIDA as fecha_salida,
    PRECIO as precio,
    PORC_DESCUENTO as porc_descuento
FROM reserva
WHERE ULTIMA_ACTUALIZACION > ? 	


SELECT 
    reserva_key,
    id_reserva,
    numero_reservas,
    descuento_aplicado,
    importe_medio,
    importe_bruto,
    importe_final,
    duracion,
    ultima_actualizacion_reserva,
    fact_reserva.huesped_key,
    id_cliente,
    descubrimiento,
    tiene_familia_numerosa,
    edad,
    genero,
    nacionalidad,
    es_cliente_vip,
    situacion_civil,
    medio_transporte,
    ingresos_medios,
    pais_residencia,
    huesped_num_version,
    huesped_valido_desde,
    huesped_valido_hasta,
    ultima_actualizacion_huesped,
    fact_reserva.espacio_hospedaje_key,
    id_espacio,
    num_banhos,
    num_camas,
    tiene_terraza,
    admite_fumadores,
    admite_mascotas,
    tiene_cancelacion_gratis,
    tiene_movilidad_adaptada,
    precio_noche,
    luminosidad,
    tipo_alojamiento,
    superficie,
    tiene_internet,
    tiene_vistas,
    tiene_climatizacion,
    ultima_actualizacion_hospedaje,
    fact_reserva.hotel_key,
    id_hotel,
    distancia_playa,
    distancia_centro,
    temperatura,
    poblacion,
    servicio_habitaciones,
    ingresos,
    valoracion,
    tiene_ascensor,
    traslado_aeropuerto,
    parking,
    presupuesto,
    pres_marketing,
    pais,
    estrellas,
    tipo_hotel,
    ciudad,
    activo,
    ultima_actualizacion_hotel,
    dim_fecha_entrada.date_key AS fecha_entrada_key,
    dim_fecha_entrada.date_value AS entrada_date_value,
    dim_fecha_entrada.day_in_month AS entrada_day_in_month,
    dim_fecha_entrada.day_name AS entrada_day_name,
    dim_fecha_entrada.is_first_day_in_month AS entrada_is_first_day_in_month,
    dim_fecha_entrada.is_last_day_in_month AS entrada_is_last_day_in_month,
    dim_fecha_entrada.month_number AS entrada_month_number,
    dim_fecha_entrada.week_in_year AS entrada_week_in_year,
    dim_fecha_entrada.quarter_number AS entrada_quarter_number,
    dim_fecha_entrada.year4 AS entrada_year4,
    dim_fecha_salida.date_key AS fecha_salida_key ,
    dim_fecha_salida.date_value AS salida_date_value ,
    dim_fecha_salida.day_in_month AS salida_day_in_month ,
    dim_fecha_salida.day_name AS salida_day_name ,
    dim_fecha_salida.is_first_day_in_month AS salida_is_first_day_in_month ,
    dim_fecha_salida.is_last_day_in_month AS salida_is_last_day_in_month ,
    dim_fecha_salida.month_number AS salida_month_number ,
    dim_fecha_salida.week_in_year AS salida_week_in_year ,
    dim_fecha_salida.quarter_number AS salida_quarter_number ,
    dim_fecha_salida.year4 AS salida_year4
FROM fact_reserva, dim_huesped, dim_espacio_hospedaje, dim_hotel, dim_fecha dim_fecha_entrada, dim_fecha dim_fecha_salida
WHERE fact_reserva.espacio_hospedaje_key = dim_espacio_hospedaje.espacio_hospedaje_key AND
	  fact_reserva.hotel_key = dim_hotel.hotel_key AND
      fact_reserva.huesped_key = dim_huesped.huesped_key AND
      fact_reserva.fecha_entrada_key = dim_fecha_entrada.date_key AND
      fact_reserva.fecha_salida_key = dim_fecha_salida.date_key