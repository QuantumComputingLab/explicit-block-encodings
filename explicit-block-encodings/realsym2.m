function [circuit,A,OA,OC,D] = realsym2(alpha1,alpha2)
%realsym2   Block-encoding circuit of real symmetric 2x2 matrix.
%   circuit = realsym2(alpha1,alpha2) constructs the quantum circuit that
%   block-encodes the matrix
%
%       A = [ alpha1  alpha2 ]
%           [ alpha2  alpha1 ]
%
%   where |alpha1| <= 1 and |alpha2| <= 1.
%
%   [circuit,A,OA,OC,D] = realsym2(alpha1,alpha2) also returns the matrix A,
%   and the OA, OC, and diffusion (D) subcircuits.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236

%% checks
assert(abs(alpha1) <= 1);
assert(abs(alpha2) <= 1);

%% real symmetric 2x2 matrix
A = [alpha1, alpha2; alpha2, alpha1];

%% diffusion circuit
D = qclab.QCircuit(1,1);
D.push_back(qclab.qgates.Hadamard(0));

%% rotational angles
phi1 = acos(alpha1) + acos(alpha2);
phi2 = acos(alpha1) - acos(alpha2);

%% OA circuit
OA = qclab.QCircuit(3);
OA.push_back(qclab.qgates.RotationY(0,phi1));
OA.push_back(qclab.qgates.CNOT(1,0));
OA.push_back(qclab.qgates.RotationY(0,phi2));
OA.push_back(qclab.qgates.CNOT(1,0));

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
