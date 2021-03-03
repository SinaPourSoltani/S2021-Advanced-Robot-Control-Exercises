function control = get_control2(state_near, start_rand, control_inputs, dt)
dist_to_rand = inf; 
best_control_idx = -1; 
for i = 1:size(control_inputs, 1)
        state_temp = propagate(state_near, control_inputs(i, :), dt); 
        temp_dist = distance(state_temp, start_rand); 
        if temp_dist < dist_to_rand
            best_control_idx = i; 
            dist_to_rand = temp_dist; 
        end
end

control = control_inputs(best_control_idx, :);
end

