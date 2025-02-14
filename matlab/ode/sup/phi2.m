function [z, c]=phi2(f,t,x,dt,nul)

% PHI2 Kernel for a second order explicit Runge-Kutta method
%
% Advances the solution of the ODE
%
%     y'(t) = f(t,y(t))
%
% a single time step using Heyn's method.
%
% See also: RK, PHI1, PHI3, PHI4

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se) 
%  Apr 2014    Initial coding and testing.
%  Oct 2014    Minor changes to the text.
%  2015-06-23  Reformated during yearly review.
%  2024-12-04  Compensated summation added 

% Compute auxiliary coefficients
k1=f(t,x); 
k2=f(t+dt,x+dt*k1);

% Add the correction to the update 
aux=0.5*dt*(k1+k2)+nul;

% Advance the solution a single step and update nul
[z, c]=TwoSum(x,aux);