desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

desdeReversible(X,Y):- nonvar(Y), X =< Y.
desdeReversible(X,Y):- var(Y), desde(X,Y).