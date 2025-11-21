%intercalar(L1, L2, L3)
intercalar([], _, _).
intercalar(_, [], _).
intercalar([X|XS], [Y|YS], [X|[Y|ZS]]) :- intercalar(XS, YS, ZS).