function [x, k, res_hist] = jacobi(A, b, x0, toll, nmax)
% Metodo di Jacobi:
% A: matrice del sistema
% b: termine noto
% x0: vettore iniziale
% toll: tolleranza sul residuo normalizzato
% nmax: massimo numero di iterazioni
%
% x: soluzione ottenuta
% k: numero di iterazioni effettuate
% res_hist: vettore contenente la storia del residuo normalizzato

n = size(b,1);
% Controlliamo che la matrice A sia quadrata e dimensioni compatibili
if ((size(A,1) ~= n) || (size(A,2) ~= n) || (size(x0,1) ~= n))
  error('Dimensioni incompatibili')
end

% Controlliamo che la matrice A non abbia elementi diagonali nulli.
if (prod(diag(A)) == 0)
  error('Errore: elementi diagonali nulli')
end

% Estraiamo la matrice D da A e calcoliamo Bj e f
D = diag(diag(A));
Bj = eye(n) - D\A;
f = D\b;

% Inizializziamo x come x0, calcoliamo il residuo iniziale
x = x0;
r = b - A*x;
res_norm = norm(r)/norm(b);

% Prepariamo il vettore per salvare lo storico dei residui
res_hist = zeros(nmax+1, 1);
res_hist(1) = res_norm; % Salviamo il residuo all'iterazione 0

% Inizializziamo l'indice d'iterazione
k = 0;
while (res_norm > toll && k < nmax)
    k = k + 1;
   
    % Aggiorniamo approssimazione x
    x = Bj*x + f;
    
    % Aggiorniamo residuo e calcoliamo la nuova norma
    r = b - A*x;
    res_norm = norm(r)/norm(b);
    
    % Salviamo il residuo corrente nello storico
    res_hist(k+1) = res_norm;
end

% Tagliamo il vettore res_hist per rimuovere gli zeri in eccesso
% (nel caso il metodo converga prima di nmax iterazioni)
res_hist = res_hist(1:k+1);

end
