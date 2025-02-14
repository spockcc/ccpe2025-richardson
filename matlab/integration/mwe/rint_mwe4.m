% Apply Richardson's techniques to integrating a smooth function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2025-01-01  Adapted from rint_mwe1

% Interval
a=-1; b=1; 

% Function
f=@(x)sin(pi*x); 

% Anti-derivative
F=@(x)-pi*cos(pi*x);

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=2; 

% Number of refinements
kmax=20; 

% True value of the integral 
val=F(b)-F(a);

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Obtain table parameters
tp=table_param('rdif',data);

% Print the information nicely
print_table(data,tp);

% Handler
fig=frame("nw",40);

% Plot the evolution of Richardson's fraction
plt=plot_fraction(data,p);