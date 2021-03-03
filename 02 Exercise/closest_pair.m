function [cpn, cpo] = closest_pair(node,node_diam,obstacles,env)
env_boundary = [
    node(1), env(1,2);    
    node(1), env(2,2);
    env(1,1), node(2); 
    env(2,1), node(2); 
];

obstacles = [obstacles; env_boundary zeros(size(env_boundary,1),1)];

obstacle_clearances = [];
for i = 1:1:size(obstacles,1)
    obstacle_clearances = [obstacle_clearances; ...
        norm(node - obstacles(i,1:2)) - obstacles(i,3)/2 - node_diam/2];
end

[c, c_i] = min(obstacle_clearances);
closest_obs = obstacles(c_i,:);
cpn = node + unit(closest_obs(1:2) - node) * node_diam/2;
cpo = closest_obs(1:2) + unit(node - closest_obs(1:2)) * closest_obs(3)/2;
figure(3)
hold on
plot(cpn(1),cpn(2),'b.')
plot(cpo(1),cpo(2),'b.')
end

