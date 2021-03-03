function u = get_control3(from_state, to_state, valid_controls, dt)
    u = (to_state(1:2) - from_state(1:2)) * dt;
end

