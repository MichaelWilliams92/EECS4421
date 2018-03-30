%% Question 2 of Lab 3
% The following is a Matlab function that computes the
% Denavit-Hartenberg transformation matrix given vectors of 
% DH values a, alpha, d and theta

function T = dh(a, alpha, d, theta)
%DH computes the DH transformation matrix
%  T = dh(a, alpha, d, theta) computes the Denavit-Hartenberg matrix
%  given a(the link length), alpha(the link twist), d(the link offset)
%  and theta(the joint angle). 

%set identity matrix T
T = [1 0 0 0;
     0 1 0 0;
     0 0 1 0;
     0 0 0 1];
 
%compute tranformation for each vector given
for i = 1:1:size(a,1)

    T = T * ([cosd(theta(i)) (-1)*sind(theta(i))*cosd(alpha(i)) sind(theta(i))*sind(alpha(i)) a(i)*cosd(theta(i));
        sind(theta(i)) cosd(theta(i))*cosd(alpha(i)) (-1)*cosd(theta(i))*sind(alpha(i)) a(i)*sind(theta(i));
         0 sind(alpha(i)) cosd(alpha(i)) d(i);
         0 0 0 1]);
    
end
 
end


