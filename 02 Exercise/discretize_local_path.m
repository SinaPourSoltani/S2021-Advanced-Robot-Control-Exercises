function discrete_nodes = discretize_local_path(n1, n2, step_size)
line_length = norm(n2 - n1);
num_intermediate_steps = round(line_length/step_size);

discrete_nodes = [n1];

for i = 1:1:num_intermediate_steps
    discrete_nodes = [discrete_nodes; n1 + (n2 - n1) * i / num_intermediate_steps];
end

end

