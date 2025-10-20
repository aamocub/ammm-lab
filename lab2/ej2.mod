int nCompartments = 3;
int nCargos = 4;

range Compartments = 1..nCompartments;
range Cargos = 1..nCargos;

float weightCapacity[Compartments] = [10, 16, 8];
float volumeCapacity[Compartments] = [6800, 8700, 5300];

dvar float+ x[Compartments][Cargos];

float cargoWeights[Cargos] = [18, 15, 23, 12];
float cargoVolumes[Cargos] = [480, 650, 580, 390];
float cargoProfits[Cargos] = [310, 380, 350, 285];

maximize
	sum(ct in Compartments) sum(c in Cargos) x[ct][c] * cargoProfits[c];

subject to {
	forall (ct in Compartments)
		sum(c in Cargos) x[ct][c] * cargoWeights[c] <= weightCapacity[ct];

	forall (ct in Compartments)
		sum(c in Cargos) x[ct][c] * cargoVolumes[c] <= volumeCapacity[ct];

	forall (ct in 1..nCompartments-1)
		( sum(c in Cargos) x[ct][c] * cargoWeights[c] ) / weightCapacity[ct] == ( sum(c in Cargos) x[ct + 1][c] * cargoWeights[c] ) / weightCapacity[ct + 1];
}