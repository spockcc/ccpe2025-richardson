function y=trans0(rho,x)

% Returns 1 for x < rho and 0 for x>= rho

% Initialize the output
y=zeros(size(x));

% Anything less than rho is mapped to 1
y(x<rho)=1;