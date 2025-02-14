function [x, flag, res, his]=ccFixedPoint(f,sp) % x0,eps,maxit)

% Functional iteration for solving the equation
%   
%         f(x) = 0
%
% INPUT:
%   f      handler, function 
%   sp     structure, fields
%             x0     vector, the initial guess
%             eps    the tolerance%  
%             maxit  maximum number of iterations
% 
% OUTPUT:
%   x      vector, final approximation
%   flag   integer, such that
%              flag = 0, signals failure
%              flag = 1, signals succes
%   his    array, his(:,j) is the jth approximation
%
% MINIMAL WORKING EXAMPLE: todo

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-12-23 Initial programming and testing

% Extract parameters from structure
x0=sp.x0; eps=sp.eps; maxit=sp.maxit;

% Determine the dimension of the problem
m=numel(x0);

% Reshape
x0=reshape(x0,m,1); 

% Allocate space for output
his=zeros(m,maxit); res=zeros(maxit,1);

% Initialize
x=x0; normx=norm(x); flag=0;

% Define the function g that will be iterated
g=@(x)x+f(x);

% Main loop
for j=1:maxit
    % Compute next approximation
    aux=f(x);
    % Compute relative residual
    res(j)=norm(aux-x)/normx;
    % Test for stagnation
    if res(j)<eps
        % Set flag
        flag=1;
    end
    % Save the current value of x
    his(:,j)=aux;
    % Prepare for the next iteration
    x=aux; normx=norm(x);
    % Test the flag
    if flag>0
        break;
    end
end
% Discard trailing zeros
his=his(:,1:j); res=res(1:j);