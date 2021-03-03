function retracted_node = retract_configuration(node,node_diam,obstacles,env,step)
eps = 0.001;
[cpn, cpo] = closest_pair(node,node_diam,obstacles,env);
cpo_prime = cpo;
while norm(cpo_prime - cpo) < eps
    node_prime = node;
    node = node + (cpn - cpo) * 0.1;
    [cpn, cpo_prime] = closest_pair(node,node_diam,obstacles,env);
end
node_mid = node_prime + 0.5 * (node - node_prime);
while norm(node_prime - node) > step
    node_mid = node_prime + 0.5 * (node - node_prime); % interpolate between nodes
    [cpn, cpo] = closest_pair(node_mid,node_diam,obstacles,env);
    if norm(cpo_prime - cpo) < eps % in lieu of cpo_prime == cpo | because of machine precision
        node = node_mid;
    else
        node_prime = node_mid;
    end
end
retracted_node = node_mid;
end

