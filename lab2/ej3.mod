int nSuppliers = 3;
int nPlants = 2;

range Suppliers = 1..nSuppliers;
range Plants = 1..nPlants;

float tonnes[Suppliers] = [200, 310, 420];
float costs[Suppliers] = [11, 10, 9];

float shippingCosts[Suppliers][Plants] = [
	[3, 3.5],
	[2, 2.5],
	[6, 4]
];

float plantCapacity[Plants] = [460, 560];
float plantLabourCosts[Plants] = [26, 21];

float profit = 50;

dvar float+ x[Suppliers][Plants];

maximize sum(s in Suppliers) sum(p in Plants) ( x[s][p] * tonnes[s] * (profit - costs[s] - shippingCosts[s][p] - plantLabourCosts[p]) );



subject to {

// TODO: El enunciado determina que las cantidades de toneladas son el máx. de los proveedores, no una especie de unidad

Capacity:
	forall (p in Plants)
		sum(s in Suppliers) x[s][p] * tonnes[s] <= plantCapacity[p];

}