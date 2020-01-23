clear
close all
addpath(genpath([pwd '\tissue']))
addpath(genpath([pwd '\tip']))

% global CONTACT_OFFSET
% PARAMS('CONTACT_OFFSET',0.05);

iend=13;
theta=[];
for i=1:iend
    theta=deflection(i,[0 theta]);
end
L=CONFIG('L');
n=CONFIG('n');
l=L/n;
SP=CONFIG('START_POINT');
CP=CONFIG('CONTACT_POINT');
x=CP(1); y=CP(2); z=CP(3); 
tip_start=SP+[x-(n-iend)*l 0 0];
traj=[tip_start;CP];
thetai=0;
for i=1:iend
    thetai=thetai+theta(i);
    x=x+l*cos(thetai);
    z=z+l*sin(thetai);
    traj=[traj;[x y z]];
end
drawBlock
drawTrajectory(traj)
Traj=TrajPlanner() % The Planner return you a set of points as the path, set the Target Point in CONFIG