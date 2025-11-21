%intercalar(L1, L2, L3)
intercalar(L, [], L).
intercalar([], L, L).
intercalar([X|XS], [Y|YS], [X|[Y|L]]) :- intercalar(XS, YS, L).