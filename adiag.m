% Osservazione: sintassi creazione function
% function OUTPUT = NOME_FUNCTION(INPUT)

% Funzione che estrae l'antidiagonale di una matrice quadrata 
% Se la matrice non è quadrata viene mostrato un messaggio di errore 
%
% Input:  a (matrice)
% Ouptut: v (vettore contenente l'antidiagonale di a)

function ris = adiag(a)

ris = [];
n = size(a);

if n(1) ~= n(2)
    error('la matrice deve essere quadrata!');
end

dim = n(1);

for i = 1:dim
    ris(i) = a(i, dim-i+1);
end
