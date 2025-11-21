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

