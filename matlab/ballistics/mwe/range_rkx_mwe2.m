% Computes the range of a shell fired from the PzH-2000

% Load a representation of the SPA PzH-2000
pzh2000;

% ///////////////////////////////////////////
% Specify how to compute the final time step
% ///////////////////////////////////////////

% This is a subtle question ...
solver=@robust_secant;
cntl.delta=10*eps(1)/2;
cntl.eps=10*eps(1)/2;
cntl.maxit=60;

% ////////////////////////////////////////
% Set time step and elevation
% ////////////////////////////////////////

% Set the elevation of the barrel of the gun
theta=30*pi/180; 

% Number of approximations
kmax=14;

% Approximations
A=zeros(kmax,1);

for i=1:kmax
  % Compute range r and trajectory tra of shell
  [r, flag, t, tra]=range_rkx(param,theta,intp,solver,cntl);
  % Save range
  A(i)=r;
  h(i)=intp.dt;
  % Prepare for the next iteration
  intp.dt=intp.dt/2;
  intp.maxstep=intp.maxstep*2;
end

data=richardson(A,1);
tp=table_param('rdif',data);
print_table(data,tp);

y=rr(A,h,4,[4 5]);

