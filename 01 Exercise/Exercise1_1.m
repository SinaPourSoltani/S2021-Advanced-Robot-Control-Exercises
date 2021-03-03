clc; 
clear;
close all;
env_boundary = [0 0; 4 3];
vel_boundary = [-1 -1; 1 1 ];
obstacles = [1 1.7 0.5; 1.5 2.1 0.5]; 
start = [0.5 2.7 0 0];
goal = [3.5 0.3 0 0];
robot_diameter = 0.25;
K = 3000; 
dt = 0.3; 
collision_counter = 0;

% Setup figure and plot init, goal and obstacles
hold on
fig = figure(1);
%xlim([env_boundary(1,1) env_boundary(2,1)])
%ylim([env_boundary(1,2) env_boundary(2,2)])
plot_state(start,'init')
plot_state(goal,'goal')
plot_obstacles(obstacles)

eps_v = 1; 
eps_p = 0.1;

control_input = [1 0; -1 0; 0 1; 0 -1];

init_graph = graph; 
init_graph = addnode(init_graph, table(start));

i = 0; 
while i < K
   x_rand = goal;
   if mod(i, 10) ~= 0
        x_rand = random_state(env_boundary, vel_boundary);
   end
   %plot_state(x_rand,'ms')
   
   % Get nearest node
   [nearest_node, idx_nearest] = nearest_neighbour(init_graph, x_rand);
   plot_state(nearest_node,'goal');
   
   % get control 
   %u = get_control(x_rand, nearest_node, dt, control_input);
   u = get_control2(nearest_node, x_rand, control_input, dt);
   
   % find new state
   x_new = propagate(nearest_node, u, dt);
   
   % Check state for collisions 
   x_new_collision = in_collision(x_new, robot_diameter, obstacles, env_boundary, vel_boundary);
   
   if x_new_collision == 0
        init_graph = addnode(init_graph, table(x_new, 'VariableNames', init_graph.Nodes.Properties.VariableNames));
        % add edge to graph
        if norm((x_new(1:2) - goal(1:2))) < eps_p && norm((x_new(3:4) - goal(3:4))) < eps_v
            disp('Congratulation! The goal has been reached!!')
            return 
        end
   else
       collision_counter = collision_counter + 1;
   end
   i = i + 1;
end
disp('The goal was not reached')

 [nearest_node_end, idx_near_end] = nearest_neighbour(init_graph, goal);
 nearest_node_end

plot_tree(init_graph);
collision_counter

function plot_tree(graph)
states = table2array(graph.Nodes);
for i = 1:1:size(states,1)
    plot_state(states(i,:),'d');
end
end

function plot_state(s,type)
params = 'ko';
if strcmp(type, 'init')
    params = 'bo';
elseif strcmp(type, 'goal')
    params = 'go';
elseif strcmp(type, 'ms')
    params = 'co';
end

ls = 1/10;
plot(s(1),s(2),params, 'MarkerSize', 0.25*100);
line([s(1) s(1)+s(3)*ls],[s(2) s(2)+s(4)*ls],'Color','green', 'LineWidth', 2);
end

function plot_obstacles(obs)
    for i = 1:1:size(obs,1)
        plot(obs(i,1),obs(i,2),'r.', 'MarkerSize', obs(i,3)*350);
    end
end
   