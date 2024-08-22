source = load("Data/cat_source.mat");
target_struct = load("well_cat_target.mat");
source.p(3, :) = 1;

target = target_struct.x.';
target(:, 2) = target_struct.y.';
x0 = source.p(1:2, :);
%x0 = load("cat_mapped.mat").p.';

[U_new, ~] = fit(source, target, 1, 0); %, x0);
N = size(source.p, 2);
U_new = reshape(U_new, N, 2);

%surfaceMeshShow(source.p.', source.t(1:3, :).')
figure
pdeplot(source.p(1:2,:), source.e, source.t)
figure
pdeplot(U_new.', source.t(1:3, :))
figure
scatter(U_new(:, 1), U_new(:, 2), 1)

p = U_new.';
e = source.e;
t = source.t;

%{
source2.p = U_new.';
source2.p(3, :) = 1;
source2.e = inv_perm;
source2.t = source.t;

[U_ref, ~] = fit(source2, new_target, 1, 0);

pdeplot(U_ref.', source.t(1:3, :))
%}