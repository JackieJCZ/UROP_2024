function [U, M] = fit(X, C, lam, mu)
    N = size(X.p, 2);
    M_A = zeros(N, N); M_X = zeros(N,N);
    int_nodes = setdiff(1:1:size(X.p, 2), X.e(1, :));
    bound_nodes = X.e(1, :);
    for face = 1:size(X.t,2)
        s.index = X.t(:, face);
        s.coords = X.p(:, s.index);
        s.edges = s.coords(:, [3, 1, 2]) - s.coords(:, [2, 3, 1]);
        for i = 1:3
            u = mod(i, 3) + 1; v = mod(i+1, 3) + 1;
            x = s.edges(:, u);
            y = s.edges(:, v);
            len_x = norm(x)^2;
            len_y = norm(y)^2;
            cos_angle = -dot(x, y) / (norm(x) * norm(y));
            cot_angle = cos_angle / sqrt(1 - cos_angle^2);
            x1 = s.index(u); x2 = s.index(v); x3 = s.index(i);
            if ismember(x1, int_nodes)
                M_A(x1, x2) = M_A(x1, x2) + cot_angle; % alpha ij
                M_X(x1, x3) = M_X(x1, x3) + cot_angle / len_y;
                % gamma ij
            elseif ismember(x2, int_nodes)
                M_A(x2, x1) = M_A(x2, x1) + cot_angle; % beta ij
                M_X(x2, x3) = M_X(x2, x3) + cot_angle / len_x;
                % delta ij
            end
        end
    end
    M_A = M_A - diag(sum(M_A, 2));
    M_X = M_X - diag(sum(M_X, 2));
    M = lam * M_A + mu * M_X;
    
    M(1:size(bound_nodes, 2), :) = eye(size(bound_nodes, 2), N);

    C_full = zeros(N, 2);
    C_full(1:size(bound_nodes, 2), :) = C;

    U = sparse(M) \ C_full;
end

