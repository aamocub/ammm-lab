int nProds = 4;
range Prods = 1..nProds;

int nMachines = 2;
range Machines = 1..nMachines;

dvar float+ x[Prods][Machines];

float prod3_mult = 2;  // Product 3 multiplier in respect to product 2
float prod3_err = 0.05;  // Error range for prod3_mult

float time[Prods][Machines] = [
	[10, 27],
	[12, 19],
	[13, 33],
	[8, 23]
];

float maintenancePct[Machines] = [0.05, 0.07];

float profit[Prods] = [10 / nMachines, 12, 17, 8];

float space[Prods] = [0.1, 0.15, 0.5, 0.05];
float totalSpace = 50;

float machineTime = 35 * 60;

maximize sum(p in Prods) sum(m in Machines) x[p][m] * profit[p];

subject to {
Prod1:
	x[1][1] == x[1][2]; // TODO: Asumes nMachines == 2

ProductionTime:
	forall (m in Machines)
		sum(p in Prods) x[p][m] * time[p][m] <= machineTime * (1 - maintenancePct[m]);

FloorSpace:
	sum(p in Prods) sum(m in Machines) x[p][m] * space[p] <= totalSpace;

Prod2_mult_Prod3:
	sum(m in Machines) (prod3_mult - prod3_err) * x[3][m] >= sum(m in Machines) x[2][m];
	sum(m in Machines) (prod3_mult + prod3_err) * x[3][m] <= sum(m in Machines) x[2][m];
}