%cuadradoSemiMágico(+N, -XS).
cuadradoSemiMagico(N, XS) :- desdeReversible(0, X), length(XS, N),
 todasLasListasSuman(X, N, XS).

% listasDeLQueSuman(+L,+S, +K, -P) %listas Que Suman S de largo K
listasDeLQueSuman(_, 0, 0, []).
listasDeLQueSuman([X|XS], S, K, [X|P]) :- S > 0, K > 0, S2 is S-X, K2 is K - 1, listasDeLQueSuman(XS, S2, K2, P).
listasDeLQueSuman([_|XS], S, K, P) :- S > 0, K > 0, listasDeLQueSuman(XS, S, K, P).

%listasQueSuman(+S, +K, -P). %genera listas de largo K que suman S
listasQueSuman(0, 0, []).
listasQueSuman(S, K, [X|P]) :- between(0, S, X),  K > 0, S2 is S-X, K2 is K - 1, listasQueSuman(S2, K2, P).

%todasLasListasSuman(+S, +K, +L).
todasLasListasSuman(_,_, []).
todasLasListasSuman(S, K, [X|XS]) :- listasQueSuman(S, K, X), todasLasListasSuman(S, K, XS).

desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

iesimo([X|_], 0, X).
iesimo([_|XS], I, Y) :- iesimo(XS, I2, Y), I is I2 + 1.

sumaColumna([], _, 0).
sumaColumna([X|XS], I, Y) :- iesimo(X, I, Z), sumaColumna(XS, I, Y2), Y is Y2 + Z.

columnasQueSuman(M, S) :-  length(M, N), between(0, N, I), sumaColumna(M, I, S).

%cuadradoMagico(+N, -XS)
cuadradoMagico(N, XS) :- cuadradoSemiMagico(N, XS), iesimo(XS, 1, L), sum_list(L, S), columnasQueSuman(XS, S).