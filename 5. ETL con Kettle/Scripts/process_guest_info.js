// Discretize age

var grupo_edad;
if (edad < 25) {
    grupo_edad = "<25";
} else if (edad >= 25 && edad < 40) {
    grupo_edad = "[25,40)";
} else if (edad >= 40 && edad < 65) {
    grupo_edad = "[40,65)";
} else {
    grupo_edad = ">=65";
}

// Numerize civil status
var opciones_civiles = {
    "Soltero" : 0,
    "Casado" : 1,
    "Divorciado" : 2,
    "Viudo" : 3
}
var situacion_civil_num = opciones_civiles[situacion_civil]
