function y=sin3(x)

% Computes sine of triple angle
%
% INPUT:
%   x   array, x = sin(theta)
%
% OUTPUT:
%   y   array, y = sin(3*theta)

% Compute result using the trigonometric identity
%   sin(3*theta) = 3*sin(theta)-4*sin(theta)^3
y=x.*(3-4*x.^2);

