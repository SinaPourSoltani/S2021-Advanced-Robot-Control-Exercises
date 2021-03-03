function collision_free = local_planner(path, obstacles)
collision_free = true;
for i = 1:1:size(path,1)
   if in_collision(path(i,:),obstacles)
       collision_free = false;
       return
   end
end
end

