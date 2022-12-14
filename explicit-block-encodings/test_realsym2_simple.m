% test_realsym2_simple.m

alpha1 = 0.1;
alpha2 = 0.2;

%% circuit
[circuit,A] = realsym2_simple(alpha1,alpha2);

A
circuit.draw;

U = circuit.matrix;
M = 2*U(1:2,1:2)
assert(norm(A - M) < 1e-14);
assert(norm(U'*U - eye(size(U))) < 1e-14);
