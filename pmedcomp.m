function I = pmedcomp( a, b, M, f )

% Formula del punto medio composita: 
% Inputs:
%    a,b: estremi di integrazione,
%    M: numero di sottointervalli (m=1 formula di integrazione semplice)
%    f: funzione
% Output:
%    I: integrale calcolato

h = ( b - a ) / M; % ampiezza dei sottointervalli

x = [ a + h / 2 : h : b - h / 2 ]; % punti medi dei sottointervalli

I = h *sum( f(x) );
