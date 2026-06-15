function [t_h, U, iter_pf] = eulero_indietro(f, t0, T, y_0, h)
%
% Risolve il problema di Cauchy 
%
% y' = f(t, y)
% y(0) = y_0
%
% utilizzando il metodo di Eulero Indietro 
% (Eulero Implicito) : u_{n+1}=u_n+h*f(t_{n+1},u_{n+1}). 
% Per ciascun istante temporale l'equazione per u_(n+1)
% (a priori non lineare) viene risolta con un metodo di punto fisso:
%  u=u_n+delta_t*f(t_{n+1},u), utilizzando la funzione di iterazione 
% 
% phi(x)=u_n + h *f(t_{n+1},x)
%
% la condizione per la convergenza del metodo di punto fisso ( |phi(x)'|<1)
% e' h*|\partial_x f(t_{n+1},x)| < 1
% ed e' garantita se h e' sufficientemente piccolo. 
%
% Input:
% -> f: function che descrive il problema di Cauchy 
%       (dichiarata ad esempio tramite @) 
%       deve ricevere in ingresso due argomenti: f=f(t,y)
% -> t0, T: estremi dell' intervallo temporale di soluzione 
% -> y_0: il dato iniziale del problema di Cauchy
% -> h: l'ampiezza del passo di discretizzazione temporale.
%
% Output:
% -> t_h: vettore degli istanti in cui si calcola la soluzione discreta
% -> U: la soluzione discreta calcolata nei nodi temporali t_h
% -> iter_pf: vettore che contiene il numero di iterazioni 
%                di punto fisso utilizzate per risolvere l'equazione 
%                non lineare ad ogni istante temporale.

% vettore degli istanti in cui risolvo la ode
t_h = t0:h:T;

% inizializzo il vettore che conterra' la soluzione discreta
N_istanti = length(t_h);
U = zeros(1, N_istanti);

% ciclo iterativo che calcola u_(n+1) = u_n + h*f_(t_{n+1},u_{n+1}) . 
% Ad ogni iterazione temporale devo eseguire delle sottoiterazioni
% di punto fisso per il calcolo di u_(n+1): 
%
% u_(n+1)^(k+1) = u_n + h * f_( t_(n+1) , u_(n+1)^k ). 
U(1) = y_0;

% parametri per le iterazioni di punto fisso
N_max = 100;
toll = 1e-5;
iter_pf = zeros(1, N_istanti);

for it = 2:N_istanti
    % preparo le variabili per le sottoiterazioni
    u_old = U(it-1);
    t_pf = t_h(it);
    
    phi = @(u) u_old + h * f( t_pf, u );
    % Permette di dichiarare la funzione phi che ha come variabili quelle
    % definite tra parentesi dopo la @, in questo caso la u. Gli altri
    % termini vengono interpretati da matlab come costanti.
    
    % sottoiterazioni
    [u_pf, it_pf] = ptofis(u_old, N_max, toll, phi);
    U(it) = u_pf(end);
    % tengo traccia dei valori di it_pf per valutare la convergenza 
    % delle iterazioni di punto fisso
    iter_pf(it) = it_pf;
end
