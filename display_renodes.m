% SPIDER:

target = load("well_target_XY.mat");
source = load("Data/ant_pet.mat");
%shift = 2;

%target.x = circshift(target.x, shift);
%target.y = circshift(target.y, shift);

bound_perm = edge_order(source.e(1:2, :), 5);
[~, inv_perm] = sort(bound_perm);

figure
plot(target.x, target.y)
text(target.x(:, inv_perm), target.y(:, inv_perm), num2cell((1:size(target.x, 2))))


% CAT:

source = load("Data/cat_source.mat");
target = load("well_cat_target.mat");
%shift = 2;

%target.x = circshift(target.x, shift);
%target.y = circshift(target.y, shift);

bound_perm = edge_order(source.e(1:2, :), 4);
[~, inv_perm] = sort(bound_perm);

figure
plot(target.x(:, bound_perm), target.y(:, bound_perm))
text(target.x, target.y, num2cell((1:size(target.x, 2))))

figure
xy_s = source.p(:, bound_perm);
plot(xy_s(1, :), xy_s(2, :))
text(xy_s(1, :), xy_s(2, :), num2cell(bound_perm))