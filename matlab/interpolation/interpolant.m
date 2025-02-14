function f=interpolant(x,y,method,order)

% Constructs different kinds of interpolants to 1d data

% Check for user stupidity
mx=numel(x); my=numel(y);
if mx~=my
    return;
end
m=mx;
% Ensure that x and y are column vectors
x=reshape(x,m,1);
y=reshape(y,m,1);

switch lower(method)
    case 'linear'
        f=@(t)interp1(x,y,t);
    case 'spline'
        sp=spline(x,y);
        f=@(t)fnval(sp,t);
    case 'spapi'
        sp=spapi(order,x,y);
        f=@(t)fnval(sp,t);
    case 'smooth'
        % Construct a cubic spline
        cs=spline(x,y);

        % Generate derivatives
        derivs=@(p,x)fnval(fnder(cs,p),x);

        % Scaled values of f and the first 2 derivatives
        val=zeros(m,3);
        for j=1:3
            val(:,j)=derivs(j-1,x)/factorial(j-1);
        end

        % Approximation
        f=@(t)sintp_fast(x,val,t);
    otherwise
        sp=spline(x,y);
        f=@(t)fnval(sp,x);
end
