% test_extbintree.m

n = 3;
a = 0.2;
b = 0.3;
c = 0.7;
% b = 0.3;
% a = 1 - 3*b;
% c = 1 - b;

%% matrix
A = zeros(2^n);
for r = 2:2^n
    A(r,ceil(r/2)) = b;
end
A = A + A' + diag([c;a*ones(2^(n-1)-1,1);c*ones(2^(n-1),1)]);

%% circuit
circuit = extbintree(n,a,b,c);

A
circuit.draw;

U = circuit.matrix;
M = 8*U(1:2^n,1:2^n)
assert(norm(A - M) < 1e-14);
assert(norm(U'*U - eye(size(U))) < 1e-14);
