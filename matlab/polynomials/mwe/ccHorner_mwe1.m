% Illustrate the relative error of Horner's method

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Adapted from existing code

% Define the polynomial
p=@(x)4*x.^3-3*x;

% Define the coefficients of the polynomial; the order is critical
a=[0 -3 0 4];

% Define the sample points
t=linspace(-1,1,1001);

% Allow Matlab to evaluate p
y1=p(t);

% Evaluate the polynomial using Horner's method
y2=ccHorner(a,t);

% Evaluate the relative error treat
r=(y1-y2)./y1;

% Plot the relative error
plot(t,log10(abs(r)));

% Finishing touches
xlabel('x'); ylabel('log10(abs(relative error))'); grid;