function state = random_state(env_bound, vel_bound)

pos_x = random('Uniform', env_bound(1,1), env_bound(2,1));
pos_y = random('Uniform', env_bound(1,2), env_bound(2,2));
vel_x = random('Uniform', vel_bound(1,1), vel_bound(2,1));
vel_y = random('Uniform', vel_bound(1,2), vel_bound(2,2));

state = [pos_x pos_y vel_x vel_y];

end