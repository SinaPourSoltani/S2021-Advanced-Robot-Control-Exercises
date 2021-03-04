clc;
clear;
close all;

syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3;
%q = [q1; q2; q3];
dq = [dq1; dq2; dq3];
ddq = [ddq1; ddq2; ddq3];

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

DH_table = [pi/2 0 0.089159 pi/2;
            pi/3 -0.425 0 0;
            pi/3 -0.39225 0 0];

% Determine tranformations between link center points
T01 = DH2trans(DH_table(1, 1), DH_table(1, 2), DH_table(1, 3), DH_table(1, 4));
T12 = DH2trans(DH_table(2, 1), DH_table(2, 2), DH_table(2, 3), DH_table(2, 4));
T23 = DH2trans(DH_table(3, 1), DH_table(3, 2), DH_table(3, 3), DH_table(3, 4));
T02 = T01*T12;
T03 = T02*T23;

transformations = [T01; T02; T03];

% Determine transformation for center of mass
C01 = T01 * [0; 0; -DH_table(1, 3)/2; 1];
C02 = T01 * T12 * [-DH_table(2, 2)/2; 0; 0; 1];
C03 = T01 * T12 * T23 * [-DH_table(3, 2)/2; 0; 0; 1];
C0EE = T03  * [0; 0; 0; 1];

% masses of joints
masses = [3.7; 8.393; 2.33];

% Calculate the Jacobian for each center point
p_link = [T01(1:3,4) T02(1:3,4) T03(1:3,4)]

z_C00 = [0; 0; 1];
z_C01 = T01(1:3, 3);
z_C02 = T02(1:3, 3);
z = [z_C00, z_C01, z_C02]

jacC1_P = find_jacobian_P(z(:,1), p_link(:,1), C01(1:3));
jacC2_P = find_jacobian_P(z(:,1:2), p_link(:,1:2), C02(1:3));
jacC3_P = find_jacobian_P(z(:,1:3), p_link(:,1:3), C03(1:3));
jacs_P = [jacC1_P,jacC2_P,jacC3_P];

jacC1_O = [z(1,:)', zeros(3, 2)];
jacC2_O = [z(1:2,:)',zeros(3, 1)];
jacC3_O = [z(1:3,:)'];
jacs_O = [jacC1_O,jacC2_O,jacC3_O];

Bq = calc_Bq(masses, jacs_P , jacs_O, inertia_tensors, transformations);

jacEnd3_P = find_jacobian_P(z(:,1:3), p_link(:, 1:3), C0EE(1:3));
J = [jacEnd3_P; jacC3_O];

dme = calc_dme(J, Bq)  % Dynamic Manipulability Ellipsoid
[V, D] = eig(dme)
rank = rank(dme)

d1 = DH_table(1,3);
a2 = DH_table(2,2);
a3 = DH_table(3,2);
qq1 = DH_table(1,1);
qq2 = DH_table(2,1);
qq3 = DH_table(3,1);
pe1 = [ cos(qq1) * (a3*cos(qq2 + qq3) + a2*cos(qq2));
        sin(qq1) * (a3*cos(qq2 + qq3) + a2*cos(qq2));
        d1 + a3 *sin(qq2 + qq3) + a2*sin(qq2)]
