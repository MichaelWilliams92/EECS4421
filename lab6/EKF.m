%% Lab 6 Question, part B
% The following is a Matlab function that simulates the actual EKF using
% specifications provided in the Lab6 manual. In this EKF, the plant model
% is assumed linear.  
%
% Parts A and C are answered below
%
% A)What is the matrix Ht obtained after linearizing the measurement model?
% Answer: The matrix is fully described below, as the variable H
%
% C)Explain why the starting points produce such different results
% Answer: The reason the two starting points produce such different results
% is at least partially because of their distances from the landmarks.  
% From class slides, we know that uncertainty changes depending on the 
% location of the robot, relative to the landmark locations. As a result,
% depending on where the starting points are situated, the results can
% change drastically.  

function [updatedMu, updatedCov] = EKF(state, covariance, ctrl, z)
% EFK simulates the extended kalman filter and returns the updated state
% and covariance, given the state, covariance, control input and
% measurement model.  

%create identity matrices
A = eye(2);
B = eye(2);
I = eye(2);

%Jacobian matrix
%**NOTE this is the answer to Question Part A**
H = [((2*state(1) - 10)/(2*((state(1) - 5)^2 + state(2)^2)^(1/2))) (state(2)/((state(1) - 5)^2 + state(2)^2)^(1/2));
     ((2*state(1) - 20)/(2*((state(1) - 10)^2 + state(2)^2)^(1/2))) (state(2)/((state(1) - 10)^2 + state(2)^2)^(1/2))];

%Covariance R
R = [0.25^2 0; 
    0 0.25^2];

%Covariance Q
Q = [0.25^2 0; 
    0 0.25^2];

%Prediction step
predictedMu = A * state + B * ctrl + Q * randn(2,1); 
predictedCov = A * covariance * (A') + R; 

d1 = sqrt((predictedMu(1) - 5)^2 + (predictedMu(2) - 0)^2);
d2 = sqrt((predictedMu(1) - 10)^2 + (predictedMu(2) - 0)^2);
Zexpected = [d1;d2];
    
%Correction step
B = predictedCov * H';
S = H * predictedCov * H' + Q; 
K = B / S; 

updatedMu = predictedMu + K * (z - Zexpected);
updatedCov = (I - K * H) * predictedCov;

end