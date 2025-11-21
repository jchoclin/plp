%juntar(?Lista1,?Lista2,?Lista3)
%juntar(L1,L2,L3) :- append(L1,L2,L3).
juntar([], L2, L2).
juntar(L1, [], L1).
juntar([X|L1], L2, [X|L3]) :- juntar(L1, L2, L3).