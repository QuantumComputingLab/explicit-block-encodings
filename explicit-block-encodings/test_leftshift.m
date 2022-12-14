% test_leftshift.m

n = 3;

%% matrix
L = circshift(eye(2^n),-1,2);

%% circuit
circuit = leftshift(n);
circuit.draw;

U = circuit.matrix;
if n < 6
    U
end
assert(norm(L - U) < 1e-14);



n = 5;

targets = [2,3,4];
controls = [0,1];
controlStates = [1,0];
circuit = leftshift(n,targets,controls,controlStates);
circuit.draw;

