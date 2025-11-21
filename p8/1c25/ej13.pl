desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

% coprimos(-X,-Y)
coprimos(X,Y):- generarPares(X,Y), X > 0, Y > 0, gcd(X,Y) =:= 1.


%generarPares(-X, -Y)
generarPares(X,Y) :- desdeReversible(0, N), paresQueSuman(N, X, Y).

%paresQueSuman(+N, -X, -Y)
paresQueSuman(N, X, Y) :- between(0, N, X), Y is N-X.