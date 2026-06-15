function [t_h, U, iter_nwt] = eulero_indietro_newton(f, df, t0, T, y_0, h)
%
% Risolve il problema di Cauchy 
%
% y' = f(t, y)
% y(0) = y_0
%
% utilizzando il metodo di Eulero Indietro 
% (Eulero Implicito) : u^{n+1}=u^n+h*f^{n+1}. 
% Per ciascun istante temporale l'equazione per u^(n+1)
% (a priori non lineare) viene risolta con un metodo di newton.
%
% Input:
% -> f: function che descrive il problema di Cauchy 
%       (dichiarata ad esempio tramite @) 
%       deve ricevere in ingresso due argomenti: f=f(t,y)
% -> df: function derivata prima di f
% -> t0, T: estremi dell' intervallo temporale di soluzione 
% -> y_0: il dato iniziale del problema di Cauchy
% -> h: l'ampiezza del passo di discretizzazione temporale.
%
% Output:
% -> t_h: vettore degli istanti in cui si calcola la soluzione discreta
% -> U: la soluzione discreta calcolata nei nodi temporali t_h
% -> iter_nwt: vettore che contiene il numero di iterazioni 
%                di newton utilizzate per risolvere l'equazione 
%                non lineare ad ogni istante temporale.

% vettore degli istanti in cui risolvo la ode
t_h = t0:h:T;

% inizializzo il vettore che conterra' la soluzione discreta
N_istanti = length(t_h);
U = zeros(1, N_istanti);

% ciclo iterativo che calcola u_(n+1) = u_n + h*f_(n+1) . 
% Ad ogni iterazione temporale devo eseguire delle sottoiterazioni
% di punto fisso per il calcolo di u_(n+1): 
%
% u_(n+1)^(k+1) = u_n + h * f_( t_(n+1) , u_(n+1)^k ). 
U(1) = y_0;

% parametri per le iterazioni di newton
N_max = 100;
toll = 1e-5;
iter_nwt = zeros(1, N_istanti);

for it = 2:N_istanti
    
    % preparo le variabili per le sottoiterazioni
    u_old = U(it-1);
    t_nwt = t_h(it);
    
    % sottoiterazioni di newton
    phi =  @(u) u - u_old - h * f( t_nwt, u );
    dphi = @(u) 1 - h * df( t_nwt, u );
    
    % sottoiterazioni
    [u_nwt, it_nwt] = newton(u_old, N_max, toll, phi, dphi);
    U(it) = u_nwt(end);
    
    % tengo traccia dei valori di it_nwt per valutare la convergenza 
    % delle iterazioni di newton
    iter_nwt(it) = it_nwt;
    
end
