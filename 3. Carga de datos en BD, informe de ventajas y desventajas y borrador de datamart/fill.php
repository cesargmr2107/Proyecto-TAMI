<?php


function ConnectDB()
{
    $connetion = new mysqli("localhost", "dbadmin", "dbadmin", "HOTEL_DB");

    if ($connetion->connect_error) {
        die("ERROR: Conecction failed " . $connetion->connect_error);
    } else {
        return $connetion;
    }
}

function updateFechaUltimaActualizacion()
{
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
                AND t.table_name='" . $entidad . "';";

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
                    " . $entidad . " 
                SET
                    ULTIMA_ACTUALIZACION = '" . $fecha . "' 
                WHERE
                    " . $pk . " = '" . $tupla[$pk] . "';
                ";
            if (!$mysql->query($sql)) {
                print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
            }
        }
    }
}
function updateFechaNacimiento()
{
    $mysql = ConnectDB();
    $sql = "SELECT * FROM PERSONA";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }
    $f1900 = -2208992400; //1900
    $f1921 = -1549065600; //1921
    $f1941 = -917913600;  //1941
    $f1961 = -286761600;  //1961
    $f1981 = 344390400;   //1981
    $f2001 = 978303600; //2001

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        $rand = rand(0, 100);

        if ($rand < 3) {
            $fecha_limite_superior = $f1900;
            $fecha_limite_inferior = $f1921;
        } elseif ($rand < 7) {
            $fecha_limite_superior = $f1921;
            $fecha_limite_inferior = $f1941;
        } elseif ($rand < 15) {
            $fecha_limite_superior = $f1941;
            $fecha_limite_inferior = $f1961;
        } elseif ($rand < 50) {
            $fecha_limite_superior = $f1961;
            $fecha_limite_inferior = $f1981;
        } else {
            $fecha_limite_superior = $f1981;
            $fecha_limite_inferior = $f2001;
        }

        $mt_random_fecha = date("Y-m-d", mt_rand($fecha_limite_superior, $fecha_limite_inferior));

        $sql = "UPDATE 
                    PERSONA 
                SET
                    FECHA_NACIMIENTO = '" . $mt_random_fecha . "' 
                WHERE
                   NUM_ID = '" . $tupla["NUM_ID"] . "';
                ";
        if (!$mysql->query($sql)) {
            print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
        }
    }
}

function updatePrecioReserva()
{
    $mysql = ConnectDB();
    $sql = "SELECT * FROM CLIENTE_RESERVA_ESP_HOSPEDAJE";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        $dias_entrada = mt_rand(1, 20);
        $dias_reserva = mt_rand(0, 400);
        $id_espacio = $tupla["ID_ESPACIO"];

        $fecha_limite_superior = 1293836400; //Hace 10 años
        $fecha_limite_inferior = 1614797076; //hoy
        $fecha_entrada = mt_rand($fecha_limite_superior, $fecha_limite_inferior);

        $fecha_salida = date("Y-m-d", strtotime(' +' . $dias_entrada . ' day', $fecha_entrada));
        $fecha_reserva = date("Y-m-d", strtotime(' -' . $dias_reserva . ' day', $fecha_entrada));

        $sql = "SELECT 
                PRECIO_NOCHE 
            FROM 
                ESPACIO_HOSPEDAJE 
            WHERE
                ID_ESPACIO = '" . $id_espacio . "'";

        if (!$result = $mysql->query($sql)) {
            print("\nError al actualizar la fecha de ÚLTIMA ACTUALIZACIÓN");
        }

        $precio = mysqli_fetch_assoc($result)["PRECIO_NOCHE"];
        $precio_total = $precio * $dias_entrada;

        $sql = "UPDATE 
                    CLIENTE_RESERVA_ESP_HOSPEDAJE 
                SET
                    FECHA_ENTRADA = '" . date("Y-m-d", $fecha_entrada) . "',
                    FECHA_SALIDA = '" . $fecha_salida . "',
                    FECHA_RESERVA = '" . $fecha_reserva . "',
                    PRECIO = '" . $precio_total . "'
                WHERE
                    ID_RESERVA = '" . $tupla["ID_RESERVA"] . "';
                ";

        if (!$mysql->query($sql)) {
            print("\nError al actualizar Precio de la reserva");
        }
    }
}

function updateDistanciasHotel()
{
    $distancias = ['< 500m', '< 1Km', '< 2Km', '< 3Km', '< 5Km'];


    $mysql = ConnectDB();
    $sql = "SELECT * FROM HOTEL ";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        //Número para una distribucion ponderada de la distancia a la playa
        $rand_playa = mt_rand(0, 10);
        if ($rand_playa > 6) {

            $sql = "UPDATE 
                            HOTEL 
                        SET
                            DISTANCIA_PLAYA = '" . $distancias[rand(0, 4)] . "',
                            DISTANCIA_CENTRO = '" . $distancias[rand(0, 4)] . "'
                        WHERE
                            ID_HOTEL = '" . $tupla["ID_HOTEL"] . "';
                        ";

            if (!$mysql->query($sql)) {
                print("\nError al actualizar Distancias del hotel");
            }
        }
    }
}

function updateLocalizacion()
{
    $distancias = ['< 500m', '< 1Km', '< 2Km', '< 3Km', '< 5Km'];
    $localizaciones = [
        ["pais" => "España", "ciudad" => "Vigo"],
        ["pais" => "España", "ciudad" => "Madrid"],
        ["pais" => "España", "ciudad" => "Barcelona"],
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

        $rand_loc = $localizaciones[mt_rand(0, 19)];
        $sql = "UPDATE 
                    HOTEL 
                SET
                    PAIS = '" . $rand_loc["pais"] . "',
                    CIUDAD = '" . $rand_loc["ciudad"] . "'
                WHERE
                    ID_HOTEL = '" . $tupla["ID_HOTEL"] . "';
                ";

        if (!$mysql->query($sql)) {
            print("\nError al actualizar las localizaciones del hotel");
        }
    }
}

function updatePaisAgencia()
{
    $paises = [
        "España", "Portugal", "Suiza", "Libano", "Suecia",
        "Canada", "Ghana", "Japon", "Grecia", "Argentina", "Venezuela",
        "Libano", "Islandia", "Irlanda", "Ejipto", "Aruba", "Estonia",
        "Lituania", "Belgica", "Laos"
    ];

    $mysql = ConnectDB();
    $sql = "SELECT * FROM AGENCIA";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {

        $rand_loc = $paises[mt_rand(0, 19)];
        $sql = "UPDATE 
                    AGENCIA 
                SET
                    PAIS_ORIGEN = '" . $rand_loc . "'
                WHERE
                    COD_AGENCIA = '" . $tupla["COD_AGENCIA"] . "';
                ";

        if (!$mysql->query($sql)) {
            print("\nError al actualizar las localizaciones de la agencia");
        }
    }
}

function cambiarPaisNacionalidadHuesped()
{
    $mysql = ConnectDB();
    $paises = [
        "España", "Portugal", "Suiza", "Libano", "Suecia",
        "Canada", "Ghana", "Japon", "Grecia", "Argentina", "Venezuela",
        "Libano", "Islandia", "Irlanda", "Ejipto", "Aruba", "Estonia",
        "Lituania", "Belgica", "Laos"
    ];

    //Limitamos los paises de residencia de la tabla Huesped
    $sql = "SELECT * FROM HUESPED";
    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        $residencia = $paises[rand(0, 19)];

        $sql = "UPDATE 
                        HUESPED 
                    SET
                        PAIS_RESIDENCIA = '" . $residencia . "',
                        NACIONALIDAD = '" . $residencia . "' 
                    WHERE
                        NUM_ID = '" . $tupla["NUM_ID"] . "';
                    ";

        if (!$mysql->query($sql)) {
            print("\nError al actualizar los paises de Huesped");
        }
    }
}

function updateResidenciaHuesped()
{
    $mysql = ConnectDB();
    $paises = [
        "España", "Portugal", "Suiza", "Libano", "Suecia",
        "Canada", "Ghana", "Japon", "Grecia", "Argentina", "Venezuela",
        "Libano", "Islandia", "Irlanda", "Ejipto", "Aruba", "Estonia",
        "Lituania", "Belgica", "Laos"
    ];
    cambiarPaisNacionalidadHuesped();

    $sql = "SELECT DISTINCT
                huesped.NUM_ID as id_huesped, 
                huesped.PAIS_RESIDENCIA as pais_huesped,
                hotel.PAIS as pais_hotel
            FROM 
                huesped, espacio, espacio_hospedaje, hotel, cliente_reserva_esp_hospedaje reserva
            WHERE 
                hotel.ID_HOTEL = espacio.ID_HOTEL AND
                huesped.ID_CLIENTE = reserva.ID_CLIENTE AND
                reserva.ID_ESPACIO = espacio_hospedaje.ID_ESPACIO AND
                espacio_hospedaje.ID_ESPACIO = espacio.ID_ESPACIO;";

    if (!$tuplas = $mysql->query($sql)) {
        return false;
    }

    while ($tupla = mysqli_fetch_assoc($tuplas)) {
        $rand = mt_rand(0, 100);
        if ($rand < 30) { //~30% son internacionales
            $sql = "UPDATE 
                        HUESPED 
                    SET
                        PAIS_RESIDENCIA = '" . $tupla["pais_hotel"] . "'
                    WHERE
                        NUM_ID = '" . $tupla["id_huesped"] . "';
                    ";

            if (!$mysql->query($sql)) {
                print("\nError al actualizar las localizaciones de la agencia");
            }
        }
    }
}

updatePaisAgencia(); //No depende de nada
updateDistanciasHotel(); //No depende de nada
updateLocalizacion(); //No depdende de nada
updatePrecioReserva(); // No depende de nada
updateFechaNacimiento(); //No depende de nada
updateFechaUltimaActualizacion(); //No depende de nada
updateResidenciaHuesped(); //Depende de que antes se hayan actualizado las localizciones de los hoteles