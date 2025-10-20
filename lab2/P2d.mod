
int nTasks = ...;
int nCPUs  = ...;
int K = ...;
range T = 1..nTasks;
range C = 1..nCPUs;
float rt[t in T] = ...;
float rc[c in C] = ...;

dvar boolean x_tc[t in T, c in C];
dvar float+ z;

execute {
	var totalLoad = 0;
	for (var t = 1; t <= nTasks; t++)
		totalLoad += rt[t];
	writeln("Total load " + totalLoad);

	var totalResources = 0;
	for (var c = 1; c <= nCPUs; c++)
		totalResources += rc[c];
	writeln("Total resources " + totalResources);

	if (totalLoad > totalResources) {
		writeln("Total load exceeds resources. Aborting...");
		stop();
	}
};

// Objective
minimize z;

subject to {
	// Constraint 1
	forall(t in T)
		sum(c in C) x_tc[t,c] <= 1;

	// Constraint 2
	forall(c in C)
		sum(t in T) rt[t] * x_tc[t,c] <= rc[c];

	// Constraint 3
	forall(c in C)
		z >= (1/rc[c]) * sum(t in T) rt[t] * x_tc[t,c];
	
	sum(t in T) sum(c in C) x_tc[t,c] >= nTasks - K;
	
}

execute {
	for (var c = 1; c <= nCPUs; c++) {
		var load = 0;
		for (var t = 1; t <= nTasks; t++)
			load += rt[t] * x_tc[t][c];
		load = (1/rc[c]) * load;
		writeln("CPU " + c + " loaded at " + 100 * load + "%");
	}
};