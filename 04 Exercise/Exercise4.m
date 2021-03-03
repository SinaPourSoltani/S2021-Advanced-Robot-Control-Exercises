syms t q1(t) q2(t) q3(t) 
q = [q1(t); q2(t); q3(t)];
%           θ a d α
DH_table = sym([0 0 0.089159 pi/2;
            0 -0.425 0 0;
            0 -0.39225 0 0]);

DH_table(:, 1) = q;

g_0 = -9.81584; % Gravitational Acceleration in Denmark

% Inertia tensors
I1 = [0.0084 0 0;
      0 0.0064 0;
      0 0 0.0084];

I2 = [0.0078 0 0;
      0 0.21 0;
      0 0 0.21];

I3 = [0.0016 0 0;
      0 0.0462 0;
      0 0 0.0462];

inertia_tensors = [I1;I2;I3];

% Determine tranformations between link center points
T01 = DH2trans(DH_table(1, 1), DH_table(1, 2), DH_table(1, 3), DH_table(1, 4));
T12 = DH2trans(DH_table(2, 1), DH_table(2, 2), DH_table(2, 3), DH_table(2, 4));
T23 = DH2trans(DH_table(3, 1), DH_table(3, 2), DH_table(3, 3), DH_table(3, 4));

T02 = T01*T12;
T03 = T02*T23;

% Determine transformation for center of mass
C01 = T01 * [0; 0; -DH_table(1, 3)/2; 1];
C02 = T01 * T12 * [-DH_table(2, 2)/2; 0; 0; 1];
C03 = T01 * T12 * T23 * [-DH_table(3, 2)/2; 0; 0; 1];

% Calculate the Jacobian for each center point
p_link = [T01(1:3,4)'; T02(1:3,4)'; T03(1:3,4)'];
p_center = [C01'; C02'; C03'];

z_C01 = T01(1:3, 3);
z_C02 = T02(1:3, 3);
z_C03 = T03(1:3, 3);
z = [z_C01'; z_C02'; z_C03'];

jacC1_P = find_jacobian_P(z(1,:), p_link(1, :), p_center(1, :));
jacC2_P = find_jacobian_P(z(1:2,:), p_link(1:2, :), p_center(1:2, :));
jacC3_P = find_jacobian_P(z(1:3,:), p_link(1:3, :), p_center(1:3, :));

jacs_P = [jacC1_P,jacC2_P,jacC3_P ]

jacC1_O = [z(1,:)', zeros(3, 2)];
jacC2_O = [z(1:2,:)',zeros(3, 1)];
jacC3_O = [z(1:3,:)'];

jacs_O = [jacC1_O,jacC2_O,jacC3_O]

% masses of joints
masses = [3.7; 8.393; 2.33];

T = [T01; T02; T03];

E_pot = -sum((masses .* g_0).*p_center(:, 3));
E_kin = calc_kinetic_energy(masses, jacs_P , jacs_O, q/t, inertia_tensors, T)

Lagrangian = E_kin - E_pot;


vars = [q1(t) q2(t) q3(t)];
vars_num_values = [1, pi/3, pi/3];
Q1 = double(subs(diff(diff(Lagrangian, diff(q1,t), t) ,vars, vars_num_values) - subs(diff(Lagrangian, q1), vars, vars_num_values)));
Q2 = double(subs(diff(Lagrangian, diff(q2,t) ,vars, vars_num_values) - subs(diff(Lagrangian, q2), vars, vars_num_values)));
Q3 = double(subs(diff(Lagrangian, diff(q3,t) ,vars, vars_num_values) - subs(diff(Lagrangian, q3), vars, vars_num_values)));

% evaluate q1
% subs q1 with value
% evaluate q1_
% subs q1_ with q1/t
