set Cities;
set Origin within {Cities};
set Demanders within {Cities};
#set Links within (Cities cross Cities);
set Links dimen 2;

param Cost{Links};
param DemandSupply{Cities};
param Capacity{Links};

var Shipping{Links} >= 0;

minimize TotalCost: sum {(i,j) in Links} Cost[i,j]*Shipping[i,j];

subject to Supply {i in Origin}: - sum {(i, k) in Links} Shipping [i, k] <= DemandSupply[i]; # number of contnainers leaving a city can't be higher than availability of the node 
subject to Demand {i in Demanders}: sum {(j, i) in Links} Shipping [j, i] - sum {(i, k) in Links} Shipping [i, k] == DemandSupply[i]; # what is entering a node must be == to the demand of the node
subject to Capacity_const {(i,j) in Links}: Shipping[i, j] <= Capacity[i,j];