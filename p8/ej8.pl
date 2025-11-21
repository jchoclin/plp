%parteQueSuma(+L,+S,-P)
parteQueSuma([], 0, []).
parteQueSuma([X|L], S, [X|P]) :- S1 is S - X, parteQueSuma(L, S1, P).
parteQueSuma([_|L], S, P) :- parteQueSuma(L, S, P).
