function circuit = ucry(theta)
%UCRY   Uniformly Controlled Rotation along the Pauli-Y axis.
%   circuit = UCRY(theta) constructs the quantum circuit that implements
%   the unitary
%
%               [ c1        -s1          ]
%               [      .          .      ]
%               [         cN         -sN ]
%       UCRy =  [ s1         c1          ]
%               [      .          .      ]
%               [         sN         cN  ]
%
%   where ci = cos(theta(i)/2) and si = sin(theta(i)/2). If the length of
%   the vector theta is not a power of 2, it is zero-padded until the
%   length reaches the next power of 2.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236

%% parameters
N = length(theta);
n = ceil(log2(N));

%% 0-padding
if N ~= 2^n
    theta(2^n) = 0;
end

%% transform data
thetat = grayPermutation(sfwht(theta));

%% circuit
circuit = qclab.QCircuit(n+1);
for i = 1:2^n
    ctrl = n - log2(bitxor(grayCode(i-1),grayCode(i))) - 1;
    if i == 2^n
        ctrl = 0;
    end
    circuit.push_back(qclab.qgates.RotationY(0,thetat(i)));
    circuit.push_back(qclab.qgates.CNOT(ctrl+1,0));
end

end

function x = grayCode(x)
x = bitxor(x,bitshift(x,-1));
end

function b = grayPermutation(a)
k = log2(length(a));
b = zeros(2^k,1);
for i = 0:2^k-1
    b(i+1) = a(grayCode(i) + 1);
end
end

function a = sfwht(a)
k = log2(length(a));
for h = 1:k
    for i = 1:2^h:2^k
        for j = i:i+2^(h-1)-1
            x = a(j);
            y = a(j + 2^(h-1));
            a(j) = (x + y)/2;
            a(j + 2^(h-1)) = (x - y)/2;
        end
    end
end
end
