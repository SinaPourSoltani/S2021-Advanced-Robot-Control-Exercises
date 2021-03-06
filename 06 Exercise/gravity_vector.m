function q = gravity_vector(q)
%GRAVITY_VECTOR
%    Q = GRAVITY_VECTOR(A2,A3,GZ,M2,M3,PL2_X,PL2_Y,PL3_X,PL3_Y,Q2,Q3)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    11-Mar-2021 11:50:07


a2 = -0.425;
a3 = -0.39225;
gz = -9.82;
m2 = 8.393;
m3 = 2.33;
q2 = q(2);
q3 = q(3);

pl1 = [0, -0.02561, 0.00193]
pl2 = [0.2125, 0, 0.11336]
pl3 = [0.15, 0.0, 0.0265]

pl2_x = pl2(1);
pl2_y = pl2(2);
pl3_x = pl3(1);
pl3_y = pl3(2);


t2 = cos(q2);
t3 = q2+q3;
t4 = a2.*t2;
t5 = cos(t3);
t6 = sin(t3);
t7 = a3.*t5;
t8 = pl3_x.*t5;
t9 = pl3_y.*t6;
t10 = -t9;

q = [0.0,gz.*m3.*(t4+t7+t8+t10)+gz.*m2.*(t4+pl2_x.*t2-pl2_y.*sin(q2)),gz.*m3.*(t7+t8+t10)];
