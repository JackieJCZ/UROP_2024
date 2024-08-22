function [E_A, E_X] = energies(X, U, int_nodes)
    E_A = 0; E_X = 0;
    for face = 1:size(X.t,2)
        s.index = X.t(:, face);
        s.coords = X.p(:, s.index);
        s.edges = s.coords(:, [3, 1, 2]) - s.coords(:, [2, 3, 1]);
        s.u_coords = U(:, s.index);
        s.u_edges = s.u_coords(:, [3, 1, 2]) - s.u_coords(:, [2, 3, 1]);
        for i = 1:3
            u = mod(i, 3) + 1; v = mod(i+1, 3) + 1;
            if ismember(s.index(u), int_nodes)
                x = s.edges(:, u);
                y = s.edges(:, v);
                cos_angle = -dot(x, y) / (norm(x) * norm(y));
                cot_angle = cos_angle / sqrt(1 - cos_angle^2);
                E_A = E_A + (cot_angle * norm(s.u_edges(:, i))^2);
    
                E_X = E_X + (cot_angle / norm(x)^2 * norm(s.u_edges(:, u))^2);
                E_X = E_X + (cot_angle / norm(y)^2 * norm(s.u_edges(:, v))^2);
            end
        end
    end
end
