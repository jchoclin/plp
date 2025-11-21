desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

%generarCapicuas(-L).
generarCapicuas(L) :- desdeReversible(1,N), listaQueSuma(N, L), esCapicua(L).

esCapicua(L) :- reverse(L, L).

%listas que suman S.
listas(0, []).
listas(S, P) :- S > 0, between(1, S, X), S2 is S-X, listas(S2, L), append([X], L, P).

listaQueSuma(0, []).
listaQueSuma(N, [X | XS]) :- between(1, N, X), N2 is N-X, listaQueSuma(N2, XS).

%tokenizar(+D, +F, -T).

caminoDesde(P,[P]).
caminoDesde((I,J),[(I,J)|C]):-  I2 is I + 1, caminoDesde((I2, J), C).
caminoDesde((I,J),[(I,J)|C]):-  I2 is I - 1, caminoDesde((I2, J), C).
caminoDesde((I,J),[(I,J)|C]):-  J2 is J + 1, caminoDesde((I, J2), C).
caminoDesde((I,J),[(I,J)|C]):-  J2 is J - 1, caminoDesde((I, J2), C).




lados(P,P).
lados((I,J),(I2,J)):- I2 is I + 1.
lados((I,J),(I2,J)):- I2 is I - 1.
lados((I,J),(I,J2)):- J2 is J + 1.
lados((I,J),(I,J2)):- J2 is J - 1.



collatz(N, S) :- N > 1, mod(N,2) =:= 0, N2 is N/2, S = N, collatz(N2, _).
collatz(N, S) :- N > 1, mod(N,2) =\= 0, N2 is (3*N)+1, S = N, collatz(N2, _).

esCollatzSiguiente(N,S):- mod(N,2) =:= 0, S is N/2.
esCollatzSiguiente(N,S):- mod(N,2) =\= 0, S is (3*N)+1.

collatzBien(N, N).
collatzBien(N, S) :- N > 1, esCollatzSiguiente(N, S2),  collatzBien(S2, S).




