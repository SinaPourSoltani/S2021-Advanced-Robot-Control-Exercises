function [a,b] = random_indeces(n_nodes)
a = randi(n_nodes-1);
b = randi(n_nodes-a) + a;
end


