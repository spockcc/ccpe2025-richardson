function y=cos3(x)

% Computes cosine of triple angle
%
% INPUT:
%   x   array, x = cos(theta)
%
% OUTPUT:
%   y   array, y = cos(3*theta)

% Compute result using the trigonometric identity
%   cos(3*theta) = 4*cos(theta)^3-3*cos(theta)
y=x.*(4*x.^2-3);

