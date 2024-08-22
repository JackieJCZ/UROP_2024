source = load("Data/ant_pet.mat");
target_struct = load("well_target_XY.mat");
source.p(3, :) = 1;

target = target_struct.x.';
target(:, 2) = target_struct.y.';

% ant node 5 = spider node 1
bound_perm = edge_order(source.e(1:2, :), 5);
[~, inv_perm] = sort(bound_perm);
new_target = target(inv_perm, :);

[U_new, ~] = fit(source, new_target, 1, 0);

%surfaceMeshShow(source.p.', source.t(1:3, :).')
figure
pdeplot(source.p(1:2, :), source.e, source.t)
figure
pdeplot(U_new.', source.t(1:3, :))
figure
scatter(U_new(:, 1), U_new(:, 2), 1)