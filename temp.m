lam = 1; mu = 0;
X = source; C = target;
[Elam, Emu, gElam, gEmu] = coeffs(X);
M = size(X.e, 2);
N = size(X.p, 2);
fun = @(x) energy(x, sparse(Elam * lam + Emu * mu), sparse(gElam * lam + gEmu * mu));
A = [];
b = [];
lb = [];
ub = [];
x0 = x0(:);
Aeq = [eye(M, N) zeros(M, N); zeros(M, N) eye(M, N)];
beq = C(:);

options = optimoptions('fmincon','Display','iter');
nonlcon = @(x) areacon(x, X.t);
[U,min_E] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);