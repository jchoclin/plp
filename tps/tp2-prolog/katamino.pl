:- use_module(piezas).



/*
 * EJ 1 y 12!! 
 * No es reversible en D, ya que si D no está instanciado, el predicado length que utilizamos con el primer 
 * argumento sin instanciar, va a instanciar P y D en todas las listas de elementos no instanciados P de 
 * longitud D, donde D se instancia en todos los posibles tamaños. Esto es una generación infinita de listas, 
 * por lo cual el programa se colgará cuando D sea más grande que el tamaño de L, ya que no podrá unificarse 
 * un prefijo P de longitud mayor a su lista L.   
 *
 * Es reversible en R, teniendo D, T y L instanciados, ya que append es reversible en todos sus argumentos, 
 * por lo cual tendrá éxito si R unifica como prefijo del sufijo de L, y a su vez length tiene éxito si 
 * el tamaño de R unifica con T.
 */
 
% sublista(+Descartar, +Tomar, +L, -R)
sublista(D, T, L, R) :- 
    length(P, D), 
    append(P, S, L), 
    append(R, _, S), 
    length(R, T).

/*
 * Ej 2
 * El predicado auxiliar tieneLargo, recibe desde el mapList un elemento "X" de T, el cual sabemos es una lista
 * y a esta lista X aplicamos length con la longitud deseada.
 */

tieneLargo(K, X) :- length(X, K).

%tablero(+K, -T)
tablero(K, T) :- length(T, 5), maplist(tieneLargo(K), T).

/*
 * Ej 3
 * Símil a tablero
 * tamaño nos quedó reversible, podríamos crear un tablero a partir de una cantidad de filas y columnas
 * tablero(K, T) :- tamaño(T, 5, K).
 */

%tamaño(+M, -F, -C).
tamaño(M, F, C) :- length(M, F), maplist(tieneLargo(C), M).

/*
 * Ej 4
 * Dado el tablero, obtenemos su tamaño y devolvemos todas las posiciones en el rango de su tamaño.
 * Nos quedó reversible en IJ, ya que between es reversible en su tercer argumento (I y J)
 */
%coordenadas(+T, -IJ)
coordenadas(T, (I, J)) :- tamaño(T, N, M), between(1, N, I), between(1, M, J).

/*
 * Ej 5 
 * Partes prueba poner o no poner un elemento en la lista combinatoria, aprovechando el backtracking inherente
 * de Prolog, usando un contador de piezas K.
 * kPiezas, a partir de las piezas posibles, generamos todas las combinaciones de K longitud de estas piezas.
 * Utilizamos la siguiente poda para asegurarnos que corte lo antes posible: 
 *                     - si agrego X, en la cola debo tener al menos k-1 elementos.
 *                     - si no agrego X, en la cola debo tener al menos k elementos.
 */

partes([], 0, []).
partes([X|XS], K, [X|P]) :- K > 0, K2 is K-1, length(XS, L), L >= K2, partes(XS, K2, P). 
partes([_|XS], K, P) :- length(XS, L), L >= K, partes(XS, K, P). 


%kPiezas(+K, -PS)
kPiezas(K,PS):- nombrePiezas(P), length(P,L), L >= K, partes(P,K,PS).

/*
 * Ej 6
 * Aprovechando sublista/4, tomamos la fila I del tablero, luego los ANCHO elementos desde J y después lo uni-
 * ficamos con la recursión sobre un subtablero de ALTO - 1 que arranca desde la fila I+1 en T.
 */

% seccionTablero(+T, +ALTO, +ANCHO, +IJ, ?ST)
seccionTablero(_,0,_,_,_).
seccionTablero(T,ALTO,ANCHO,(I,J),[SI|R]):- 
    I1 is I-1, 
    J1 is J-1, 
    I2 is I + 1, 
    ALTO2 is ALTO - 1, 
    sublista(I1,1,T,[TI]), 
    sublista(J1,ANCHO, TI, SI),
    seccionTablero(T,ALTO2,ANCHO,(I2,J),R).

/*
 * Ej 7
 * Se unifica una pieza P de cierta forma en el tablero T, desde la posicion IJ, instanciando las variables no 
 * instaciadas, haciendo primero backtracking en las coordenadas antes de determinar si la pieza P unifica
 * o no con T.
 */

% ubicarPieza(+Tablero, +Identificador)
ubicarPieza(T, Id):- 
    pieza(Id,P), 
    tamaño(P,ALTO,ANCHO), 
    coordenadas(T,IJ),
    seccionTablero(T,ALTO,ANCHO,IJ,P).

/*
 * Ej 8
 * Sobre la recursión hecha sobre el resto de las piezas (Xs) ubicamos la pieza Id.
 * Utilizamos la poda antes de ubicarla.
 */

% ubicarPiezas(+Tablero, +Poda, +Identificadores)
ubicarPiezas(_, _, []).
ubicarPiezas(T, Poda, [Id|XS]):-
    ubicarPiezas(T,Poda,XS),
    poda(Poda, T), 
    ubicarPieza(T,Id).

/*
 * Ej 9
 * Unificamos un tablero T de tamaño Col, con algúna de los conjuntos de kPiezas posibles para poder llenarlo
 */

% llenarTablero(+Poda, +Columnas,-Tablero)

llenarTablero(Poda, Col, T):- 
    tablero(Col,T), 
    kPiezas(Col,PS), 
    ubicarPiezas(T, Poda, PS).


cantSoluciones(Poda, Columnas, N):-
    findall(T, llenarTablero(Poda, Columnas, T), TS),
    length(TS, N).


/*
 * Ej 10.
 * ?- time(cantSoluciones(sinPoda,3, N)).
 * % 21,566,297 inferences, 1.267 CPU in 1.268 seconds (100% CPU, 17015339 Lips)
 * N = 28.
 * 
 * ?- time(cantSoluciones(sinPoda,4, N)).
 * % 351,464,425 inferences, 19.354 CPU in 19.372 seconds (100% CPU, 18159867 Lips)
 * N = 200.
 * 
 * ?- time(cantSoluciones(sinPoda,5, N)).
 * % 6,135,071,673 inferences, 339.525 CPU in 339.657 seconds (100% CPU, 18069596 Lips)
 * N = 856.
 */

/*
 * Ej 11
 * El predicado auxiliar esLibre tiene exito si una IJ de T no está instanciada, sabemos que secciónTablero nos
 * devuelve una matriz de 1x1 y lo aprovechamos. Como coordenadas nos quedó reversible en (I,J), esLibre también
 * es reversible en (I,J).
 * todosGruposLibresModulo5 encuentra todas las coordenadas libres, luego las agrupamos y ahí unificamos
 * respecto a que cada grupo de coordenadas libres tenga módulo 5, como lo pedido.
 */

%esLibre(+T, -Coord)
esLibre(T, (I,J)) :- coordenadas(T, (I,J)), nth1(I,T, Fila), nth1(J, Fila, ST), var(ST).
 
tieneLargoMod5(X) :- length(X, L), L mod 5 =:= 0.

todosGruposLibresModulo5(T) :- 
    findall(Coord, esLibre(T, Coord), Cs), 
    agrupar(Cs, G), 
    maplist(tieneLargoMod5, G).

%poda(+Poda, +Tablero)
poda(sinPoda, _).
poda(podaMod5, T) :- todosGruposLibresModulo5(T).

/*
 * Usando la poda podaMod5 obtuvimos los siguientes resultados:
 *
 * ?- time(cantSoluciones(podaMod5, 3, N)).
 * % 5,600,145 inferences, 0.382 CPU in 0.350 seconds (109% CPU, 14649611 Lips)
 * N = 28.
 * 
 * ?- time(cantSoluciones(podaMod5, 4, N)).
 * % 69,512,857 inferences, 4.789 CPU in 4.475 seconds (107% CPU, 14515115 Lips)
 * N = 200.
 * 
 * ?- time(cantSoluciones(podaMod5, 5, N)).
 * % 675,251,770 inferences, 51.164 CPU in 52.445 seconds (98% CPU, 13197759 Lips)
 * N = 856.
 * 
 * ?- time(cantSoluciones(podaMod5,6, N)).
 * % 5,303,422,852 inferences, 366.502 CPU in 366.604 seconds (100% CPU, 14470393 Lips)
 * N = 2164.
 *
 * ?- time(cantSoluciones(podaMod5,7, N)).
 * % 26,814,332,351 inferences, 1938.478 CPU in 1939.032 seconds (100% CPU, 13832673 Lips)
 * N = 5584.
 */
