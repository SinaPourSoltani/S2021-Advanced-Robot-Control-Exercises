function dynamic_boundary(s1, s2)
x = Ax + Bu
y = Cx + Du
end

function s2 = propagate(s1)
C = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1]; 
D = [0 0; 0 0; dt 0; 0 dt]; 



x = C*state' + D*input'; 
x = x';
end
end