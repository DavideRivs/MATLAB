function [xvect, it] = bisezione_locale(a, b, nmax, toll, fun)
    % Implementazione base del metodo di bisezione
    it = 0;
    xvect = [];
    
    if fun(a)*fun(b) > 0
        error('La funzione non cambia segno agli estremi a e b.');
    end
    
    while it < nmax && ((b - a)/2) >= toll
        c = (a + b) / 2;
        xvect = [xvect; c];
        
        if fun(c) == 0
            break; % Trovata radice esatta
        elseif fun(a)*fun(c) < 0
            b = c;
        else
            a = c;
        end
        it = it + 1;
    end
end
