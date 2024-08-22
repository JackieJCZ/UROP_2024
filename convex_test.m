
%circle to other
circ_source = load("circ_source_16.mat");
circ_source.p(3, :) = 1;
M = size(circ_source.e, 2);
figure
pdeplot(circ_source.p(1:2,:), circ_source.e, circ_source.t)
colorMesh(circ_source.p(1:2,:), circ_source.t)
for sides = 3:4
    poly_target = construct_poly(M, sides, 1.0);
    bound_perm = edge_order(circ_source.e(1:2, :), 1);
    [~, inv_perm] = sort(bound_perm);
    poly_target = poly_target(inv_perm, :);

    
    [U_new, ~] = fit(circ_source, poly_target, 1, 1);
    disp(sum(areacon(U_new(:), circ_source.t) > 0))
    figure
    U_jiggled = jigglemesh(U_new.', circ_source.e, circ_source.t);
    pdeplot(U_jiggled, circ_source.e, circ_source.t)
    colorMesh(U_jiggled, circ_source.t)
end

%{
%triangle to other
tri_source = load("triangle_source.mat");
tri_source.p(3, :) = 1;
M = size(tri_source.e, 2);
% M = 302

square_target = zeros(M, 2);
for i = 0:75
    square_target(i+1, :) = [-1.0 + i * 2/75, -1.0];
end
for i = 1:75
    square_target(76+i, :) = [1.0, -1.0 + i * 2/76];
end
for i = 0:75
    square_target(152+i, :) = [1.0 - i * 2/75, 1.0];
end
for i = 1:75
    square_target(227+i, :) = [-1.0, 1.0 - i * 2/76];
end

% offset
start = 1;
bound_perm = edge_order(tri_source.e(1:2, :), start);
[~, inv_perm] = sort(bound_perm);
square_target = square_target(inv_perm, :);

[U_new, ~] = fit(tri_source, square_target, 1, 1);

figure
pdeplot(tri_source.p(1:2,:), tri_source.e, tri_source.t)
figure
pdeplot(U_new.', tri_source.e, tri_source.t)
figure
scatter(U_new(:, 1), U_new(:, 2), 1)

disp(sum(areacon(U_new(:), tri_source.t) < 0))

%}