% Apply Richardson's techniques to integrating a smooth function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-04-09  Finalized during yearly review

% Interval
a=0; b=1; 

% Function
f=@(x)exp(x); 

% Integration rule
rule=@(y,a,b,N)trapezoid_bad(y,a,b,N); 

% Theoretical order of the method 
p=1; 

% Number of refinements
kmax=20; 

% True value of the integral 
val=exp(1)-1;

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