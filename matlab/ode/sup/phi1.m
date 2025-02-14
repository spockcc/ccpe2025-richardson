function [z, c]=phi1(f,t,x,dt,nul)

% PHI1 Kernel for Euler's explicit method of order 1
%
% Advances the solution of the ODE 
%
%     x'(t) = f(t,x(t))
%
% a single time step using Euler's explicit method.
%
% See also: RK, PHI2, PHI3, PHI4

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se) 
%  Apr 2014    Initial coding
%  Oct 2014    Minor changes to the text.
%  2015-06-23  Reformated during yearly review.
%  2024-12-04  Compensated summation added 

% Compute the auxiliary coefficient
k1=f(t,x); 

% Add the correction to the update 
aux=dt*k1+nul;

% Advance the solution a single step and update nul
[z, c]=TwoSum(x,aux);