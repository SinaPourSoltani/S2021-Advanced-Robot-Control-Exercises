function jacobian = find_jacobian_P(z, p_link, p_center)

jac = sym(zeros(3, 3)); % size given number of joints

for i = 1:size(z, 1)
    row = cross(z(i, 1:3)', p_center(i, 1:3)'- p_link(i, 1:3)');
    jac(:, i) = row ;
end

jacobian = jac;
end

