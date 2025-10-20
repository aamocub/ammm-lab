int nProds = 3;
int nWorkstations = 4;

range Prods = 1..nProds;
range Workstations = 1..nWorkstations;

dvar float+ x[Prods][Workstations];

float consum[Prods][Workstations] = [
	[ 5,  7,  4, 10],
	[ 6, 12,  8, 15],
	[13, 14,  9, 17]
];

float profit[Prods][Workstations] = [
	[10,  8,  6,  9],
	[18, 20, 15, 17],
	[15, 16, 13, 17]
];

float avail = 35 * 60;

float minRequired[Prods] = [100, 150, 100];

maximize
	sum(w in Workstations) sum(p in Prods) x[p][w] * profit[p][w];

subject to {
	forall (p in Prods)
		sum(w in Workstations) x[p][w] >= minRequired[p];

	forall (w in Workstations)
		sum(p in Prods) x[p][w] * consum[p][w] <= avail;
}
