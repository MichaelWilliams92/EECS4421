function Q = translate2(P, t)
%TRANSLATE2 translates points in 2D.
%   Q = translate2(P,t) translates the points P a constant distance
%   in a given direction, specified by t
%   P is a 2 x n array of points
%   t is the 2D translation vector

Q = [(P(1, :) + t(1));
     (P(2, :) + t(2))];

end

