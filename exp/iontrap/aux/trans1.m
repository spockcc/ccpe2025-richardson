function y=trans1(k,x)

% Initialize output
y=zeros(size(x));

% Identify positive x
idx=(x>0);

% Modify the corresponding y values
if (k<Inf)
    y(idx)=x(idx).^(k+1);
else
  y(idx)=exp(-1./x(idx));
end