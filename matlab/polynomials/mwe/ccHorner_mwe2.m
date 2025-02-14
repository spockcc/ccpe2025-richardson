% Horner's method and a priori error bounds

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Adapted from existing code

% Define the polynomial
p=@(x)(x-1).^3;

% Define the coefficients
a=[-1 3 -3 1];

% Define the sample points
t=linspace(0.98,1.02,200);

% Evaluate the polynomial directly
y=p(t);

% Evaluate the polynomial using Horner's method
[z, aeb]=ccHorner(a,t);

% Compute the error
e=y-z;

% Plot the absolute value of the error and the apriori error bound
plot(t,log10(abs(e)),t,log10(aeb));

% Finish graphics window
axis([0.98 1.02 -16 -13]); grid; xlabel('x'); 
legend('log10(abs(error))','log10(error bound)');