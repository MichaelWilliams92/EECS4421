function [Q] = rotate2( P, theta )
%ROTATE2 rotate points about the origin
%   Q = rotate2(P,theta) rotates the points P about the origin by
%   an angle theta specified in degrees.
%   P is a 2 x n array of points

R = [cosd(theta) -sind(theta);
     sind(theta) cosd(theta)];
Q = R * P;
end

