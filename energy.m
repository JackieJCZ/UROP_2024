function [E, gE] = energy(U, Coeff, gradCoeff)
    U = reshape(U, length(U) / 2, 2);
    E = 0;
    gE = gradCoeff * U;
    [ii, jj, kk] = find(Coeff);
    for i = 1:length(ii)
        E = E + kk(i) * norm(U(ii(i), :) - U(jj(i), :))^2;
    end
    gE = gE(:);
end