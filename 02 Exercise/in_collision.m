function collision_bool = in_collision(robot, obstacles)
collision_bool = false; 

x_robot = robot(1); 
y_robot = robot(2); 
dia_robot = 0.25;

n_obstacles = size(obstacles, 1);
for i = 1:n_obstacles
    dia_obs = obstacles(i, 3) ; 
    x_obs = obstacles(i, 1); 
    y_obs = obstacles(i, 2);

    distSq = (x_robot - x_obs)^2 + (y_robot - y_obs)^2; 

    radSumSq = (dia_robot / 2 + dia_obs/2)^2; 

    if distSq <= radSumSq
        collision_bool = true; 
    return
    end 
end
end

