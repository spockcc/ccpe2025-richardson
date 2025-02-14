% Constructs splines of various orders

% It appears that if the spline has order k, it is of class C^p, p=k-2.

% Define the order
k=3;

% Load the ascii file
A=importdata('mcg1.txt');

% Define spline
sp=spapi(k,A(:,1),A(:,2));

% Define derivatives of approximation
f=@(p,x)fnval(fnder(sp,p),x);

% Plot the drag coefficient
fig1=frame('nw',40);
x1=linspace(0,5,1025);
plot(x1,f(0,x1));

% Plot the derivatives of the drag coefficient 
fig2=frame('ne',40);

% Define sample points
x=linspace(0,0.2,129);

% Plot the function
for j=1:k+1
    subplot(1,k+1,j); plot(x,f(j-1,x));
end
