function path = method_of_multipliers(path)
lambda = [1];
max = 10;

% dual function
L = @(path, lambda) path_length(path) + lambda * inequality_constraints(path);
    %+ nu * equality_constraints(path);

% to optimize with fixed extra parameters
OPT_FUN = @(x)L(x,lambda);

for k = 1:1:max
    path = fminsearch(OPT_FUN, path);
    lambda = lambda + inequality_constraints(path);
end
end


