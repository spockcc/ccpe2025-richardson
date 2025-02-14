function [table, flag]=compute_range(param, theta, intp, solver, cntl)

% COMPUTE_RANGE Computes the range as function of the elevation
%
% CALL SEQUENCE: 
%
%   [table, flag]=compute_range(param, theta, intp, solver, cntl)
%
% INPUT:
%   param     structure, describes the physics
%                mass    mass of the shell
%                cali    caliber of the shell
%                v0      muzzle velocity of the shell
%                drag    function computing the drag coeffient
%                atmo    function computing the atmosphere
%                grav    function computing gravity
%   theta     array of elevations
%   intp      structure, describing how the ODE is solved
%                method   string naming the method, see rk for options
%                dt       basic time step, 
%                maxstep  maximum number of time steps
%   solver    handler to function for solving nonlinear equations
%   cntl      structure of parameters for solver
%                cntl.delta    controls the error
%                cntl.epsilon  controls the residual
%                cntl.maxit    controls maximum number of iterations
% OUTPUT:
%   table     a two dimensional array, such that
%               table(j,1) = theta(j)
%               table(j,2) = the range obtained with elevation theta(j)
%               table(j,3) = the corresponding flight time 
%   flag      if flag =  1, then everything went smoothly
%             if flag = -j, then execution failed using jth elevation
%
% NOTE: Failures are often caused by small values of maxstep
%
% MINIMAL WORKING EXAMPLE: compute_range_mwe1
%
% See also: RANGE_RK1, RANGE_RKX

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  Fall 2014 : Initial programming and testing
%  2015-09-22: Integrated global variables m, k, g into structure
%  2015-09-22: Minor improvement of documentation
%  2015-10-31: Replaced structure const with mandatory PARAM
%  2016-06-27: Integrated displaytable()
%  2016-09-09: Adapted function to SHELL4A
%  2024-03-01: Moved printing to seperate function
%  2024-03-04: Added solver parameters, cntl
%  2024-03-15: Added integration parameters, intp

% Reshape and sort the array containing the elevations
m=numel(theta); theta=reshape(theta,m,1); theta=sort(theta,'ascend');

% Artillery computations are not trivial, but let us be optimistic :)
flag=1;

% Initialize the table
table=zeros(m,3);

% Number of decimal digits of m 
num=floor(log10(m)+1);
fprintf('Computing %*d trajectories\n',num,m);

% Loop over the input angles
for j=1:m 
    % Print a dot to mark the current progress
    fprintf('.');
    % Compute the ith range
    [r, rf, t, ~]=range_rkx(param, theta(j), intp, solver, cntl);
    % Save the elevation
    table(j,1)=theta(j);
    % But .... did the shell hit the ground?
    if (rf==0) 
        % Failure!
        % A more advanced routine would double maxstep and try again!
        % What is the physical meaning of maxstep*dt?
        fprintf('Insufficient flight time allocated for elevation = %f',theta(j));
        % Here we signal failure ....
        flag=-j;
        % Record NaN because humans often forget to check flags
        % NaN is a brutal way to get the attention of a human
        table(j,2)=NaN; table(j,3)=NaN;
        % ... and break out of the loop
        break;
    else
       % Success! Save the computed values
       table(j,2)=r; table(j,3)=t(end);
    end    
end

% Remove any trailing zeros from output arrays
table=table(1:j,:);

% Skip a few lines
fprintf('\n\n');