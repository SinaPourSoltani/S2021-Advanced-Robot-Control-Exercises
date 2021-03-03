function  plot_environment(init,goal,env,obst,nodes,fig_num)
figure(fig_num)
hold on
scalar = 350;

xlim([env(1,1) env(2,1)])
ylim([env(1,2) env(2,2)])

% plot init
plot(init(1),init(2),'b.','MarkerSize',scalar*init(3));

% plot goal
plot(goal(1),goal(2),'g.','MarkerSize',scalar*goal(3));

% plot obstacles
for i =1:1:size(obst,1)
    plot(obst(i,1),obst(i,2),'r.','MarkerSize',scalar*obst(i,3));
end

% plot nodes
for i = 1:1:size(nodes,1)
    plot(nodes(i,1),nodes(i,2),'bo','MarkerSize',scalar*0.07);
    
    if i < size(nodes,1)
        line([nodes(i,1) nodes(i+1,1)],[nodes(i,2) nodes(i+1,2)],...
            'LineStyle','--','Color','k','LineWidth',2)
    end
end
end
