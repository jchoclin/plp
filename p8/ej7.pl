%intersección(+L1, +L2, -L3)
interseccion([], _, []).
interseccion([X|XS], YS, [X|ZS]) :- not(not(member(X, YS))), sacar(X, XS, L), interseccion(L, YS, ZS).
interseccion([X|XS], YS, ZS) :- not(member(X,YS)), interseccion(XS,YS,ZS).

sacar(_, [], []).
sacar(X, [Y|YS], [Y|ZS]) :- X \= Y, sacar(X, YS, ZS).
sacar(X, [X|YS], ZS) :- sacar(X, YS, ZS).

%partir(+N, ?L, ?L1, ?L2) 
partir(0, XS, [], XS).
partir(N, [X|L], [X|L1], L2) :- N > 0, N2 is N-1, partir(N2, L, L1, L2).

%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).
borrar([Y|XS], X, [Y|YS]) :- X \= Y, borrar(XS, X, YS).
borrar([X|XS], X, YS) :- borrar(XS,X,YS).

%sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([X|XS], [X|YS]) :- borrar(XS, X, ZS), sacarDuplicados(ZS, YS).

% insertar(?X, +L, ?LX)
insertar(X, XS, YS) :- append(ZS, RS, XS), append(ZS, [X|RS], YS).

%permutación(+L1, ?L2)
permutacion([], []).
permutacion([X|L1], L2) :- permutacion(L1, L3), insertar(X, L3, L2).

%reparto(+L, +N, -LListas)
reparto([], 0, []).
reparto(L, N, [X|L2]) :- N>0, N2 is N-1, append(X, R, L), reparto(R, N2, L2).

%repartoSinVacías(+L, -LListas)
repartoSinVacias([], []).
repartoSinVacias(L, [X|L2]) :- append(X, R, L), X \= [], repartoSinVacias(R, L2).