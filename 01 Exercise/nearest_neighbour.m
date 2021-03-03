function [state_near, idx] = nearest_neighbour(graph, state)
    node_array = table2array(graph.Nodes); 
    current_closest_dist = inf; 
    closest_idx = -1; 
    for i = 1:size(node_array, 1)
        test_node = node_array(i, :); 
        dist = distance(state, test_node);  
        if dist < current_closest_dist && dist > 0
            current_closest_dist = dist; 
            closest_idx = i; 
        end
    end 
    idx = closest_idx;
    state_near = node_array(closest_idx, :); 
end

