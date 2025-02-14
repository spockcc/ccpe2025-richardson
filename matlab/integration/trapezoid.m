function s=trapezoid(y,a,b,N)

% TRAPEZOID Composite trapezoidal rule for a function on an interval
%
% CALL SEQUENCE: s=trapezoid(y,a,b,N)
%
% INPUT:
%   y      the function values on N+1 equidistant points on [a,b]
%   a, b   the interval 
%   N      determines the stepsize, h=(b-a)/N
% 
% OUTPUT:
%  s      the trapezoidal sum. 
%
% MINIMAL WORKING EXAMPLE: trapezoid_mwe1
%
% See also: RINT

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2015-XX-YY  Initial programming and testing
%  2016-06-28  Reformatted during yearly review
%  2024-04-09  Minimal working example moved to separate file
%  2024-12-31  Added error free transformations

% Compute the length of the subintervals
h=(b-a)/N;

% Scale the input
m=numel(y); idx=2:m-1; y(idx)=2*y(idx); y=y*h/2;

% Compute the trapezoidal sum.
s=0; nul=0;
for i=1:m
    % Add the correction to the current term
    t=y(i)+nul;
    % Compute the next term and the correction
    [s,nul]=TwoSum(s,t); 
end