function I = trapcomp( a, b, M, f )
%
%    I = trapcomp( a, b, M, f )
%
% Formula dei trapezi composita: 
% Inputs:
%    a,b: estremi di integrazione,
%    M: numero di sottointervalli (m=1 formula di integrazione semplice)
%    f: funzione
% Output:
%    I: integrale calcolato

h = ( b - a ) / M; % ampiezza dei sottointervalli
x = [ a : h : b ]; % estremi dei sottointervalli
y = f( x );

%I = h / 2 * sum( y( 1 : end-1 ) + y( 2:end ) );
I = h * ( 0.5 * y( 1 ) + sum( y( 2 : end-1 ) ) + 0.5 * y( end ) );
