% aplanar(+XS, -YS).
aplanar([], []).
aplanar([X|XS], YS) :- aplanar(X, RS), aplanar(XS, ZS), append(RS, ZS, YS).
aplanar([X|XS], [X|YS]) :- X \= [], X \= [_,_], aplanar(XS, YS).