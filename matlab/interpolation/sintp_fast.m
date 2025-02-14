function y=sintp_fast(nodes, val, t)

% Rapid calculation of a smooth interpolant
% 
% CALL SEQUENCE: y=sintp_fast(nodes, val, t)
% 
% INPUT:
%    nodes  array, dimensions m by 1
%    val    array, dimensions m by n
%    t      array, any dimension
%
% OUTPUT:
%    y      array, y = f(t), see below
%
% Let a = min(nodes) and let b=max(nodes). The function f is infinitely
% differentiable at every point in the half-open interval [a,b).
% Morever, the function f satisfies
% 
%    f^(k)(nodes(j))/factorial(k) = val(j,1+k)  for k = 0, 1, ... n - 1.
%
% The function is constructed using bump-functions and Taylor polynomials

% PROGRAMMING by Carl Chrisitian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-12-05 Initial programming and testing

% Determine number of function values to compute
num=numel(t);

% Test for the common special case
if num==1
    % Assumes that there is only a single value
    if (nodes(1) <=t && t < nodes(end))
        % Find the subinterval
        j=find(nodes<=t,1,'last');
        % t is in the interval nodes(j) <= t < nodes(j+1)
        % Evaluate first function
        z=g3(nodes(j+1),nodes(j),t);
        y=ccHorner_fast(val(j,:),t-nodes(j))*z;
        % Evaluate the next function
        z=g3(nodes(j),nodes(j+1),t);
        y=y+ccHorner_fast(val(j+1,:),t-nodes(j+1))*z;
    else
        y=0;
    end
else
   % Determine number of nodes
   m=numel(nodes);

   % Preallocate memory
   y=zeros(size(t)); z=zeros(size(t));

   % Loop over nodes
   for i=1:m-1
       idx=find(nodes(i)<=t & t<nodes(i+1));
        % t(idx) is in the interval nodes(j) <= t < nodes(j+1)
        % Evaluate first function
        z(idx)=g3(nodes(i+1),nodes(i),t(idx));
        y(idx)=ccHorner_fast(val(i,:),t(idx)-nodes(i)).*z(idx);
        % Evaluate the next function
        z(idx)=g3(nodes(i),nodes(i+1),t(idx));
        y(idx)=y(idx)+ccHorner_fast(val(i+1,:),t(idx)-nodes(i+1)).*z(idx);
   end
end