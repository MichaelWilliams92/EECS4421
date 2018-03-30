%% Question 5 of Lab 3
% The following is a Matlab function that finds the location of 
% the wrist center relative to frame {0}, given a transformation matrix

function oc = wristcenter(T05)
%WRISTCENTER computes the wrist center
%  oc = wristcenter(T05) computes the location of the wrist center
%  relative to frame {0}, given T05(The pose of frame {5}, relative
%  to frame {0})

%define variables
O06 = [T05(1,4); 
       T05(2,4);
       T05(3,4)];

R05 = [T05(1,1) T05(1,2) T05(1,3);
       T05(2,1) T05(2,2) T05(2,3);
       T05(3,1) T05(3,2) T05(3,3)];

D5 = 2; % from DH parameters of Question 1, and provided in lab,
        % di should be here
        
Z = [0;
     0;
     1];
 
%compute wrist center
oc = O06 - (D5*R05*Z);