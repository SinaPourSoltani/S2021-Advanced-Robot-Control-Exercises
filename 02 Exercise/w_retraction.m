function clearance_path = w_retraction(path,robot_diam,obstacles,env,step)
n = size(path,1);
i = 1;
clearance_path = [];
local_planner_count = 0;
while i <= n
    retracted_node = retract_configuration(path(i,:),robot_diam,obstacles,env,0.01);
    if i > 1
        node_prev = clearance_path(end,:);
    else
        node_prev = path(1,:);
    end
    
    if norm(node_prev - retracted_node) > step
        local_planner_count = local_planner_count + 1;
        disp('Creating local path')
        local_path = discretize_local_path(node_prev, retracted_node, step);
        if local_planner(local_path, obstacles)
            clearance_path = [clearance_path; local_path(1:end-1,:)];
        else
            disp('A collision-free local path could not be generated.')
        end
    end
    clearance_path = [clearance_path; retracted_node];  
    i = i + 1;
end
end

