%coprimos(-X,-Y)
coprimos(X,Y) :- generarPares(X,Y), X > 0, Y > 0, gcd(X,Y) =:= 1.
generarPares(X,Y) :- desde(1, N), paresQueSuman(X,Y, N).

desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

paresQueSuman(X,Y,N) :- between(0, N, X), Y is N - X.