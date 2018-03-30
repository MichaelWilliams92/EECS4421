%% Original Shapes
X = [1 -1 -1 1;
     1 1 -1 -1];
 
 C = [5;0];
 angle = 10;
 radius = 1;
 
 plot(X(:,1), X(:,2), X(:,3), X(:,4), X(1,:), X(2,:), 'k')
 hold on
 
angle=0:10:360; 
xp= radius * cosd(angle);
yp= radius * sind(angle);
plot(xp + C(1,:), yp + C(2,:), 'k')
 
axis equal  

