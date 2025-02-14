function [y]=g3(a,b,x)

% Smooth function that transitions from 0 to 1 on a compact interval

% Evaluate the function
y=g2((x-a)./(b-a));

