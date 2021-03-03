function cost = velocity_boundary(s1, s2)
cost = 0;
if norm(s2 - s1) < 0.5
    cost = 0;
else
    cost = norm(s2 - s1);
end
end

