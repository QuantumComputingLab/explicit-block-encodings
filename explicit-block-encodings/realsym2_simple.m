function [circuit,A,OA,OC,D] = realsym2_simple(alpha1,alpha2)
%
%   Matrix
%
%       [ alpha1  alpha2 ]
%       [ alpha2  alpha1 ]
%

%% checks
assert(abs(alpha1) <= 1);
assert(abs(alpha2) <= 1);

%% real symmetric 2x2 matrix
A = [alpha1, alpha2; alpha2, alpha1];

%% diffusion circuit
D = qclab.QCircuit(1,1);
D.push_back(qclab.qgates.Hadamard(0));

%% rotational angles
theta1 = 2*acos(alpha1);
theta2 = 2*acos(alpha2);

%% OA circuit
OA = qclab.QCircuit(3);
OA.push_back(qclab.qgates.CRotationY(1,0,theta1,0));
OA.push_back(qclab.qgates.CRotationY(1,0,theta2,1));

%% OC circuit
OC = qclab.QCircuit(2,1);
OC.push_back(qclab.qgates.CNOT(0,1));

%% circuit
circuit = qclab.QCircuit(3);
circuit.push_back(D);
circuit.push_back(OA);
circuit.push_back(OC);
circuit.push_back(D);

end
