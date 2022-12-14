function circuit = tridiag_cab_ucry(n,alpha,beta,gamma)
%TRIDIAG_CAB_UCRY   Block-encoding circuit of circulant tridiagonal matrix.
%   circuit = TRIDIAG_CAB_UCRY(n,a,b,c) constructs the quantum circuit that
%   block-encodes the matrix
%
%           [ a  c        b ]
%           [ b  a  c       ]
%       M = [    b  .  .    ]
%           [       .  .  c ]
%           [ c        b  a ]
%
%   where 0 <= a <= 2, |b| <= 1, and |c| <= 1.
%
%   [circuit,OA,OC,D] = TRIDIAG_CAB_UCRY(n,a,b,c) also returns the OA, OC,
%   and diffusion (D) subcircuits.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236

%% checks
assert(0 <= alpha); assert(alpha <= 2);
assert(abs(beta) <= 1); assert(abs(gamma) <= 1);

%% diffusion circuit
D = qclab.QCircuit(2,1);
D.push_back(qclab.qgates.Hadamard(0));
D.push_back(qclab.qgates.Hadamard(1));

%% OA circuit
theta0 = 2*acos(gamma);
theta1 = 2*acos(alpha - 1);
theta2 = 2*acos(beta);
OA = qclab.QCircuit(n+3);
OA.push_back(ucry([theta0,theta1,theta2]));

%% OC circuit
OC = qclab.QCircuit(n+2,1);
OC.push_back(rightshift(n+2,2:n+1,[0,1],[0,0]));
OC.push_back( leftshift(n+2,2:n+1,[0,1],[1,0]));

%% circuit
circuit = qclab.QCircuit(n+3);
circuit.push_back(D);
circuit.push_back(OA);
circuit.push_back(OC);
circuit.push_back(D);

end
