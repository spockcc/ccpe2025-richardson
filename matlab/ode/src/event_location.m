function [t, x, count, idx]=event_location(f,t0,x0,intp,g,K,tol)

% Event location for ordinary differential equations
%
% Solve the differential equation
%
%   x'(t) = f(t,x(t)),
%   x(t0) = x0
%
% while searching for events of the type
%
%   g(x(t)) = 0 (*)
%
% where g is a real value function. 
%
% This function is based on the RK function and the call sequence is very 
% similar.
%
% CALL SEQUENCE:
%
%    [t, y, count, idx]=event_location(f,t0,x0,intp,g,K,tol)
%
% INPUT:
%   f         a handler to the function f, see below.
%   t0        the initial time        
%   x0        is the initial condition, i.e. x(t0) = x0
%   intp      structure of integration parameters
%               see rk for details
%   g         a handler to a real valued function
%   K         return at most K solutions of (*)
%   tol       a tolerance used to control the accuracy of the solve
%               default value tol = eps(1)/2
% OUTPUT:
%    t      a vector containing at most N+K+1 points in time
%    x      x(:,i) is the approximation of the solution at time t(i).
%    count  the number of events recorded
%    idx    the indices in t and y of the events recorded
%
% NOTES:
%   a) It is assumed that the function f returns a COLUMN vector!
%
% MINIMAL WORKING EXAMPLE: event_location_mwe1
%
% See also: RK

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se) 
%  2015-09-21  Initial programming
%  2015-09-22  Improved inline documentation
%  2015-11-22  Extended call sequence and added minimum working example
%  2016-05-22  Improved inline documentation and formatting
%  2016-05-22  Adapted routine to improved bisection method
%  2024-12-04  Adapted to the new call sequences for rk

% TODO: 
% The game SCORCHED reveals that there are unresolved problems as shells can
% pass straight through the narrow hills. The problem is that the event
% function has the same sign on both sides of the hill, so there is no sign
% change to trigger a search for a zero. 
%   1) Obtain a smooth representation of the solution between data points
%   2) Determine the range of the event function between data points
%   3) Find zeros of the derivative
% Point 1) is relatively easy and there is at least two sensible choices
% involving third order polynomials
%   a) match values and derivatives at the endpoints
%   b) match values at the end points, and match both value and derivative
%      at the midpoint
% Points 2) and 3) are substantionally harder to automate.
% 
% A possibility it to approximate the composition of the event function
% with the trajectory with a cubic polynomial. Then the analysis could be
% automated. This requires the derivative of the event function.


% Force the initial condition to be a COLUMN vector; 
s=numel(x0); x0=reshape(x0,s,1); 

% Extract method, time step and maxstep
method=intp.method; dt=intp.dt; maxstep=intp.maxstep;

% The instances where we record approximations are stored in t
t=zeros(1,maxstep+K+1); 

% Allocate space for storing the solution
x=zeros(s,maxstep+K+1); 

% Save the initial condition 
t(1)=t0; x(:,1)=x0; tau=t0;

% Point to the first column
col=1;

% Evaluate the event function at the initial point and record the sign
g0=g(x0); s0=sign(g0);

% Index to the events
idx=zeros(1,K);

% Initialize the event counter
count=0;
 
% Choose the appropriate method to integrate the ODE
switch lower(method)
    case 'rk1'
        phi=@phi1;
    case 'rk2'
        phi=@phi2;
    case 'rk3'
        phi=@phi3;
    case 'rk4'
        phi=@phi4;
    otherwise
        disp('Unknown method specified. RK1 selected by default');
        phi=@phi1;
end

% Initialize correction
nul=0;

% Test if the user has included a tolerance
if ~exist('tol','var')
    tol=eps(1)/2;
end

% Main loop
for i=1:maxstep
       
    % Advance the current approximation a single time step 
    [aux, nul]=phi(f,tau,x(:,col),dt,nul);
   
    % Evaluate the event function at the new point and record the sign
    g1=g(aux); s1=sign(g(aux));

    % Check for PROPER changes in the sign


    if (s0*s1==-1)

        %------------------------------------------------------------------
        % We know that g(y(tau)) and g(y(tau+dt)) have different sign
        % By continuity, there is an x in (0,1) such that
        %
        %     g(y(tau + x*dt) = 0
        %
        % We are now going to approximate x using the bisection algorithm
        %------------------------------------------------------------------

        % Define a function to feed to the bisection algorithm
        psi=@(s)g(phi(f,tau,x(:,col),s*dt,nul));

        % Set parameters for bisection
        bp.xval=[0; 1];
        bp.fval=[g0; g1];

        % The question of delta and eps is delicate ...
        % ... and the analysis is not complete
        bp.delta=tol*tau/dt; 
        
        % This is a delicated question ...
        % ... and the analysis is not complete
        bp.eps=-1;
        
        % This is enough for the worst case scenario
        bp.maxit=100;

        % Hunt for a solution between tau and tau+dt
        rho=bisection(psi,bp);
                
        % OPEN PROBLEMS
        %  a) Decide if the termination criteria are sensible (hard)
        %     Please contact spock@cs.umu.se if you solve this
        %  b) Replace solver with user defined routine (easy)
        %  c) Record iteration counts to document improvement (easy)

        % Save the corresponding time
        t(col+1)=tau+rho*dt;

        % Save the corresponding state vector and update nul
        [x(:,col+1), nul]=phi(f,tau,x(:,col),rho*dt,nul);

        % Advance the column pointer
        col=col+1;

        % Advance the time
        tau=tau+rho*dt;

        % Advance the event counter
        count=count+1;

        % Save the location of the event
        idx(count)=col;

        % By design we have sign zero at the event
        s1=0;
    else
        % Save the next state vector
        x(:,col+1)=aux; t(col+1)=tau+dt;
        % Advance to the next column
        col=col+1;
        % Advance the time 
        tau=tau+dt;
    end
   
    
    % Have we found enough events?
    if (count==K)
        % K events have been found, stop immediately
        break;   
    end
    
     % Prepare for the next iteration
    g0=g1; s0=s1; 
    
 end

% Remove any trailing zeros from output arrays
t=t(1:col); x=x(:,1:col); idx=idx(1:count);