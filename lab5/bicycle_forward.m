%% Question 1 of Lab 5
% The following is a Matlab function that computes
% the forward kinematics of a bicycle, given the pose
% control, L and dt values.  It is assumed that the angles fed into the
% function are in degrees.

function [newpose, icc] = bicycle_forward(pose, control, L, dt)
%BICYCLE_FORWARD computes the forward kinematics of a bicycle.
%    [newpose, icc] = bicycle_forward(pose, control, L, dt) computes the
%    forward kinematics of the bicycle given the pose, control
%    L and dt values where
%
%    pose is the current pose of the bicycle containing the transverse of
%    the matrix [x y theta], where
%        -x and y are the respective x and y coordinates of the center of 
%         the front wheel
%        -theta is the angle from the x axis to the direction of the 
%         bicycle frame
%
%    control is the vector of control inputs containing the tranverse of
%    the matrix [v alpha], where
%        -v is the forward linear velocity of the front wheel in metres
%         per second
%        -alpha is the angle of the front wheel, relative to the frame of
%         the bicycle
%    
%    L is the length of the bicycle frame
%
%    dt is the time interval of the motion in seconds

% compute h

h = L/(cosd(90 - control(2)));

% compute ICC

%angleA is the angle between the x axis and the velocity vector
angleA = pose(3) + control(2);

ICCx = pose(1) - (h * (sind(angleA)));
ICCy = pose(2) + (h * (cosd(angleA)));

icc = [ICCx; ICCy];

%compute w or angular velocity

w = control(1)/h;

%compute new pose

b = radtodeg(w*dt);

newpose = [cosd(b) -1*sind(b) 0;
           sind(b) cosd(b) 0;
           0 0 1];       
       
newpose = newpose * [pose(1) - ICCx;
                     pose(2) - ICCy;
                     pose(3)];
                
newpose = newpose + [ICCx;
                     ICCy;
                     b];
    
                 
%show result
                 
end

        

