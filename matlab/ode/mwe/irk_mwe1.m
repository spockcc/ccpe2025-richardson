% Solve an initial value problem using a Runge-Kutta method

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Initial programing and testing

% Set the function that drives the differential equation
f=@(t,x)-0.1*x; 

% Specify the time interval
t0=0; t1=1; 

% Set the initial condition
x0=5; 

% Specify number of sample points
N1=10; 

% Specify the number time steps betweeen sample points
N2=2; 

% Select the method used to solve the problem
method='irk1';

% Specify solver and tolerance
solver=@ccFixedPoint;
cntl.eps=1e-6;

% Approximate the solution of the initial value problem
[t, y]=rk(f,t0,t1,x0,N1,N2,method,solver,cntl);

% Display the computed solution
plot(t,y,t,y,'*'); xlabel('t'); ylabel('y');

% Grids
grid; grid minor;