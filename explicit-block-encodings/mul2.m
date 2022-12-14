function circuit = mul2(n,targets,controls,controlStates)
%MUL2   Multiply by 2 circuit.
%   circuit = MUL2(n) constructs the n-qubit quantum circuit that
%   performs the multiplication by 2 on the computational basis states.
%   The first qubit is used as ancilla and should be initialized by |0>.
%
%   circuit = MUL2(n,targets,controls) constructs the n-qubit quantum
%   circuit that performs the multiplication by 2 on the target qubits
%   in TARGETS controlled by the qubits in CONTROLS.
%
%   circuit = MUL2(n,targets,controls,controlStates) constructs the
%   n-qubit quantum circuit that performs the multiplication by 2 on the
%   target qubits in TARGETS conrtolled by the qubits in CONTROLS with
%   control states in CONTROLSTATES.
%
%   This script uses the QCLAB toolbox available through:
%       https://github.com/QuantumComputingLab/qclab
%
%   Reference:
%   D. Camps, L. Lin, R. Van Beeumen, C. Yang, Explicit quantum circuits for
%   block encodings of certain sparse matrices. 2022.
%   https://doi.org/10.48550/arXiv.2203.10236
%
%   See also DIV2.

%% uncontrolled circuit
if nargin == 1
    circuit = qclab.QCircuit(n);
    for i = 1:n-1
        circuit.push_back(qclab.qgates.SWAP(i-1,i));
    end
    return
end

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
for i = 1:length(targets)-1
    % control qubits
    ctrl1 = [controls,targets(i)];
    ctrl2 = [controls,targets(i+1)];
    % target qubit
    targ1 = targets(i+1);
    targ2 = targets(i);
    % control states
    ctrlStates = [controlStates,1];
    % controlled X gates
    circuit.push_back(qclab.qgates.MCX(ctrl1,targ1,ctrlStates));
    circuit.push_back(qclab.qgates.MCX(ctrl2,targ2,ctrlStates));
    circuit.push_back(qclab.qgates.MCX(ctrl1,targ1,ctrlStates));
end

end
