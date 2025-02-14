function [y]=g1(x)

% Smooth function that is zero for x < 0

% Initialize output
y=zeros(size(x)); 

% Identify positive x
idx=(x>0);

% Modify the corresponding y values
y(idx)=exp(-1./x(idx));
