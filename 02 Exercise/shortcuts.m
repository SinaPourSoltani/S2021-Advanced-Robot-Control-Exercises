function shortest_path = shortcuts(path,obstacles,i_max,step)
shortest_path = path;
i = 0;
while i < i_max
n = size(shortest_path,1);
[a, b] = random_indeces(n);
P1 = shortest_path(1:a-1,:);
P2 = discretize_local_path(shortest_path(a,:),shortest_path(b,:),step);
P3 = shortest_path(b+1:end,:);

if local_planner(P2,obstacles)
   shortest_path = [P1; P2; P3];
end
i = i + 1;
end
end

