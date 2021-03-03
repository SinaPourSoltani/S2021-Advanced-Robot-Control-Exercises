%% Exercise 3

% Reset
clc;
clear;
close all;

% Parameters
robot_diam = 0.5;
obscl_diam = 1;

init = [0.7 5.3 robot_diam];
goal = [5.3 0.7 robot_diam];
env_bound = [0 0; 6 6];

obstacles = [3 3];
obstacles = [obstacles ones(1,size(obstacles,1))'*obscl_diam];

%plot initial environment
%plot_environment(init,goal,env_bound,obstacles,[],1); 

milestones = [0.7 5.3; 5.3 0.7];
path_step_size = 0.1;
first_path = discretize_path(milestones, path_step_size);

% plot first path
plot_environment(init, goal, env_bound, obstacles, first_path, 2);

% obstacle collisions
opt_path = method_of_multipliers(first_path);

plot_environment(init, goal, env_bound, obstacles, opt_path, 3);





