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