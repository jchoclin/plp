vacio(nil).

raiz(bin(_,V,_), V).

altura(nil, 0).
altura(bin(A, _, B), X) :- altura(A, X2), altura(B,X3), X is 1 + max(X2, X3).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(A,V,B), X) :- cantidadDeNodos(A, X2), cantidadDeNodos(B, X3), X is 1 + X2 + X3.