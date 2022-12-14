% test_realsym2.m

alpha1 = 0.3;
alpha2 = 0.7;

%% circuit
[circuit,A] = realsym2(alpha1,alpha2);

A
circuit.draw;

U = circuit.matrix;
M = 2*U(1:2,1:2)
assert(norm(A - M) < 1e-14);
assert(norm(U'*U - eye(size(U))) < 1e-14);
