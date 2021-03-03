function cost = collision_avoidance(x,y)
d_safe = 0.5 + 0.2; % robot_radius + clearance
r = 1 + d_safe;
if -1*((x-3)^2 + (y-3)^2 - r^2) < 0
    cost = 0;
else
    cost = -1*((x-3)^2 + (y-3)^2 - r^2);
end
end