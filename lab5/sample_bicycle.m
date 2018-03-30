%% Question 2 of Lab 5
% The following is a Matlab function that uses the bicycle_forward
% function to generate a sample pose of the bicycle newpose, given the
% starting pose, control vector, frame length and time interval, and
% assuming that the control inputs are noisy.  

function newpose = sample_bicycle(pose, control, L, dt)
%SAMPLE_BICYCLE generates a sample pose of the bicycle's newpose.
%    newpose = sample_bicycle(pose, control, L, dt) generates a sample pose
%    of the bicycle, assuming contorl inputs are noisy, given the pose, 
%    control, L, and dt values where
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

%create noisy control inputs

Vvariance = 0.1*(control(1)^2);
Avariance = 5^2;

controlV = control(1) + (randn(1) * sqrt(Vvariance));
controlA = control(2) + (randn(1) * sqrt(Avariance));

if controlA > 80
    controlA = 80;
elseif controlA < -80
    controlA = -80;
end

noisycontrol = [controlV; controlA];

 %create sample

   newpose =  bicycle_forward(pose, noisycontrol, L, dt);

 
end