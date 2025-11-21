%last(?L, ?U)
last([X], X).
last([_|XS], Y) :- last(XS, Y).
%last(L,U) :- append(_, [U], L).

%reverse(+L, ?R)
reverse([],[]).
reverse([X|XS], R) :- reverse(XS, L), append(L, [X], R).

%prefijo(?P, +L)
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L)
sufijo(S, L) :- append(_, S, L).

%sublista(?S, +L)
sublista(S, L) :- prefijo(X,L), sufijo(S,X).

%pertenece(?X, +L)
pertenece(X, [X|_]).
pertenece(X, [_|L]) :- pertenece(X, L).