function costs = inequality_constraints(path)
c1 = 0;
for i = 1:1:size(path,1)
   c1 = c1 + collision_avoidance(path(i,1),path(i,2));
end
costs = [c1];
end

