% Sample points
x=linspace(-1,2,1025);

% Evaluate g3 and g3's derivative
[y, yp]=g3(1,2,x);

% Plot result
plot(x,y,x,yp);