% Horner's method with a priori and running error bounds

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-03-07 Adapted from existing code

% Define the polynomial
p=@(x)(x-2).^3;

% Define the coefficients
a=[-8 12 -6 1];

% Define the sample points
t=linspace(1.97,2.03,200);

% Evaluate the polynomial using *single precision* 
% Compute the apriori error bound and the running error bound 
[z, aeb, reb]=ccHorner(single(a),t);

% Plot the polynomial and the error bounds
plot(t,abs(z),t,aeb,t,reb); xlabel('x'); 

% Legend
l={'abs(p(x))','apriori error bound', 'running error bound'};
legend(l,'Location','Best'); 

% Grid
grid;