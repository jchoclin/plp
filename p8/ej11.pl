vacio(nil).

raiz(bin(_,R,_), R).

altura(nil, 0).
altura(bin(I,_,D), A) :- altura(I, A2), altura(D, A3), A is 1 + max(A2, A3).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I,_,D), N) :- cantidadDeNodos(I, N2), cantidadDeNodos(D, N3), N is 1 + N2 + N3.