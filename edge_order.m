function E = edge_order(edges, start)
    num_edge = size(edges, 2);
    E = zeros(1, num_edge);
    curr_node = start;
    E(1) = curr_node;
    for i = 2:num_edge
        curr_node = edges(2, edges(1, :) == curr_node);
        E(i) = curr_node;
    end

