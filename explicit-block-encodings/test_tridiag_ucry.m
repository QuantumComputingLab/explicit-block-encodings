% test_tridiag_ucry.m

n = 3;
a = 0.3;
b = 0.5;
c = 0.7;

%% matrix
A = diag(a*ones(2^n,1)) + diag(b*ones(2^n-1,1),-1) + diag(c*ones(2^n-1,1),1);
A(1,end) = b;
A(end,1) = c;

%% circuit
circuit = tridiag_ucry(n,a,b,c);

A
circuit.draw;

U = circuit.matrix;
M = 4*U(1:2^n,1:2^n)
assert(norm(A - M) < 1e-14);
assert(norm(U'*U - eye(size(U))) < 1e-14);
