target = load("cat_target.mat");
new_target = zeros(264, 2);

source = load("Data/cat_source.mat");
n_curr = size(target.x, 2);
n_sorc = size(source.e, 2);

new_chunk = zeros(48, 2);
idx = 1;
for i = 196:231
    curr_node = [target.x(i), target.y(i)];
    next_node = [target.x(i+1), target.y(i+1)];
    new_chunk(idx, :) = curr_node;
    if i == 204
        new_chunk(idx+1, :) = (3 * curr_node + next_node) / 4;
        new_chunk(idx+2, :) = (curr_node + next_node) / 2;
        new_chunk(idx+3, :) = (curr_node + 3 * next_node) / 4;
        idx = idx + 4;
    elseif i == 203
        new_chunk(idx+1, :) = (2 * curr_node + next_node) / 3;
        new_chunk(idx+2, :) = (curr_node + 2 * next_node) / 3;
        idx = idx + 3;
    elseif i == 199 || i >= 205 && i <= 210
        new_chunk(idx+1, :) = (curr_node + next_node) / 2;
        idx = idx + 2;
    else
        idx = idx + 1;
    end
end

target.x([156 158 160 162 164 166 168 170 182 184 186 188]) = [];
target.y([156 158 160 162 164 166 168 170 182 184 186 188]) = [];

new_target(1:183, 1) = target.x(1:183);
new_target(1:183, 2) = target.y(1:183);
new_target(184:231, :) = new_chunk;
new_target(232:264, 1) = target.x(220:252);
new_target(232:264, 2) = target.y(220:252);

% cat_s node 4 = cat_t node 1
bound_perm = edge_order(source.e(1:2, :), 4);
[~, inv_perm] = sort(bound_perm);
new_target = new_target(inv_perm, :);

x = new_target(:, 1).';
y = new_target(:, 2).';
save("well_cat_target.mat", "x", "y")


