function [z, c]=phi3(f,t,x,dt,nul)

% PHI3 Kernel for an explicit third order Runge Kutta method 
%
% Advances the solution of the ODE
%
%     y'(t) = f(t,y(t))
%
% a single time step using a Runge-Kutta method of order 3.
%
% See also: RK, PHI1, PHI2, PHI4

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se) 
%  Apr 2014    Initial coding and testing.
%  Oct 2014    Minor changes to the text.
%  2015-06-23  Reformated during yearly review.
%  2024-12-04  Compensated summation added 

% Compute auxiliary coefficients
k1=f(t,x);  
k2=f(t+0.5*dt,x+0.5*dt*k1);
k3=f(t+dt,x-dt*k1+2*dt*k2);

% Add the correction to the update 
aux=(dt/6)*(k1+4*k2+k3)+nul;

% Advance the solution a single step and update nul
[z, c]=TwoSum(x,aux);
