
main {
	var src = new IloOplModelSource("P1.mod");
	var def = new IloOplModelDefinition(src);
	var cplex = new IloCplex();
	var model = new IloOplModel(def,cplex);
	var data = new IloOplDataSource("P1.dat");
	
	model.addDataSource(data);
	model.generate();

	for (var i = 1; i <= model.nCPUs; i++)
		model.rc[i] = model.rc[i] * (1-0.276226);

	cplex.epgap = 0.01;

	if (cplex.solve()) {
		writeln("Max load " + 100 * cplex.getObjValue() + "%");

		for (var c = 1; c <= model.nCPUs; c++) {
			var load = 0;

			for (var t = 1; t <= model.nTasks; t++)
				load += (model.rt[t] * model.x_tc[t][c]);

			load = (1/model.rc[c]) * load;
			writeln("CPU " + c + " loaded at " + 100 * load + "%");
		}
		
		// Display model solutions
		for (var c = 1; c <= model.nCPUs; c++) {
			var load = 0;

			for (var t = 1; t <= model.nTasks; t++) {
			  write("" + model.x_tc[t][c] + " ");
			}
			writeln("");
		}
					writeln("Z: " + cplex.getObjValue() + " ");
		
				
	} else {
		writeln("Not solution found");
	}

	model.end();
	data.end();
	def.end();
	cplex.end();
	src.end();
};
