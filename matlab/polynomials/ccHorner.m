function [y, aeb, reb, dy]=ccHorner(a,x)

% An implementation of Horner's method
%
% CALL SEQUENCE:
%
%  [y, aeb, reb, dy]=ccHorner(a,x)
%
% INPUT:
%  a      array of cofficients determining p
%  x      array of arguments to pass to p
%
% OUTPUT:
%  y      the computed value of the polynomial
%  aeb    an apriori error bound for y
%  reb    a runing error bound for y
%  dy     the computed value of the derivative
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

% Both a and x must be in double precision or MATLAB works in single
if (isa(a,'double') && isa(x,'double'))
    % Set u to double precision unit roundoff
    u=2^-53;
else
    % Set u to single precision unit round off
    u=2^-24;
end

% Reshape the coefficient array as a row vector
aux=reshape(a,1,m); 

% Initialize the output arrays
sx=size(x); y=ones(sx)*aux(m); pt=ones(sx)*abs(aux(m)); 

% Initialize running error bound
mu=zeros(sx); 

% Initialize derivative
dy=zeros(sx);

% Main loop.
for j=1:n
    % Update the derivative
    dy=dy.*x+y;
    % Compute intermediate value
    z=y.*x;
    % Update polynomial p
    y=z+aux(m-j);
    % Update running error bound
    mu=mu.*abs(x)+abs(z)+abs(y);
    % Update polynomial pt
    pt=abs(x).*pt+abs(aux(m-j));
end

% Compute the gamma factor
gamma=(2*n*u)/(1-2*n*u);

% Compute the apriori error bound
aeb=gamma*pt;

% Compute the running error bound
reb=u*mu;