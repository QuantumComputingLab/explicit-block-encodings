function [circuit,OA,OC,D] = extbintree(n,alpha,beta,gamma)
%EXTBINTREE   Block-encoding circuit of extended binary tree.
%   circuit = EXTBINTREE(n,a,b,c) construct the quantum circuit that
%   block-encodes the matrix
%
%       [ c  b                   ]
%       [ b  a  b  b             ]
%       [    b  a     b  b       ]
%       [    b     a        b  b ]
%       [       b     c          ]
%       [       b        c       ]
%       [          b        c    ]
%       [          b           c ]
%
%   [circuit,OA,OC,D] = EXTBINTREE(n,a,b,c) also returns the OA, OC, and
%   diffusion (D) subcircuits.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236

%% checks
assert(0 <= alpha); assert(alpha <= 1);
assert(0 <= beta ); assert(beta  <= 1);
assert(0 <= gamma); assert(gamma <= 1);

%% diffusion circuit
D = qclab.QCircuit(3,1);
D.push_back(qclab.qgates.Hadamard(0));
D.push_back(qclab.qgates.Hadamard(1));
D.push_back(qclab.qgates.Hadamard(2));

%% OA circuit
theta0 = 2*acos(beta);
theta1 = 2*acos(alpha/4);
theta2 = 2*acos(gamma/4);
theta3 = 2*acos(gamma/4 - beta/2) - theta1;
OA = qclab.QCircuit(n+5);
OA.push_back(qclab.qgates.CRotationY(1,0,theta0,0));
OA.push_back(qclab.qgates.MCRotationY([1,5],0,[1,0],theta1));
OA.push_back(qclab.qgates.MCRotationY([1,5],0,[1,1],theta2));
OA.push_back(qclab.qgates.MCRotationY([1,5:n+4],0,[1,zeros(1,n)],theta3));

%% OC circuit
OC = qclab.QCircuit(n+4,1);
OC.push_back(      mul2(n+4,3:n+3,[0,1,2],[0,0,0]));
OC.push_back(      mul2(n+4,3:n+3,[0,1,2],[0,0,1]));
OC.push_back( leftshift(n+4,4:n+3,[0,1,2],[0,0,1]));
OC.push_back(      div2(n+4,3:n+3,[0,1,2],[0,1,0]));
OC.push_back(rightshift(n+4,4:n+3,[0,1,2],[0,1,1]));
OC.push_back(      div2(n+4,3:n+3,[0,1,2],[0,1,1]));

%% circuit
circuit = qclab.QCircuit(n+5);
circuit.push_back(D);
circuit.push_back(OA);
circuit.push_back(OC);
circuit.push_back(D);

end
