function y=trans3(a,b,k,x)

% C^k transition from 0 to 1 on interval [a,b].

y=trans2(k,(x-a)./(b-a));