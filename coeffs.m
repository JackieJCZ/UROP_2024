function [Elam, Emu, gElam, gEmu] = coeffs(X)
    N = size(X.p, 2);
    Elam = zeros(N, N); Emu = zeros(N,N);
    gElam = zeros(N, N); gEmu = zeros(N, N);
    int_nodes = setdiff(1:1:size(X.p, 2), X.e(1, :));
    for face = 1:size(X.t,2)
        s.index = X.t(:, face);
        s.coords = X.p(:, s.index);
        s.edges = s.coords(:, [3, 1, 2]) - s.coords(:, [2, 3, 1]);
        for i = 1:3
            u = mod(i, 3) + 1; v = mod(i+1, 3) + 1;
            x = s.edges(:, u);
            y = s.edges(:, v);
            edge_len_x1 = norm(s.edges(:, u))^2;
            edge_len_x2 = norm(s.edges(:, v))^2;
            cos_angle = -dot(x, y) / (norm(x) * norm(y));
            cot_angle = cos_angle / sqrt(1 - cos_angle^2);
            x1 = s.index(u); x2 = s.index(v); x3 = s.index(i);
            if ismember(x1, int_nodes)
                Elam(x1, x2) = cot_angle; % alpha ij
                Emu(x1, x3) = Emu(x1, x3) + cot_angle / edge_len_x2;
                % gamma ij
                gElam(x1, x2) = gElam(x1, x2) + cot_angle; % alpha ij
                gElam(x2, x1) = gElam(x2, x1) + cot_angle; % beta ij
                gEmu(x1, x3) = gEmu(x1, x3) + cot_angle / edge_len_x2;
                % gamma ij
            elseif ismember(x2, int_nodes)
                Elam(x1, x2) = cot_angle; % alpha ij
                Emu(x2, x3) = Emu(x2, x3) + cot_angle / edge_len_x1;
                % delta ij
                gElam(x1, x2) = gElam(x1, x2) + cot_angle; % alpha ij
                gElam(x2, x1) = gElam(x2, x1) + cot_angle; % beta ij
                gEmu(x2, x3) = gEmu(x2, x3) + cot_angle / edge_len_x1;
                % delta ij
            end
        end
    end
    gElam = gElam - diag(sum(gElam, 2));
    gEmu = gEmu - diag(sum(gEmu, 2));
end

