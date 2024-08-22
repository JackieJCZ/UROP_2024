source = load("Data/ant_pet.mat");

figure
pdeplot(source.p, source.e, source.t, NodeLabels="on");

edges = source.e(1:2, :);
num_edge = size(source.e, 2);
E = zeros(1, num_edge);
curr_node = edges(1, 1);
E(1) = curr_node;
count = 1;
disp("####")
for i = 2:num_edge
    curr_node = edges(2, edges(1, :) == curr_node);
    E(i) = curr_node;
    count = count + 1;
    if ismember(curr_node, [5, 48, 45, 36, 31, 29, 23, 16, 13, 8])
        disp(curr_node + "XXX")
        disp(count)
    end
end
disp(count)