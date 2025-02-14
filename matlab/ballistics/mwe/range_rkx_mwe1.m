% Computes the range of a shell fired from the PzH-2000

% Load a representation of the SPA PzH-2000
pzh2000;

% ///////////////////////////////////////////
% Specify how to compute the final time step
% ///////////////////////////////////////////

% This is a subtle question ...
solver=@bisection;
cntl.delta=eps(1)/2;
cntl.eps=eps(1)/2;
cntl.maxit=60;

% ////////////////////////////////////////
% Set time step and elevation
% ////////////////////////////////////////

% Set the elevation of the barrel of the gun
theta=60*pi/180; 

% Compute range r and trajectory tra of shell
[r, flag, t, tra]=range_rkx(param,theta,intp,solver,cntl);

% ////////////////////////////////////////
% Generate a nice plot of the trajectory
% ////////////////////////////////////////

% Get a figure in the NW quadrant of the screen
fig=frame('nw',40);

% Plot the trajectory of the shell.
plot(tra(1,:),tra(2,:),tra(1,:),tra(2,:),...
    'o','MarkerFaceColor','r','MarkerSize',8); 

% Turn on grid lines 
grid on; grid minor; 

% Set the axis
axis([0,25000,0,15000]);

% Print the range
fprintf('Range of shell = %.2f meter\n',r);