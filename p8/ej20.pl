%próximoNumPoderoso(+X,-Y)
proximoNumPoderoso(X,Y) :- Y is X + 1, esPoderoso(Y).
proximoNumPoderoso(X,Y) :- X2 is X + 1, not(esPoderoso(X2)), proximoNumPoderoso(X2, Y). 

esPoderoso(M) :- not((between(2, M, P), esPrimo(P), mod(M,P) =:= 0, P2 is P*P, mod(M,P2) =\= 0)).
esPrimo(P) :- P > 1, X is P-1, not((between(2, X, D), mod(P, D) =:= 0)).