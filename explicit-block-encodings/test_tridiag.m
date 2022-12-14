% test_tridiag.m

n = 3;
a = 0.3;
b = 0.5;
c = 0.7;

%% matrix
A = diag(a*ones(2^n,1)) + diag(b*ones(2^n-1,1),-1) + diag(c*ones(2^n-1,1),1);

%% circuit
circuit = tridiag(n,a,b,c);

A
circuit.draw;

U = circuit.matrix;
M = 4*U(1:2^n,1:2^n)
assert(norm(A - M) < 1e-14);
assert(norm(U'*U - eye(size(U))) < 1e-14);
