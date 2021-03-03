% Reset
clc;
clear;
close all;

% Parameters
robot_diam = 0.25;
obscl_diam = 0.5;

init = [0.5 2.7 robot_diam];
goal = [3.5 0.3 robot_diam];
env_bound = [0 0; 4 3];

obstacles = [1 1.7; 1.5 2.1; 2.55 0.95; 0.95 0.7;2.6 2.0];
obstacles = [obstacles ones(1,size(obstacles,1))'*obscl_diam];

milestones = [
    0.5 2.7; 0.9 2.3; 0.3 2.1; 0.3 1.2; 0.18 0.75;
    0.8 1.15; 1.4 1.25; 1.45 1.6; 2. 1.7; 2. 2.5;
    3.3 2.4; 3.35 1.4; 2.1 1.4; 1.75 0.5; 1.85 0.2; 
    2.65 0.25; 3. 0.7; 3.5 1.; 3.5 0.3 
];

%plot_environment(init,goal,env_bound,obstacles,milestones);

% Algorithm wide params
step = 0.1;
path = discretize_path(milestones,step);
plot_environment(init,goal,env_bound,obstacles,path,1);

%% Algorithm - Shortcuts
% rng(0,'twister');
i_max = 1000;

shorter_path = shortcuts(path,obstacles,i_max,step);
plot_environment(init,goal,env_bound,obstacles,shorter_path,2);

%% Algorithm - W-retraction
clearance_path = w_retraction(shorter_path,robot_diam,obstacles,env_bound,step);
trimmed_path = remove_branches(clearance_path,step*2);

plot_environment(init,goal,env_bound,obstacles,clearance_path,3);
plot_environment(init,goal,env_bound,obstacles,trimmed_path,4);
