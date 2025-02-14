% Define the function
f=@(x)x+sin(x);

% Define initial guess
x0=3;

% Set maximum number of iteration
maxit=30;

% Set tolerance
epsilon=1e-15;

% Run the functional iteration
[x, flag, res, his]=ccFixedPoint(f,x0,epsilon,maxit);

% Display results
fprintf("Flag = %d\n",flag);
% Display all relative residual
display(res);
