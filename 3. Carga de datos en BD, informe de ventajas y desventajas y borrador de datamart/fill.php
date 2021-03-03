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

function updateFechaSalida() {
    $mysql = ConnectDB();

    $sql = "SELECT * FROM CLIENTE_RESERVA_ESP_HOSPEDAJE";

    if (!$reservas = $mysql->query($sql)) {
        return false;
    }    

    while ($reserva = mysqli_fetch_assoc($reservas)) {
        $id_reserva = $reserva["ID_RESERVA"];
        $noches = rand(1,20);
        $fecha_entrada = strtotime($reserva["FECHA_ENTRADA"]);
        $fecha_toret = date("Y-m-d", strtotime(' +'.$noches.' day', $fecha_entrada));
        
        $sql = "UPDATE 
                    CLIENTE_RESERVA_ESP_HOSPEDAJE 
                SET
                    FECHA_SALIDA = '". $fecha_toret ."' 
                WHERE
                    ID_RESERVA = '". $id_reserva ."';
                ";
        if ( !$result = $mysql->query($sql)) {
            print ("Error añadiendo la nueva fecha");
        }
    }
}
updateFechaSalida();

?>