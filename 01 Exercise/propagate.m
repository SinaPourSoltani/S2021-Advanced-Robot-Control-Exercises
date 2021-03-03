function x = propagate(state, input, dt)
    C = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1]; 
    D = [0 0; 0 0; dt 0; 0 dt]; 
    
    x = C*state' + D*input'; 
    x = x';
end

