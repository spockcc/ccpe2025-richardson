function y=wfn23(n,x)

% Computes a specific Weierstrass function
%
% INPUT:
%   n   number of terms to include
%   x   array, real numbers
%
% OUTPUT:
%   y   array such that y=f(x)
%
% where f is given by
%
%   f(x) = sum_{j=0}^{n-1} a^j*cos(b^j*pi*x)
%
% for the specific choice of (a,b) = (0.5,3).
%
% MINIMAL WORKING EXAMPLE: wf23_mwe1

% PROGRAMMING by Carl Chrisitian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-12-31 Initial programming and testing

% Initialize weights
w=1; c=cos(pi*x); 

% Initial iteration
t=w*c; y=t;

% Main loop
for j=1:n-1
    % New weight
    w=w/2;
    % Compute cosine of triple angle
    c=cos3(c);
    % New term
    t=w*c;
    % Update y
    y=y+t;
end