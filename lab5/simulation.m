%% Question 3 of Lab 5
% The following is a Matlab function that creates 5 simulations showing 
% samples of the bicycle position after moving over one interval of time.
% For each simulation, 1000 samples are plotted

function simulation()
%SIMULATION() creates 5 simulations showing plotted samples of the bicycle
%after moving over one interval of time.  In the simulations:
%
%   dt = 1
%   L = 1
%   pose is the tranverse of the matrix [0 0 0]
%   control inputs vary according to the simulation

dt = 1;
L = 1;
pose = [0;0;0];

%simulation 1

control = [1;25];
for i=1:1000
    newpose = sample_bicycle(pose, control, L, dt);
   scatter(newpose(1),newpose(2));
    hold on
end

axis equal;

%simulation 2
figure;

control = [1;-25];
for i=1:1000
    newpose = sample_bicycle(pose, control, L, dt);
    scatter(newpose(1),newpose(2));
    hold on
end

axis equal;

%simulation 3
figure;

control = [5;25];
for i=1:1000
    newpose = sample_bicycle(pose, control, L, dt);
     scatter(newpose(1),newpose(2));
    hold on
end

axis equal;

%simulation 4
figure;

control = [1;75];
for i=1:1000
    newpose = sample_bicycle(pose, control, L, dt);
     scatter(newpose(1),newpose(2));
    hold on
end

axis equal;

%simulation 5
figure;

control = [5;75];
for i=1:1000
    newpose = sample_bicycle(pose, control, L, dt);
    scatter(newpose(1),newpose(2));
    hold on
end

axis equal;

end