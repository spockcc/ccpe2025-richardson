function [y]=g4(a,b,c,x)

% Smooth bump function for a compact interval

% Evaluate component functions
aux1=g3(a,b,x);
aux2=g3(c,b,x);

% Function
y=aux1.*aux2;

