set Cities;
set Origin within {Cities};
set Demanders within {Cities};
#set Links within (Cities cross Cities);
set Links dimen 2;

param Cost{Links};
param DemandSupply{Cities};
param Capacity{Links};
param ActivationCost{Links};
param Budget;

var Shipping{Links} >= 0;
var IsUsed{Links} binary;

minimize TotalCost: sum {(i,j) in Links} Cost[i,j]*Shipping[i,j] + 
	sum {(i, j) in Links} ActivationCost[i,j]*IsUsed[i,j];

subject to Supply {i in Origin}: - sum {(i, k) in Links} Shipping [i, k] <= DemandSupply[i]; # number of contnainers leaving a city can't be higher than availability of the node 
subject to Demand {i in Demanders}: sum {(j, i) in Links} Shipping [j, i] - sum {(i, k) in Links} Shipping [i, k] == DemandSupply[i]; # what is entering a node must be == to the demand of the node
subject to Capacity_constr {(i,j) in Links}: Shipping[i, j] <= Capacity[i,j];

#subject to ActivationBudget {(i,j) in Links}: sum {(i,j)in Links} IsUsed[i,j]*ActivationCost[i,j]<= 500;
#subject to ActivationBudget :  sum { (i,j) in ActivatedLinks} IsUsed[i,j] * ActivationCost[i,j] <= 500; 
#sum {(i,j) in Links} ActivationCost[i,j]*IsUsed[i,j] <= 500;
#subject to ActivationBudget {(i,j) in Links}: ActivationCost[i,j] * IsUsed[i,j] <= Budget;
subject to LinkActivation {(i,j) in Links}: 
Shipping[i,j] <= Capacity[i,j]*IsUsed[i,j];
subject to ActivationBudget  : sum {(i,j) in Links}ActivationCost[i,j]*IsUsed[i,j] <= Budget;

# subject to Capacity {(i,j) in Links}: Ship[i, j] <= Cap[i,j]; per ogni elemento in Links iterami sulla quantità trasportata su quell'elemento e rendila <= alla capacità massima del link

# subject to Supply {i in Origins}: - sum {(i, k) in Links} Ship [i, k] >= DemSupp[i]; per ogni elemento (in ordine) in origin sommami la quantità dell'elemento i e rendila >= alla domanda del nodo in questione. 
