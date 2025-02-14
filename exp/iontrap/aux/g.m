function y=trans2(k,x)

aux1=f(k,x);
aux2=f(k,1-x);
y=aux1./(aux1+aux2);