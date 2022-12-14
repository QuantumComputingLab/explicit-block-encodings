% test_rightshift.m

n = 3;

%% matrix
R = circshift(eye(2^n),1,2);

%% circuit
circuit = rightshift(n);
circuit.draw;

U = circuit.matrix;
if n < 6
    U
end
assert(norm(R - U) < 1e-14);



n = 5;

targets = [2,3,4];
controls = [0,1];
controlStates = [1,0];
circuit = rightshift(n,targets,controls,controlStates);
circuit.draw;

