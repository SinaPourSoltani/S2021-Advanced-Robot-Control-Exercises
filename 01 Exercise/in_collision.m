function collision = in_collision(state, robot_dia, obstacles, env_boundary, vel_lim)
    
      collision = 0;
      
      r_robot = robot_dia; 
      x_robot = state(1); 
      y_robot = state(2); 
      
      vel_x = state(3); 
      vel_y = state(4);
      
      % Check velocity is within boundary
      if ~(vel_x >= vel_lim(1) && vel_x <= vel_lim(2) && vel_y >= vel_lim(3) && vel_y <= vel_lim(4))
          collision = 1; 
          return 
      end
      
%       % Check state is within environment
%       if state(1) <= env_boundary(1) && state(2) >= env_boundary && state(3) <= env_boundary(3) && state(4) >= env_boundary(4)
%           collision = 1; 
%           return 
%       end
      
      % Check for collisions with obstacles
      n_obstacles = size(obstacles); n_obstacles = n_obstacles(1); 
      for i = 1:n_obstacles
          r = obstacles(i, 3) / 2; 
          x = obstacles(i, 1); 
          y = obstacles(i, 2);
          
          distSq = (x_robot - x)^2 + (y_robot - y)^2; 
          
          radSumSq = (r_robot / 2 + r)^2; 
          
          if distSq <= radSumSq
              collision = 1; 
          end 
      end
end

