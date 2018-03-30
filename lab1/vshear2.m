function [Q] = vshear2(P, m)
%VSHEAR2 shears the points in 2D
%    Q = vshear2(P,m) is a translation along the y axis by an amount
%    that increases linearly with the x component of the point.
%    P is a 2 x n array of points
%    m is the shear amount

matrix = [1 0; 
          m 1];
Q = matrix * P;

end

