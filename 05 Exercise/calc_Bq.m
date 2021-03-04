function Bq = calc_Bq(masses, jacs_P , jacs_O, inertia_tensors, transformations);

Bq = zeros(3, 3);
for i = 1:1:size(masses,1)
    mass = masses(i);
    jP = jacs_P(i);
    jO = jacs_O(i);
    I = inertia_tensors(3*(i-1)+1:3*i,:);
    T = transformations(4*(i-1)+1:4*i,:);
    R = T(1:3,1:3);

    Bq = Bq + mass * jP' * jP + jO' * R' * I * R * jO;
end
end
