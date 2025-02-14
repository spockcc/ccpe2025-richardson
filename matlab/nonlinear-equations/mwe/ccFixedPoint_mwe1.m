% Define the function
f=@(x)cos(x);

% Define initial guess
x0=1;

% Set maximum number of iteration
maxit=30;

% Set tolerance
epsilon=1e-5;

% Run the functional iteration
[x, flag, res, his]=ccFixedPoint(f,x0,epsilon,maxit);

% Display results
fprintf("Flag = %d\n",flag);
% Display all relative residual
display(res);
