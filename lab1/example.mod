int nProds = 5;
int nResources = 3;

range Prods = 1..nProds;
range Resources = 1..nResources;

dvar float+ x[Prods];

float profit[Prods] = [550, 600, 350, 400, 200];

float consum[Resources][Prods] = [
	[12, 20,  0, 25, 15],
	[10,  8, 16,  0,  0],
	[20, 20, 20, 20, 20]
];

float avail[Resources] = [
	288,
	192,
	384
];

maximize sum(p in Prods) profit[p] * x[p];

subject to {
  forall (r in Resources)
    sum(p in Prods) consum[r][p] * x[p] <= avail[r];
}