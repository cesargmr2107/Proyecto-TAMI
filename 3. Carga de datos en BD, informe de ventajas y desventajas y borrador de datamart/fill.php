<?php 


function ConnectDB()
{
    $connetion = new mysqli("localhost", "dbadmin", "dbadmin", "HOTEL_DB");

    if ($connetion->connect_error) {
        die ("ERROR: Conecction failed " . $connetion->connect_error);
    }
    else {
        return $connetion;
    }
}

function updateFechaUltimaActualizacion () {
    $mysql = ConnectDB();

    $entidades = ["CLIENTE", "HOTEL", "AGENCIA", "APARTAMENTO", "ESPACIO", "ESPACIO_HOSPEDAJE", "ESPACIO_INSTALACION", "HABITACION", "HUESPED", "PERSONA"];

    foreach ($entidades as $entidad) {
        $sql = "SELECT * FROM " . $entidad;

        if (!$tuplas = $mysql->query($sql)) {
            return false;
        }
        
        $sql = "SELECT k.column_name
                FROM information_schema.table_constraints t
                JOIN information_schema.key_column_usage k
                USING (constraint_name,table_schema,table_name)
                WHERE t.constraint_type='PRIMARY KEY'
                AND t.table_name='". $entidad ."';";

        if (!$pks = $mysql->query($sql)) {
            return false;
        }
        
        $pk = mysqli_fetch_assoc($pks)["column_name"];
        $stamp_inicio = 1299106800; //2011
        $stamp_fin = 1614726000; // Hoy
        
        while ($tupla = mysqli_fetch_assoc($tuplas)) {

            $mt_random_stamp = mt_rand($stamp_inicio, $stamp_fin);
            $fecha = date("Y-m-d", $mt_random_stamp);

            $sql = "UPDATE 
                    ". $entidad ." 
                SET
                    ULTIMA_ACTUALIZACION = '". $fecha ."' 
                WHERE
                    ".$pk." = '". $tupla[$pk] ."';
                ";
                if (!$mysql->query($sql)) {
                    print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
                }
        }
    }
}
function updateFechaNacimiento(){
    $mysql = ConnectDB();
    $sql = "SELECT * FROM PERSONA";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }
    $fecha_limite_superior = -2208992400; //1900
    $fecha_limite_inferior = 978303600; //2001

    while ($tupla = mysqli_fetch_assoc($tuplas)) {

        $mt_random_fecha = date("Y-m-d", mt_rand($fecha_limite_superior, $fecha_limite_inferior));
        
        $sql = "UPDATE 
                    PERSONA 
                SET
                    FECHA_NACIMIENTO = '". $mt_random_fecha ."' 
                WHERE
                   NUM_ID = '". $tupla["NUM_ID"] ."';
                "
        ;
        if (!$mysql->query($sql)) {
            print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
        }
    }
}

function updatePrecioReserva () {
    $mysql = ConnectDB();
    $sql = "SELECT * FROM CLIENTE_RESERVA_ESP_HOSPEDAJE";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        $dias_entrada = mt_rand(1,20);
        $dias_reserva = mt_rand(0,400);
        $id_espacio = $tupla["ID_ESPACIO"];

        $fecha_limite_superior = 1293836400; //Hace 10 años
        $fecha_limite_inferior = 1614797076; //hoy
        $fecha_entrada = mt_rand($fecha_limite_superior, $fecha_limite_inferior);

        $fecha_salida = date("Y-m-d", strtotime(' +'.$dias_entrada.' day', $fecha_entrada));
        $fecha_reserva = date("Y-m-d", strtotime(' -'.$dias_reserva.' day', $fecha_entrada));

        $sql = "SELECT 
                PRECIO_NOCHE 
            FROM 
                ESPACIO_HOSPEDAJE 
            WHERE
                ID_ESPACIO = '". $id_espacio ."'";
        
        if (!$result = $mysql->query($sql)) {
            print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
        }

        $precio = mysqli_fetch_assoc($result)["PRECIO_NOCHE"];
        $precio_total = $precio * $dias_entrada;

        $sql = "UPDATE 
                    CLIENTE_RESERVA_ESP_HOSPEDAJE 
                SET
                    FECHA_ENTRADA = '". date("Y-m-d", $fecha_entrada)."',
                    FECHA_SALIDA = '". $fecha_salida ."',
                    FECHA_RESERVA = '". $fecha_reserva ."',
                    PRECIO = '". $precio_total ."'
                WHERE
                    ID_RESERVA = '". $tupla["ID_RESERVA"] ."';
                "
        ;

        if (!$mysql->query($sql)) {
            print("\nError al actualizar Precio de la reserva");
        }
    }
} 
function updateLocalizacion() {
    $localizaciones = [
        ["pais" => "Espanha", "ciudad" => "Vigo"],
        ["pais" => "Espanha", "ciudad" => "Madrid"],
        ["pais" => "Espanha", "ciudad" => "Barcelona"],
        ["pais" => "Libano", "ciudad" => "Beirut"],
        ["pais" => "Argentina", "ciudad" => "Buenos Aires"],
        ["pais" => "Argentina", "ciudad" => "Mar del Plata"],
        ["pais" => "Venezuela", "ciudad" => "Caracas"],
        ["pais" => "Venezuela", "ciudad" => "Maracay"],
        ["pais" => "Islandia", "ciudad" => "Reiquiavik"],
        ["pais" => "Islandia", "ciudad" => "Vestmannaeyjar"],
        ["pais" => "Suiza", "ciudad" => "Zug"],
        ["pais" => "Suiza", "ciudad" => "Berna"],
        ["pais" => "Japon", "ciudad" => "Hokkaido"],
        ["pais" => "Japon", "ciudad" => "Tokio"],
        ["pais" => "Grecia", "ciudad" => "Atenas"],
        ["pais" => "Grecia", "ciudad" => "Tripoli"],
        ["pais" => "Ghana", "ciudad" => "Kumasi"],
        ["pais" => "Ghana", "ciudad" => "Acra"],
        ["pais" => "Canada", "ciudad" => "Vancouver"],
        ["pais" => "Canada", "ciudad" => "Toronto"]
    ];

    $mysql = ConnectDB();
    $sql = "SELECT * FROM HOTEL ";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) { 
        $rand_loc = $localizaciones[mt_rand(0,19)];
        $sql = "UPDATE 
                    HOTEL 
                SET
                    LOCALIDAD = '". $rand_loc["pais"] ."',
                    PROVINCIA = '". $rand_loc["ciudad"] ."'
                WHERE
                    ID_HOTEL = '". $tupla["ID_HOTEL"] ."';
                "
        ;

        if (!$mysql->query($sql)) {
            print("\nError al actualizar Precio de la reserva");
        }
    
    }
}

updateLocalizacion();
updatePrecioReserva();
updateFechaNacimiento();
updateFechaUltimaActualizacion();

// He actualizado:
// --> TABLA RESERVA:
//     ->FECHA RESERVA 
//     ->FECHA ENTRADA
//     ->FECHA SALIDA
//     ->PRECIO 
//     #TODAS LAS FECHAS Y PRECIO CONCUERDAN ENTRE SI Y TIENEN UNA ANTIGUEDAD DE 10 años.

// --> TABLA PERSONA:
//     ->FECHA DE NACIMIENTO 
//     #EDAD entre 0 - 120 años

// --> TABLAS ENTIDADES:
//     ->ULTIMA_ACTUALIZACIÓN 
//     #SE HA CALCULADO UNA FECHA DE ACTUALIZACIÓN DE ACORDE A UN HISTÓRICO DE 10 AÑOS

?>