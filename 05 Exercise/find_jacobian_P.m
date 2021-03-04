function jacobian = find_jacobian_P(z, p_link, p_center)

jac = zeros(3, 3); % size given number of joints

for i = 1:size(z, 2)
    row = cross(z(:,i), p_center - p_link(:, i));
    jac(:, i) = row;
end

jacobian = jac;
end
