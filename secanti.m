function [xvect, it] = secanti_locale(x0, x1, nmax, toll, fun)
    % Implementazione base del metodo delle secanti
    it = 0;
    xvect = [x0; x1];
    incr = toll + 1;
    
    while it < nmax && incr >= toll
        f1 = fun(x1);
        f0 = fun(x0);
        
        if f1 - f0 == 0
            disp(' Arresto per azzeramento del denominatore nelle secanti');
            break;
        end
        
        % Formula delle secanti
        xn = x1 - f1 * (x1 - x0) / (f1 - f0);
        
        incr = abs(xn - x1);
        xvect = [xvect; xn];
        
        % Aggiornamento per l'iterazione successiva
        x0 = x1;
        x1 = xn;
        it = it + 1;
    end
end
