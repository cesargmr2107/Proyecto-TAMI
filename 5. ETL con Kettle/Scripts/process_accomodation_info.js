// Replace null number of WCs with average
if (num_banhos == null) {
	var num_banhos = media_banhos;
}


// Discretize night cost
var discrete_cost;
if (precio_noche < 100) {
    discrete_cost = "<100";    
} else if(precio_noche >= 100 && precio_noche < 200) {
    discrete_cost = "[100,200)";
} else if(precio_noche >= 200 && precio_noche < 300) {
    discrete_cost = "[200,300)";
} else if(precio_noche >= 300 && precio_noche < 400) {
    discrete_cost = "[300,400)";
} else if(precio_noche >= 400 && precio_noche < 500) {
    discrete_cost = "[400,500)";
} else {
    discrete_cost = ">=500";
}
var precio_noche = discrete_cost;

var discrete_area;
if (superficie < 50) {
    discrete_area = "Pequeño";
} else if (superficie >= 50 && superficie < 100){
    discrete_area = "Mediano";
} else {
    discrete_area = "Grande";
}
var superficie = discrete_area;