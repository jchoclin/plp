%unico(+L, -U).
unico(L, U) :- length(L, N), between(0, N, X), iesimo(L, X, U), esUnico(L, U).

esUnico(L, U) :- length(L, X), borrar(L, U, L2), length(L2, Y), Y is X-1.

borrar([], _, []).
borrar([Y|YS], X, [Y|ZS]) :- X \= Y, borrar(YS, X, ZS).
borrar([X|YS], X, ZS) :- borrar(YS, X, ZS).

desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

iesimo([X|_], 0, X).
iesimo([_|XS], I, Y) :- iesimo(XS, I2, Y), I is I2 + 1.

%sinRepetidos(+L)
sinRepetidos([]).
sinRepetidos([X|XS]) :- not(member(X, XS)), sinRepetidos(XS).




