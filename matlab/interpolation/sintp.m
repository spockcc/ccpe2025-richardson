function y=sintp(nodes, val, x)

% Slow calculation of a smooth interpolant - obsolete
% 
% CALL SEQUENCE: y=sintp(nodes, val, t)
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
% differentiable at every point in the closed interval [a,b]
% Morever, the function f satisfies
% 
%    f^(k)(nodes(j))/factorial(k) = val(j,1+k)  for k = 0, 1, ... n - 1.
%
% The function is constructed using bump-functions and Taylor polynomials
% The use of g4 is unnecessary and the function is unnecessarily slow if 
% the array x consists of a single point.
%
% SEE ALSO: sintp_fast

% PROGRAMMING by Carl Chrisitian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-12-XX Initial programming and testing


% Determine the number of nodes
l=numel(nodes); nodes=reshape(nodes,l,1);

% Determine the number of nodes and derivatives
[m, n]=size(val);

% Check for user stupidity
if (l~=m)
    fprintf('nodes and val are not compatible');
end

% Initialize the output
y=zeros(size(x));

% Evaluate the first bump function
z=g4(nodes(1)-eps(nodes(1)),nodes(1),nodes(2),x);

% Update the output
y=y+ccHorner(val(1,:),x-nodes(1)).*z;

% Sum over the internal nodes
for i=2:l-1
    z=g4(nodes(i-1),nodes(i),nodes(i+1),x);
    y=y+ccHorner(val(i,:),x-nodes(i)).*z;
end

% Evaluate the last bump function
z=g4(nodes(l-1),nodes(l),nodes(l)+eps(nodes(l)),x);

% Update the output
y=y+ccHorner(val(l,:),x-nodes(l)).*z;