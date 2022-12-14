function circuit = leftshift(n,targets,controls,controlStates)
%LEFTSHIFT  Left shift circuit.
%   circuit = LEFTSHIFT(n) constructs the n-qubit quantum circuit that
%   performs the left shift corresponding to the following unitary
%
%           [ 0           1 ]
%           [ 1  0          ]
%       L = [    1  .       ]
%           [       .  .    ]
%           [          1  0 ]
%
%   circuit = LEFTSHIFT(n,targets,controls) constructs the n-qubit quantum
%   circuit that performs the left shift on the target qubits in TARGETS
%   controlled by the qubits in CONTROLS.
%
%   circuit = LEFTSHIFT(n,targets,controls,controlStates) constructs the
%   n-qubit quantum circuit that performs the left shift on the target
%   qubits in TARGETS conrtolled by the qubits in CONTROLS with control
%   states in CONTROLSTATES.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236
%
%   See also RIGHTSHIFT.

%% arguments
if nargin < 2, targets = 0:n-1; end
if nargin < 3, controls = []; end
if nargin < 4, controlStates = ones(size(controls)); end

%% checks
assert(n > 0);
assert(all(0 <= targets) & all(targets < n));
assert(all(0 <= controls) & all(controls < n));
assert(isempty(intersect(targets,controls)));
assert(length(controls) == length(controlStates));

%% circuit
circuit = qclab.QCircuit(n);
for i = 2:length(targets)
    % control qubits
    ctrl = [controls,targets(i:end)];
    % target qubit
    targ = targets(i-1);
    % control states
    ctrlStates = [controlStates,ones(size(targets(i:end)))];
    % controlled X gate
    circuit.push_back(qclab.qgates.MCX(ctrl,targ,ctrlStates));
end
% (controlled) X gate
if isempty(controls)
    circuit.push_back(qclab.qgates.PauliX(targets(end)));
else
    circuit.push_back(qclab.qgates.MCX(controls,targets(end),controlStates));
end

end
