function [y]=ccHorner_fast(a,x)

% An implementation of Horner's method
%
% CALL SEQUENCE:
%
%  [y]=ccHorner_fast(a,x)
%
% INPUT:
%  a      array of cofficients determining p
%  x      array of arguments to pass to p
%
% OUTPUT:
%  y      the computed value of the polynomial
%
% MINIMAL RUNNING EXAMPLE: ccHorner_mwe1, ccHorner_mwe2, ccHorner_mwe3

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2020-11-02  Adapted from earlier code.
%   2020-11-02  Added minimal working examples
%   2024-03-09  Updated documentation during yearly review

% Isolate the number of coefficients
m=numel(a); 

% Isolate the degree of the polynomial
n=m-1;

% Initialize the output arrays
sx=size(x); y=ones(sx)*a(m); 

% Main loop.
for j=1:n
    % Update polynomial p
    y=y.*x+a(m-j);
end



