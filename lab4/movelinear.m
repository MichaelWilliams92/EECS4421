%% Question 2 of Lab 4
% This function repeats the functionality of Question 1, only by using a
% cartesian space path, in which a straight line path is produced, if such
% a path exists

function result = movelinear(obj, p)
% T = final end effector pose
% obj = object to be moved

p0 = wristcenter0(obj.getpose());

m = 0;
deltaP = p - p0;

while(max(abs(deltaP)/m)) > 10
	m = m + 1;
end

deltaT = [deltaP(1)/m deltaP(2)/m deltaP(3)/m];

display(deltaP(3));
for j = 1:m

	point = wristcenter0(obj.getpose());
	point = point + deltaT';

	T = Tp(point);

	[angle] = inverse(T);
    display(angle);
	obj.dhmadeg(angle);
end
	result = angle;
end

function result = Tp(p)

R05 = [-1 0 0; 0 1 0; 0 0 -1];

result = [R05(1,1) R05(2,1) R05(3,1) p(1);
	 R05(1,2) R05(2,2) R05(3,2) p(2);
	 R05(1,3) R05(2,3) R05(3,3) p(3);
	 0 0 0 1];

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

C = (a1^2 + a2^2 - (x^2 + y^2 + (z-h)^2))/(2*a1*a2);

theta1 = rad2deg(atan2(y,x));

theta3 = rad2deg(atan(-sqrt(1-C^2)/C));

B1 = atan((a2*sin(deg2rad(theta3)))/(a1 + a2*cos(deg2rad(theta3))));
B2 = atan((z-h)/sqrt(x^2 + y^2));
theta2 = rad2deg(B2 - B1);

if(theta1 < -175 || theta1 > 175)
    error('Joint 1 not within limits');
    exit(-1); 
end

if theta2 < 0 || abs(theta2) < 1e-6
        theta2 = 0;
end
if(theta2 < 0 || theta2 > 110)
    error('Joint 2 not within limits');
    exit(-1);
end

if theta3 > 0 || theta3 < 1e-5
    theta3 = 0;
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

function theta45 = invwrist(T35)

theta5 = atan2(-T35(3, 1), -T35(3, 2));
theta4 = atan2(T35(1, 3), -T35(2, 3));
theta45 = [theta4 - pi/2 theta5];
end