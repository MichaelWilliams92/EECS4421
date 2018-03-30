%% Lab 6 Question, part B
% The following is a Matlab function that creates the EKF simulation as
% specified in the Lab 6 manual.  This function specifically calls the EKF
% function and outputs its results into 2 seperate graphs.  
%
% The solutions to Question parts A and C are included in the EFK function
% code.  Please refer there for answers.

function simulation()

%starting location estimates for both simulations
X01 = [0;9];
X02 = [0;-5];

%actual starting position
XTrue = [0;2];

%estimated state covariance
covariance = [4 0;
              0 4];
    
%ending position
goal = [15; -2];

%Covariance Q
Q = [0.25^2 0; 
    0 0.25^2];

%Covariance R
R = [0.25^2 0; 
    0 0.25^2];

%figure1
figure();
scatter(XTrue(1), XTrue(2), 25, '*', 'red');
scatter(X01(1),X01(2),25,'blue');
hold on

for i = 0:25
    
    ctrl = goal - X01;
    ctrl = [ctrl(1)/sqrt(ctrl(1)^2 + ctrl(2)^2); ctrl(2)/sqrt(ctrl(1)^2 + ctrl(2)^2)];
    
    d1 = sqrt((XTrue(1) - 5)^2 + (XTrue(2) - 0)^2);
    d2 = sqrt((XTrue(1) - 10)^2 + (XTrue(2) - 0)^2);
    z = [d1;d2] + R * randn(2,1);
    
    [updatedMu, updatedCov] = EKF(XTrue, covariance, ctrl, z);
    [X01, updatedCov1] = EKF(X01, covariance, ctrl, z);
    XTrue = XTrue + ctrl + Q*randn(2,1);
    covariance = updatedCov;
    
    scatter(updatedMu(1), updatedMu(2), 25,'*', 'red');
    scatter(X01(1), X01(2), 25, 'blue');
    hold on
    axis([-0.5 16 -6 10]);
end

%figure2
figure();
XTrue = [0;2];
covariance = [4 0;
              0 4];
          
scatter(XTrue(1), XTrue(2), 25, '*', 'red');
scatter(X02(1),X02(2),25,'blue');
hold on 

for i = 0:25
    
    ctrl = goal - X02;
    ctrl = [ctrl(1)/sqrt(ctrl(1)^2 + ctrl(2)^2); ctrl(2)/sqrt(ctrl(1)^2 + ctrl(2)^2)];
    newCtrl = [ctrl(1); -ctrl(2)];
    
    d1 = sqrt((XTrue(1) - 5)^2 + (XTrue(2) - 0)^2);
    d2 = sqrt((XTrue(1) - 10)^2 + (XTrue(2) - 0)^2);
    z = [d1;d2] + R * randn(2,1);
    
    [updatedMu, updatedCov] = EKF(XTrue, covariance, newCtrl, z);
    [X02, updatedCov2] = EKF(X02, covariance, ctrl, z);
    XTrue = XTrue + newCtrl + Q*randn(2,1);
    covariance = updatedCov;
    
    scatter(updatedMu(1), updatedMu(2), 25,'*', 'red');
    scatter(X02(1), X02(2), 25, 'blue');
    hold on
    axis([-0.5 16 -6 10]);
end

end