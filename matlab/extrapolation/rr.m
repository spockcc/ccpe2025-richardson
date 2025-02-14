function [y, r]=rr(A,h,m,p)

% Repeated Richardson extrapolation

% INPUT:
%   A   array of approximations such that
%          A(i) corresponds to step size h(i)
%   m   number of approximations to involve
%   p   array, the list of exponents from the AEX

% Number of approximations
n=numel(A);

% Number of new approximations
k=n-m;

% number of exponents
np=numel(p);

% Componentwise residual
r=zeros(k,1);

% Array to store extrapolated limits and exponents
y=zeros(np+1,k);

% Main loop
for i=1:k
    % Generate matrix
    B=zeros(m,1+np);

    % Define columns of B
    B=ones(m,1);

    for j=1:np
        B(:,1+j)=h(i:i+m-1).^p(j);
    end
    % Isolate the right-hand side
    f=A(i:i+m-1);
    
    % % Solve the linear system carefully
    % 
    % % QR factorization
    % [Q, R, P]=qr(B);
    % 
    % % Transform right-hand side
    % g=Q'*f;
    % 
    % % Isolate submatrices
    % R1=R(1:1+np,1:1+np); g1=g(1:1+np);
    % 
    % % Try to reduce condition number
    % [P S C]=equilibrate(R1);
    % 
    % % Generate new matrices
    % BB=S*P*R1*C; g2=S*P*g1;
    % 
    % % Solve
    % z=BB\g2; z=C*z;

    
    z=B\f;
    % cond(B)
    % display(B)
    y(:,i)=z;
    % Compute residual
    res=f-B*z; r(i)=norm(res./f,'inf');
end
