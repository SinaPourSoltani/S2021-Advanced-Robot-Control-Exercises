function discretized_path = discretize_path(nodes,step)
discretized_path = [nodes(1,:)];
for i = 1:1:size(nodes,1)-1
    local_path = discretize_local_path(nodes(i,:), nodes(i+1,:),step);
    discretized_path = [discretized_path; local_path(2:end,:)];
end
end

