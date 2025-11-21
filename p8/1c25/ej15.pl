desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

%esTriángulo(+T).
esTriangulo(tri(A,B,C)) :- A > 0, B > 0, C > 0, A < B + C, B < A + C, C < B + A.

%perímetro(?T,?P)
perimetro(T,P) :-  ground(T), esTriangulo(T), sumaTriangulo(T, P). %para +T y ?P
perimetro(T,P) :-  not(ground(T)), desdeReversible(3, P), triplasQueSuman(A, B, C, P), T = tri(A,B,C), esTriangulo(T).

sumaTriangulo(tri(A,B,C), P) :- P is A + B + C.
triplasQueSuman(A, B, C, P) :- between(1, P, A), between(1, P, B), C is P - A - B, C > 0.

%triángulo(-T)
triangulo(T) :- perimetro(T, _).





