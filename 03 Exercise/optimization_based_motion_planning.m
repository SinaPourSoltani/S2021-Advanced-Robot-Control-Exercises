function optimization_based_motion_planning()
max_it = 100;

for penalty_iteration = 1:1:max_it
    for convexify_iteration = 1:1:max_it
        convexify_problem()
        for trust_region_iteration = 1:1:max_it
        
            if model_improve > c
                %s = tau * s
            else
                %s = tau * s
            end
            if s < xtol
                check_constraints()
            end
        end
        if converged(xtol,ftol)
            break
        end
    end
    if check_constraints(ctol)
        break
    else
        mu = k * mu;
    end
end

    