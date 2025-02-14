% Apply Richardson's techniques to integrating a nonsmooth function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-04-09  Finalized during yearly review

% Interval
a=0; b=1; 

% Function
f=@(x)sqrt(x); 

% Anti-derivative
F=@(x)(2/3)*x.^(3/2);

% Integral
val=F(b)-F(a);

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=1.5; 

% Number of refinements
kmax=25; 

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