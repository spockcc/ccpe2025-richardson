% Computes the range of a shell fired from the Flak-36

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-01  Adapted from existing script and including a plot
%   2024-03-04  Reformatted during yearly review

% Load a gun
d20;

% Set elevation
theta=45*pi/180; 

% Select the basic time step size 
dt=1; 

% Set the maximum number of time steps
maxstep=100;

% Compute the range of the shell
[r, flag, t, tra]=range_rk1(param, theta, dt, maxstep);

% Get a figure in the NW quadrant of the screen
fig=frame('nw');

% Plot the trajectory nicely
plot(tra(1,:),tra(2,:)); 

% Adjust axis to use the same scale
axis equal;

% Add a coarse and a fine grid
grid on; grid minor;

% Print the range
fprintf('Range of shell = %.2f meter\n',r);
