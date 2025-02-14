function [y]=g2(x)

% Smooth function that transitions from 0 to 1

% Evaluate g1 at x
aux1=g1(x);

% Evaluate g1 at 1-x;
aux2=g1(1-x);

% Evaluate the function
y=aux1./(aux1+aux2);

