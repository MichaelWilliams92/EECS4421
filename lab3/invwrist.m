%% Question 4 of Lab 3
% The following is a Matlab function that solves the 
% kinematic problem for the wrist
% In other words, given the transformation matrix T35,
% this function solves for values theta4 and theta5

function theta45 = invwrist(T35)
%INVWRIST computes theta4 and theta5
%  theta45 = invwrist(T35) solves the kinematic problem and returns
%  [theta4 theta5], given T35(the tranformation matrix of {5} 
%  in reference to {3}).

%given the matrix in the derived form as shown in Question 3,
%compute theta4 and theta5

theta4 = atan2d(T35(2,3), T35(1,3));
theta5 = atan2d(T35(3,1), T35(3,2));

theta45 = [theta4 theta5];

end