target = load("Data/ant_to_spider_target_XY.mat");
source = load("Data/ant_pet.mat");
n_curr = size(target.x, 2);
n_sorc = size(source.e, 2);

shift = 2;

target.x = circshift(target.x, shift);
target.y = circshift(target.y, shift);

new_target = zeros(n_sorc, 2);
first_node = [target.x(1), target.y(1)];
idx = 1;
for i = 1:161
    curr_node = [target.x(i), target.y(i)];
    next_node = [target.x(i+1), target.y(i+1)];
    new_target(idx, :) = curr_node;
    if i > 151 || i == 27 || i == 108
        idx = idx + 1;
    elseif (i >= 140 && i < 142)
        new_target(idx+1, :) = (6 * curr_node + next_node) / 7;
        new_target(idx+2, :) = (5 * curr_node + 2 * next_node) / 7;
        new_target(idx+3, :) = (4 * curr_node + 3 * next_node) / 7;
        new_target(idx+4, :) = (3 * curr_node + 4 * next_node) / 7;
        new_target(idx+5, :) = (2 * curr_node + 5 * next_node) / 7;
        new_target(idx+6, :) = (curr_node + 6 * next_node) / 7;
        idx = idx + 7;
    elseif (i >= 129 && i < 132)
        new_target(idx+1, :) = (4 * curr_node + next_node) / 5;
        new_target(idx+2, :) = (3 * curr_node + 2 * next_node) / 5;
        new_target(idx+3, :) = (2 * curr_node + 3 * next_node) / 5;
        new_target(idx+4, :) = (curr_node + 4 * next_node) / 5;
        idx = idx + 5;
    elseif (i >= 12 && i < 31) || (i >= 132 && i < 140)
        new_target(idx+1, :) = (3 * curr_node + next_node) / 4;
        new_target(idx+2, :) = (curr_node + next_node) / 2;
        new_target(idx+3, :) = (curr_node + 3 * next_node) / 4;
        idx = idx + 4;
    elseif (i >= 31 && i < 82) || (i >= 86 && i < 129) || (i >= 142 && i < 145)
        new_target(idx+1, :) = (2 * curr_node + next_node) / 3;
        new_target(idx+2, :) = (curr_node + 2 * next_node) / 3;
        idx = idx + 3;
    elseif (i < 12 && i >= 1) || (i >= 82 && i < 86) || (i >= 145 && i < 151)
        new_target(idx+1, :) = (curr_node + next_node) / 2;
        idx = idx + 2;
    end
end
new_target(idx, :) = next_node;
new_target(idx + 1, :) = (next_node + first_node) / 2;

plot(new_target(:, 1).', new_target(:, 2).')

x = new_target(:, 1).';
y = new_target(:, 2).';
save("well_target_XY.mat", "x", "y")