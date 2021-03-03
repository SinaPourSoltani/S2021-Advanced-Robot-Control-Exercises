function u = get_control(state_rand, state_near, dt, control_input)
    % rewrite to choose control_input based in the resulting state closest
    % to random state. 
    S_rand =  transpose(state_rand); 
    S_near = transpose(state_near); 
    C = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1]; 
    D = [0 0; 0 0; dt 0; dt 0]; 
    
    u_temp = pinv(D)*(S_rand - C*S_near); 
    

    
    control_idx = 0;
    temp_angle = inf;
    for i = 1:size(control_input)
        input = transpose(control_input(i, :));
        
        c = dot(u_temp, input)/norm(u_temp)/norm(input);
        angle =  acos(clip(c, -1, 1));
        if angle < temp_angle
            temp_angle = angle; 
            control_idx = i; 
        end
    end
    u = control_input(control_idx, :); 
end

