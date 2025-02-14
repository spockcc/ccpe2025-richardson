% 1st order divided difference for a C2 function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2025-12-02 Adapted to the format used by CCPE

% Set trial function
f=@(x)wf23(2,x);

% Set point where we want to estimate the derivative
x=1.2; 

% Define the finite difference approximation
D1=@(g,x,h)(g(x+h)-g(x))./h; 

% Set the theoretical order of the method
p=1;

% Set the basic stepsize
h0=1; 

% Set the number of times we will reduce the stepsize by a factor of 2
kmax=25; 

% Define the real derivative
df=@(x)wf23(1,x);

% Apply Richardson's techniques
data=rdif(f,x,D1,p,h0,kmax,df);

% Obtain table parameters
tp=table_param('rdif',data);

% Print the information nicely
print_table(data,tp);

% Plot the evolution of Richardson's fraction
fig=rplot2(data,p);

% Set file name
fname="exp/dif/fig/wf23dif_type2.eps";

% Save graphics
exportgraphics(fig,fname);
