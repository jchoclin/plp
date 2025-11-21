desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

esPrimo(X):- X>1, XAnt is X-1, not((between(2,XAnt, D), mod(X,D) =:= 0)).

esPoderoso(M):- not((between(2, M, P), esPrimo(P), mod(M,P*P) =\= 0, mod(M,P) =:= 0)).

% próximosNumPoderoso(+X,-Y)
próximosNumPoderosos(X,Y):- esPoderoso(X), XSuc is X + 1, desdeReversible(XSuc,Y), esPoderoso(Y).
próximosNumPoderosos(X,Y):- not(esPoderoso(X)), desdeReversible(X,Y), esPoderoso(Y).


próximoNumPoderoso(X,Y):- Y is X + 1, esPoderoso(Y).
próximoNumPoderoso(X,Y):- X2 is X + 1, not(esPoderoso(X2)), próximoNumPoderoso(X2,Y).