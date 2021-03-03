% Setup figure and plot init, goal and obstacles
hold on
fig = figure(1);
xlim([env_boundary(1,1) env_boundary(2,1)])
ylim([env_boundary(1,2) env_boundary(2,2)])
plot_state(start,'init')
plot_state(goal,'goal')
plot_obstacles(Obstacles)

%plot_tree(init_graph);

function plot_tree(graph)
states = table2array(graph.Nodes);
for i = 1:1:size(states,1)
    plot_state(states(i,:),'d');
end
end

function plot_state(s,type)
params = 'k.';
if strcmp(type, 'init')
    params = 'b.';
elseif strcmp(type, 'goal')
    params = 'g.';
end

ls = 1/10;
plot(s(1),s(2),params, 'MarkerSize', 0.25*350);
line([s(1) s(1)+s(3)*ls],[s(2) s(2)+s(4)*ls],'Color','yellow', 'LineWidth', 2);
end

function plot_obstacles(obs)
    for i = 1:1:size(obs,1)
        plot(obs(i,1),obs(i,2),'r.', 'MarkerSize', obs(i,3)*350);
    end
end

