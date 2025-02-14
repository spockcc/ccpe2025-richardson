% Apply Richardson's techniques to integrating a smooth function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-04-09  Finalized during yearly review

% Interval
a=0; b=1/2; 

% Function
f=@(x)wf23(0,x); 

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=2; 

% Number of refinements
kmax=20; 

% Antiderivative
F=@(x)wf23(1,x);

% True value of the integral 
val=F(b)-F(a);

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Obtain table parameters
tp=table_param('rdif',data);

% Print the information nicely
print_table(data,tp);

% Plot the evolution of the error, Richardson's fraction and estimate
fig=rplot2(data,2);

% Set file name
fname="exp/int/fig/rint_wf23.eps";

% Save graphics
exportgraphics(fig,fname);