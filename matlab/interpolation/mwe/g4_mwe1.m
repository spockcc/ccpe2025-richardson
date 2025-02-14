% Sample points
x=linspace(0,5,1025);

% Evaluate g4 and g4's derivative and the auxiliary function
[y, yp, aux]=g4(1,2,3,x);

% Plot result
plot(x,y,x,yp,x,aux);