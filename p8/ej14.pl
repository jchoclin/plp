%cuadradoSemiMágico(+N, -XS)
cuadradoSemiMagico(0, []).
cuadradoSemiMagico(N, XS) :- desdeReversible(0, X), length(XS, N), todasListasQueSuman(X,N,XS).

listasQueSuman(0, 0, []).
listasQueSuman(N, K, [X|XS]) :- K > 0, between(0,N,X), N2 is N - X, K2 is K-1, listasQueSuman(N2, K2, XS).

todasListasQueSuman(_,_,[]).
todasListasQueSuman(N, K, [X|XS]) :- listasQueSuman(N,K,X), todasListasQueSuman(N,K,XS).

desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

desdeReversible(X,Y):- nonvar(Y), X =< Y.
desdeReversible(X,Y):- var(Y), desde(X,Y).

%cuadradoMagico(+N, -XS)
cuadradoMagico(0, []).
cuadradoMagico(N, XS) :- cuadradoSemiMagico(N,XS), columnasSuman(N,XS).
