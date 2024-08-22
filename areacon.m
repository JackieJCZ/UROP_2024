function [c, ceq] = areacon(U, Xt)
%AREACON Summary of this function goes here
%   Detailed explanation goes here
N = length(U) / 2;
U = reshape(U, N, 2);
r12 = U(Xt(2, :), :) - U(Xt(1, :), :);
r13 = U(Xt(3, :), :) - U(Xt(1, :), :);
c = r12(:, 2) .* r13(:, 1) - r12(:, 1) .* r13(:, 2);
ceq = [];
end

