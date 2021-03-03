function dist = distance(state1,state2)
weight_pos = 5;
weight_vel = 1; 

pos1 = state1(1:2); 
vel1= state1(3:4); 
pos2 = state2(1:2); 
vel2= state2(3:4); 

pos_dist = norm(pos1 - pos2, 2);
vel_dist = norm(vel1 - vel2, 2); 

dist = weight_pos * pos_dist^2 + weight_vel * vel_dist^2; 
end

