function y=trans2(k,x)

% C^k transition from 0 to 1 on the interval [0,1]
aux1=trans1(k,x);
aux2=trans1(k,1-x);
y=aux1./(aux1+aux2);