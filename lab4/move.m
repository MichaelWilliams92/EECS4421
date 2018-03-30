%% Question 1 of Lab 4
% this function takes an input goal pose and makes the origin of frame 5
% move to the specified pose, using a linearly interpolated joint space path.

function answer = move(obj, T)
% T = final end effector pose
% obj = object to be moved

% obtain Q0 and QF
[pose, joint, Q0] = obj.getpose();
[Qf] = inverse(T);

% m is the number of steps
m = 0;

%compute change in Q
deltaQ = Qf - Q0;

while(max(abs(deltaQ)/m))>10
    m = m + 1;
end

%compute change in t
deltaT = [deltaQ(1)/m deltaQ(2)/m deltaQ(3)/m deltaQ(4)/m deltaQ(5)/m];

for j = 1:m
    
    [pose,joint,angle] = obj.getpose();
    
    angle(1) = angle(1) + deltaT(1);
    angle(2) = angle(2) + deltaT(2);
    angle(3) = angle(3) + deltaT(3);
    angle(4) = angle(4) + deltaT(4);
    angle(5) = angle(5) + deltaT(5);
    
    
    obj.dhmadeg(angle);
end
    answer = angle;
end

function [theta] = inverse(T)

theta = zeros(1,5);

[theta(1), theta(2), theta(3)] = invtheta123(T);

thetaX = [deg2rad(theta(1)) deg2rad(theta(2)) deg2rad(theta(3))];
a = [0 10 10];
alpha = [90 0 0] * pi/180;
d = [10 0 0];

[theta(4), theta(5)] = invtheta45(a,alpha,d,thetaX,T);
end

function [theta1, theta2, theta3] = invtheta123(T)

x = wpos(1);
y = wpos(2);
z = wpos(3);
a1 = 10;
a2 = 10;
h = 10;
wpos = wristcenter0(T);

C = (-a1^2 - a2^2 + (x^2 + y^2 + (z-h)^2))/(2*a1*a2);

theta1 = rad2deg(atan2(y,x));

theta3 = rad2deg(atan(-sqrt(1-C^2)/C));

B1 = atan2((a2*sin(deg2rad(theta3))),(a1 + a2*cos(deg2rad(theta3))));
B2 = atan((z-h)/sqrt(x^2 + y^2));
theta2 = rad2deg(B2 - B1);

%check bounds
if(theta1 < -175 || theta1 > 175)
    error('Joint 1 not within limits');
    exit(-1); 
end

if(theta2 < 0 || theta2 > 110)
    error('Joint 2 not within limits');
    exit(-1); 
end

if(theta3 < -130 || theta3 > 0)
    error('Joint 3 not within limits');
    exit(-1);
end

end

function [theta4, theta5] = invtheta45(a, alpha,d,theta,T)

T03 = dh(a,alpha,d,theta,1,3);

T35 = (T03)'*T;

T45 = invwrist(T35);
th4 = rad2deg(T45(1));
theta5 = rad2deg(T45(2));

if(th4 <-110 || th4 > 110)
    theta4 = mod(th4,360);
else
    theta4 = th4;
end
end