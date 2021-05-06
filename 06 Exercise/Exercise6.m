syms q1 q2 q3 m1 m2 m3 d1 a2 a3 ...
pl1_x pl1_y pl1_z...
pl2_x pl2_y pl2_z...
pl3_x pl3_y pl3_z real;

q = [q1; q2; q3];
m = [m1; m2; m3];
pl1 = [pl1_x; pl1_y; pl1_z];
pl2 = [pl2_x; pl2_y; pl2_z];
pl3 = [pl3_x; pl3_y; pl3_z];

DH_table = [q1 0 d1 pi/2;
            q2 a2  0   0;
            q3 a3  0   0];

% Define kinematic transformations
T01 = DH2trans(DH_table(1, :));
T12 = DH2trans(DH_table(2, :));
T23 = DH2trans(DH_table(3, :));
T02 = T01*T12;
T03 = T02*T23;

% Determine Position for center of mass´ (Look into sign of a2 and a3!!)
C01 = T01 * [pl1; 1];
C02 = T01 * T12 * [pl2; 1];
C03 = T01 * T12 * T23 * [pl3; 1];

CP = [C01(1:3) C02(1:3) C03(1:3)]';

% Calculate potential energy
Epot = 0;
syms gz real;
g = [0; 0; gz];
for i = 1:size(m, 1)
    mass = m(i);
    cp = CP(i, 1:3)';
    Epot = Epot + mass * g' * cp;
end

% Calculate partial differential
syms temp_q;
for i = 3:-1:1
    tmp = subs(Epot,q(i),temp_q);
    gq(i) = diff (tmp, temp_q);
    gq(i) = subs(gq(i), temp_q, q(i));
end

m_filename = 'gravity_vector';
%matlabFunction(simplify(gq),'file',m_filename,'outputs',{'q'});
% a2 = -0.425;
% a3 = -0.39225;
% gz = -9.82;
% m2 = 8.393;
% m3 = 2.33;
% q2 = q(2);
% q3 = q(3);
%
% pl1 = [0, -0.02561, 0.00193]
% pl2 = [0.2125, 0, 0.11336]
% pl3 = [0.15, 0.0, 0.0265]
%
% pl2_x = pl2(1);
% pl2_y = pl2(2);
% pl3_x = pl3(1);
% pl3_y = pl3(2);
