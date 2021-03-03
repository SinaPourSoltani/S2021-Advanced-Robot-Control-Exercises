%% Exercise 3.1
syms q1 q2 q3;

T01 = DH2trans(0, 0, 0.089159, q1);
T12 = DH2trans(0, pi/2, 0, q2);
T23 = DH2trans(-0.425, 0, 0, q3);

T03 = T01 * T12 * T23;

J = calc_jacobian(T03);
%evaluated_J = double(subs(J,[q1,q2,q3],[pi/2,pi/4,pi]))

function T = DH2trans(a, alpha, d, theta)
T = sym(eye(4));
T(1,1) = cos(theta);
T(1,2) = -sin(theta) * cos(alpha);
T(1,3) = sin(theta) * sin(alpha);
T(1,4) = a * cos(theta);
T(2,1) = sin(theta);
T(2,2) = cos(theta)*cos(alpha);
T(2,3) = -cos(theta)*sin(alpha);
T(2,4) = a * sin(theta);
T(3,2) = sin(alpha);
T(3,3) = cos(alpha);
T(3,4) = d;
end

function J = calc_jacobian(T)
A = T(1:3,4);
B = rotm2rpy(T(1:3,1:3));
J = [A; B;];
end

function RPY = rotm2rpy(R)

sy = sqrt(R(1,1) * R(1,1) +  R(2,1) * R(2,1));
singular = true; %sy < 1e-6;

if ~singular
    x = atan2(R(3,2) , R(3,3));
    y = atan2(-R(3,1), sy);
    z = atan2(R(2,1), R(1,1));
else
    x = atan2(-R(2,3), R(2,2));
    y = atan2(-R(3,1), sy);
    z = 0;
end

RPY = [z, y, x]';
end




