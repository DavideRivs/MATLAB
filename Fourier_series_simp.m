function [coefficients] = Fourier_series_simp(f, p, n, M)
    
    coefficients = zeros(1, 2*n+1);
    
    % Coefficient of the constant function
    coefficients(1) = (1/p) * simpcomp(0, p, M, f);
    
    % Coefficients of the cosine functions
    for j = 1:n
        f_cos = @(x) f(x) .* cos(j*(2*pi/p)*x);
        coefficients(1+j) = (2/p) * simpcomp(0, p, M, f_cos);
    end
    
    % Coefficients of the sine functions
    for j = 1:n
        f_sin = @(x) f(x) .* sin(j*(2*pi/p)*x);
        coefficients(n+1+j) = (2/p) * simpcomp(0, p, M, f_sin);
    end
end
