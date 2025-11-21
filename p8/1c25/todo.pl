% aplanar(+XS, -YS).
aplanar([], []).
aplanar([X|XS], YS) :- aplanar(X, RS), aplanar(XS, ZS), append(RS, ZS, YS).
aplanar([X|XS], [X|YS]) :- X \= [], X \= [_,_], aplanar(XS, YS).

% interseccion(+L1, +L2, -L3) 
interseccion([], _ , []).
interseccion([X|XS], YS, [X|ZS]) :- not(not(member(X, YS))), sacar(X, XS, L), interseccion(L, YS, ZS).
interseccion([X|XS], YS, ZS) :- not(member(X, YS)), interseccion(XS, YS, ZS).

sacar(_, [], []).
sacar(X, [Y|YS], [Y|ZS]) :- X \= Y, sacar(X, YS, ZS).
sacar(X, [X|YS], ZS) :- sacar(X, YS, ZS).

% partir(N, L, L1, L2)
partir(0, XS, [], XS).
partir(N, [X|XS], [X|YS], ZS) :- M is N-1, partir(M, XS, YS, ZS).

% borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).
borrar([Y|YS], X, [Y|ZS]) :- X \= Y, borrar(YS, X, ZS).
borrar([X|YS], X, ZS) :- borrar(YS, X, ZS).

% sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([X|XS], [X|YS]) :- borrar(XS, X, ZS), sacarDuplicados(ZS, YS).

% insertar(?X, +L, ?LX)
insertar(X, XS, YS) :- append(ZS, RS, XS), append(ZS, [X|RS], YS).

% permutacion(+L1, ?L2)
permutacion([], []).
permutacion([X|XS], YS) :- permutacion(XS, ZS), insertar(X, ZS, YS).

% reparto(+L, +N, -LListas)
reparto([], 0, []).
reparto(L, N, [X | XS]) :- N2 is N-1, append(X, R, L), reparto(R, N2, XS).

% repartoSinVacías(+L, -LListas)
repartoSinVacias([], []).
repartoSinVacias(L, [X | XS]) :- X \= [], append(X, R, L), repartoSinVacias(R, XS).

% parteQueSuma(+L,+S,-P)
parteQueSuma(_, 0, []).
parteQueSuma([X|XS], S, [X|P]) :- S > 0, S2 is S-X, parteQueSuma(XS, S2, P).
parteQueSuma([_|XS], S, P) :- S > 0, parteQueSuma(XS, S, P).

desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

desdeReversible(X,X).
desdeReversible(X,Y):- nonvar(Y), X < Y, N is X+1, desdeReversible(N,Y).
desdeReversible(X,Y):- var(Y), N is X+1, desdeReversible(N,Y).

%intercalar(L1, L2, L3)
intercalar([], L2, L2).
intercalar(L1, [], L1).
intercalar([X|XS], [Y|YS], [X|[Y|ZS]]) :- intercalar(XS, YS, ZS).

vacio(nil).

raiz(bin(_,V,_), V).

altura(nil, 0).
altura(bin(A, _, B), X) :- altura(A, X2), altura(B,X3), X is 1 + max(X2, X3).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(A,V,B), X) :- cantidadDeNodos(A, X2), cantidadDeNodos(B, X3), X is 1 + X2 + X3.

% inorder(+AB,-Lista)
inorder(nil, []).
inorder(bin(Izq, R, Der), L) :- inorder(Izq, L1), inorder(Der, L2), append(L1, [R | L2], L).

%% Se puede probar con inorder(bin(bin(bin(nil,4,nil),2,bin(bin(nil,6,nil),5,bin(nil,7,nil))), 1, bin(nil,3,bin(bin(nil,9,nil),8,nil))),[4,2,6,5,7,1,3,9,8]).
%% Y con inorder(bin(bin(bin(nil,4,nil),2,bin(bin(nil,6,nil),5,bin(nil,7,nil))), 1, bin(nil,3,bin(bin(nil,9,nil),8,nil))), L).

% arbolConInorder(+Lista,-AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(Izq, R, Der)) :-  append(L1, [R | L2], L), arbolConInorder(L1, Izq), arbolConInorder(L2, Der).

% aBB(+T)
aBB(nil).
aBB(bin(Izq, R, Der)) :- aBB(Izq), aBB(Der), inorder(Izq, L1), inorder(Der, L2), max_list(L1, R), min_list(L2, R).

% aBBInsertar(+X, +T1, -T2)
aBBInsertar(X, nil, bin(nil, X, nil)).
aBBInsertar(X, bin(Izq, R, Der), bin(T, R, Der)) :- X < R, aBBInsertar(X, Izq, T).
aBBInsertar(X, bin(Izq, R, Der), bin(Izq, R, T)) :- R < X, aBBInsertar(X, Der, T).

% coprimos(-X,-Y)
coprimos(X,Y):- generarPares(X,Y), X > 0, Y > 0, gcd(X,Y) =:= 1.

%generarPares(-X, -Y)
generarPares(X,Y) :- desdeReversible(0, N), paresQueSuman(N, X, Y).

%paresQueSuman(+N, -X, -Y)
paresQueSuman(N, X, Y) :- between(0, N, X), Y is N-X.

%cuadradoSemiMágico(+N, -XS).
cuadradoSemiMagico(N, XS) :- desdeReversible(0, X), length(XS, N),
 todasLasListasSuman(X, N, XS).

% listasDeLQueSuman(+L,+S, +K, -P) %listas Que Suman S de largo K
listasDeLQueSuman(_, 0, 0, []).
listasDeLQueSuman([X|XS], S, K, [X|P]) :- S > 0, K > 0, S2 is S-X, K2 is K - 1, listasDeLQueSuman(XS, S2, K2, P).
listasDeLQueSuman([_|XS], S, K, P) :- S > 0, K > 0, listasDeLQueSuman(XS, S, K, P).

%listasQueSuman(+S, +K, -P). %genera listas de largo K que suman S
listasQueSuman(0, 0, []).
listasQueSuman(S, K, [X|P]) :- between(0, S, X),  K > 0, S2 is S-X, K2 is K - 1, listasQueSuman(S2, K2, P).

%todasLasListasSuman(+S, +K, +L).
todasLasListasSuman(_,_, []).
todasLasListasSuman(S, K, [X|XS]) :- listasQueSuman(S, K, X), todasLasListasSuman(S, K, XS).

iesimo([X|_], 0, X).
iesimo([_|XS], I, Y) :- iesimo(XS, I2, Y), I is I2 + 1.

sumaColumna([], _, 0).
sumaColumna([X|XS], I, Y) :- iesimo(X, I, Z), sumaColumna(XS, I, Y2), Y is Y2 + Z.

columnasQueSuman(M, S) :-  length(M, N), between(0, N, I), sumaColumna(M, I, S).

%cuadradoMagico(+N, -XS)
cuadradoMagico(N, XS) :- cuadradoSemiMagico(N, XS), iesimo(XS, 1, L), sum_list(L, S), columnasQueSuman(XS, S).

%esTriángulo(+T).
esTriangulo(tri(A,B,C)) :- A > 0, B > 0, C > 0, A < B + C, B < A + C, C < B + A.

%perímetro(?T,?P)
perimetro(T,P) :-  ground(T), esTriangulo(T), sumaTriangulo(T, P). %para +T y ?P
perimetro(T,P) :-  not(ground(T)), desdeReversible(3, P), triplasQueSuman(A, B, C, P), T = tri(A,B,C), esTriangulo(T).

sumaTriangulo(tri(A,B,C), P) :- P is A + B + C.
triplasQueSuman(A, B, C, P) :- between(1, P, A), between(1, P, B), C is P - A - B, C > 0.

%triángulo(-T)
triangulo(T) :- perimetro(T, _).

%  corteMásParejo(+L,-L1,-L2)
corteMásParejo(L, L1 , L2):- unCorte(L,L1,L2,D),
    not(hayCorteMejor(L,D)).

unCorte(L,L1,L2,D) :- append(L1,L2,L), sum_list(L1, N1), sum_list(L2,N2), D is abs(N1 - N2).

hayCorteMejor(L,D):- unCorte(L,_,_,D2), D2 < D.

