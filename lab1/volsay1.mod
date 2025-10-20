dvar float+ Gas;      // units of ammoniac gas (NH3)        to be produced
dvar float+ Chloride; // units of ammonium chloride (NH4Cl) to be produced

maximize
  40 * Gas + 50 * Chloride; /* maximize profit */

subject to {
  availability_N:             Gas + Chloride <= 50;
  availability_H:     3 * Gas + 4 * Chloride <= 180;
  availability_Cl:                  Chloride <= 40;
}
