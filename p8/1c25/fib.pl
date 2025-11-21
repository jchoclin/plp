fibonacci(N) :- desdeReversible(0, M), esFibonacci(M, N).

esFibonacci(0, 0).
esFibonacci(1, 1).
esFibonacci(N, M) :- N > 1, N2 is N - 1, N3 is N - 2, esFibonacci(N2, M2), esFibonacci(N3, M3), M is M2 + M3.

desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).