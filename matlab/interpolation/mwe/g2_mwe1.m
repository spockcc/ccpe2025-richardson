% Sample points
x=linspace(-1,2,1025);

% Evaluate g2 and g2's derivative
[y, yp]=g2(x);

% Plot result
plot(x,1-y,x,yp);