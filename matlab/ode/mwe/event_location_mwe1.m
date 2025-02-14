% Find the point of impact of a shell fired from a gun

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Initial programing and testing
%   2024-12-04 Updated to handle improved calls sequence 

% Load the gun
pzh2000;

% Change the atmosphere to the fast routine
param.atmo=@(x)ccatmos(x);

% Set the elevation of the barrel of the gun
theta=30*pi/180; 

% Define the starting time
t0=0;

% Define the initial condition
x0=[0; 0; param.v0*cos(theta); param.v0*sin(theta)];
    
% Define the function that drives the differential equation
f=@(t,x)shell4a(param,t,x);

% Define the event function, i.e., isolate the y coordinate
g=@(x)x(2);

% Set the maximum number of events
K=1;

% Set method and order
intp.method='rk1'; p=1;

% Fire the shell and search for the point of impact
[t, tra, count, idx]=event_location(f,t0,x0,intp,g,K);

% Handler to figure
fig=frame('nw',40);

% Plot the entire trajectory
pl=plot(tra(1,:),tra(2,:),tra(1,:),tra(2,:));

% Change the line width
pl(1).LineWidth=2;

% Set the dots
pl(2).LineStyle='none';
pl(2).Marker='o';
pl(2).MarkerFaceColor='r';
pl(2).MarkerSize=8;

% Labels
xlabel('x (meter)'); ylabel('y (meter)');

% Grids
grid on; grid minor;

% Number of approximations
kmax=5;

% Approximations
A=zeros(kmax,1);

% Start the clock
tic;
for i=1:kmax
  % Run event location routine
  [t, tra, count, idx]=event_location(f,t0,x0,intp,g,K);
  % Save range assuming that all went well
  A(i)=tra(1,end);
  h(i)=intp.dt;
  % Prepare for the next iteration
  intp.dt=intp.dt/2;
  intp.maxstep=intp.maxstep*2;
end

% Apply Richardson's analysis to the data
data=richardson(A,p);
tp=table_param('rdif',data);
print_table(data,tp);

% Stop the clock
toc;
