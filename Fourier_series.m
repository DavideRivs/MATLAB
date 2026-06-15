function [coefficients]=Fourier_series(f,p,n)
% INPUT f function
%       p period
%       n order of the Fourier series
% OUTPUT coefficients of the truncated Fourier series
%        first  the coefficient  of the constant function
%        second the coefficients of k   cosine   functions
%        third  the coefficients of k   sine     functions

% Coefficient of the constant function
coefficients = zeros(1,2*n+1);
coefficients(1)=(1/p)*integral(f,0,p);

% Coefficients of the cosine functions
for j=1:n
    % j is the ``order'' of the cosine function
    f_cos=@(x)f(x).*cos(j*(2*pi/p)*x);
    coefficients(1+j)=(2/p)*integral(f_cos,0,p);
end

% Coefficients of the sine functions
for j=1:n
    % j is the ``order'' of the cosine function
    f_sin=@(x)f(x).*sin(j*(2*pi/p)*x);
    coefficients(n+1+j)=(2/p)*integral(f_sin,0,p);
end
return
