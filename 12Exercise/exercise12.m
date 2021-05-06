%  Safe motion planning

%   qz         zero joint angle configuration
%   qr         arm along +ve x-axis configuration


startup_rvc

%% Determin the direction of macimal effective mas at configuration q = (1,1,1,1,1,1)

clear
clc
mdl_ur5

q = [1.0,1.0,1.0,1.0,1.0,1.0];

jac = ur5.jacob0(q);            % finds the jacobian with the configuration

B_q = InertiaTensor(q);

[V,D] = eig(jac*inv(B_q)*jac'); % SVD can also be used, but we are only 
                                % interressed in the eig vector

smallest_eig_vec = V(1:3,end); % Finds the eig value and as they are sorted
                               % we can take the end to find smallest values.
                               % we only take 1:3 as we look at the
                               % translation part

u = smallest_eig_vec;

norm(u) % should be one to comply with the definition.


%% Consider the desgin of a safe path velocity betwen two configurations.
% only interresed in translational part

% basic idea: We want to see if out velocity between two conf are safe (we
% define the two conf). We used a function to interpolate between the two
% confs. u, which is the diretion of collison is determined by looking at
% the direction between two of the interpolated confs. We know that the
% human is standing still and therefore know the direction. A problem
% occures if the human is moving around. we can solve that, but we have not
% been give a method. 

% TO solve the assignemnt:
% - Find path between two confs. 
% - Find u, direction between two interpolated confs.
% - recalc m_R at each sted
% - plot v_rel
% - make sure the path is safe

% see parameters on slide 19 (30)
m_H = 40;
k = 25;
F_max = 140; % slide 19 (29)

m_R = u'*jac(1:3,:)*inv(B_q)*jac(1:3,:)'*u;

v_rel = sqrt((F_max^2)/k*(1/m_R+1/m_H));







