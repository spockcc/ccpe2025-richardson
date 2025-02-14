% Apply Richardson's techniques to integrating a smooth function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-04-09  Finalized during yearly review

% Interval
a=0; b=1; 

% Function
f=@(x)sin(x).*exp(x); 

% Anti-derivative
F=@(x)0.5*(sin(x)-cos(x)).*exp(x);

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=2; 

% Value of the integral
val=F(b)-F(a);

% Number of refinements
kmax=20; 

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Obtain table parameters
tp=table_param('rdif',data);

% Print the information nicely
print_table(data,tp);

% Plot the evolution of the error, Richardson's fraction and estimate
fig=rplot2(data,p);

% Set file name
fname="exp/int/fig/rint_above.eps";

% Save graphics
exportgraphics(fig,fname);
