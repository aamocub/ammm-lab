/*********************************************
 * OPL 22.1.1.0 Model
 * Author: aamocub
 * Creation Date: Sep 29, 2025 at 1:16:01 PM
*********************************************/
main {

var src = new IloOplModelSource("P1.mod");
var def= new IloOplModelDefinition(src);
var cplex = new IloCplex();
var model= new IloOplModel(def,cplex);
var data = new IloOplDataSource("P1.dat");
model.addDataSource(data);
model.generate();
cplex.epgap=0.01;
if (cplex.solve()) {
writeln("Max load " + 100 * cplex.getObjValue() + "%");
for (var c=1;c<=model.nCPUs;c++) {
var load=0;
for (var t=1;t<=model.nTasks;t++)
load+=(model.rt[t]* model.x
tc[t][c]);
load= (1/model.rc[c])*load;
writeln("CPU " + c + " loaded at " + 100 * load +
"%");
}
}
else {
}
model.end();
data.end();
def.end();
cplex.end();
src.end();
writeln("Not solution found");

}
;
;