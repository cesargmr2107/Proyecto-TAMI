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