% Sample points
x=linspace(-1,2,1025);

% Evaluate g1 and g1's derivative
[y, yp]=g1(x);

% Plot result
plot(x,y,x,yp);