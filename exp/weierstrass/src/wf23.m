function [y, cnt]=wf23(k,x)

% Computes a specific Weierstrass function
%
% INPUT:
%   k   nonnegative integer
%   x   array, real numbers
%
% OUTPUT:
%   y   array such that y=f(x)
%
% where f is given by
%
%   f(x) = (s/pi^k) sum_{n=0}^\infty (a/b^k)^n*g(b^n*pi*x)
%
% where a=0.5, b=3, and 
%      g(x) = cos(x) and s =  1 when k is even
%      g(x) = sin(x) and s = -1 when k is odd
%
% MINIMAL WORKING EXAMPLE: wf23_mwe1

% PROGRAMMING by Carl Chrisitian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2024-12-31 Initial programming and testing

% Preallocate space for output
y=zeros(size(x));

% Determine parity
r=mod(k,2);

if r==0
    % Initialize weights
    w=1/pi^k; c=cos(pi*x); d=2*3^k;
    % Count the number of terms added to y
    cnt=0;
    while (w>0)
        % Update y
        y=y+w*c;
        % Update cnt
        cnt=cnt+1;
        % Prepare next weight
        w=w/d;
        % Compute cosine of triple angle
        c=cos3(c);
    end
else
    % Initialize weights
    w=1/pi^k; s=sin(pi*x); d=2*3^k;
    % Count the number of terms added to y
    cnt=0;
    while (w>0)
        % Update y
        y=y+w*s;
        % Update cnt
        cnt=cnt+1;
        % Prepare next weight
        w=w/d;
        % Compute cosine of triple angle
        s=sin3(s);
    end
end
% Finalize sign
r=mod(k,4);
if r>1
    y=-y;
end