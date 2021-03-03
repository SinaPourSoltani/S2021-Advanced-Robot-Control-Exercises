function L = dual_function(path, lambda)
    L = path_length(path) + lambda * inequality_constraints(path);
end

