function E = calc_kinetic_energy(masses, jacs_P , jacs_O, q_dot, inertia_tensor, transformations);

E = 0;
for i = 1:1:size(masses,1)
    mass = masses(i);
    jP = jacs_P(i);
    jO = jacs_O(i);
    I = inertia_tensor(3*(i-1)+1:3*i,:)
    T = transformations(4*(i-1)+1:4*i,:);
    R = T(1:3,1:3);

    E = E + 0.5 * mass * q_dot' * jP' * jP * q_dot + 0.5 * q_dot' * jO' * R' * I * R * jO * q_dot;
end
end
