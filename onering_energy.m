model = createpde;

nodes_2d = [
    1.5 1.0 0.0 -1.0 0.0 0.2;
    -0.2 1.0 2.0 0.3 -1.0 0.1
    ];
% p of PET

N = size(nodes_2d, 2);
elements = zeros(3, N-1);
elements(:, N-1) = [N N-1 1];
for c = 1:N-2
    elements(:, c) = [N c c+1];
end
% t of PET after adding row for subdomain

pdeplot(nodes_2d, elements)

nodes_3d = nodes_2d;
nodes_3d(3, :) = [0.0 0.0 0.0 0.0 0.0 1.0];

surfaceMeshShow(nodes_3d.', elements.')

%%%%%%
Num = 100;
E_A = zeros(Num, Num);
x_var = linspace(-3, 3, Num);
y_var = linspace(-3, 3, Num);

X_onering.t = elements;
X_onering.p = nodes_3d;
X_onering.e = zeros(2, 5);

for x_ind = 1:Num
    for y_ind = 1:Num
        E_cur = 0;

        central_node = [x_var(x_ind), y_var(y_ind)];
        u_nodes = nodes_2d; u_nodes(:, N) = central_node;

        alphas = angles2(X_onering.p, X_onering.t);
        for face = 1:size(elements,2)
            s.index = elements(:, face);
            s.coords = u_nodes(:, s.index);
            for i = 1:3
                u = mod(i, 3) + 1; v = mod(i+1, 3) + 1;
                if s.index(u) == 6
                    edge_len = norm(s.coords(:, u) - s.coords(:, v))^2;
                    E_cur = E_cur + alphas(s.index(u), s.index(v)) * edge_len;
                end
            end
        end
        E_A(x_ind, y_ind) = E_cur;
    end
end

imagesc(x_var, y_var, E_A)
colorbar
hold on;
plot([nodes_2d(1, 1:5) nodes_2d(1, 1)], [nodes_2d(2, 1:5) nodes_2d(2, 1)], 'black')