function y=rkw(f, t0, t1, x0, N1, N2, method)

% Wrapper for Runge-Kutta
[~, aux]=rk(f, t0, t1, x0, N1, N2, method);

% Extract the solution at the last time instance
y=aux(:,end);