% aplanar(+Xs, -Ys)
aplanar([], []).
aplanar([X|XS], YS) :- aplanar(X, RS), aplanar(XS, ZS), append(RS, ZS, YS).
aplanar([X|XS], [X|YS]) :- not(aplanar(X,_)), aplanar(XS, YS).
