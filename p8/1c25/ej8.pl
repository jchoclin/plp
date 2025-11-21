
% parteQueSuma(+L,+S,-P)
parteQueSuma(_, 0, []).
parteQueSuma([X|XS], S, [X|P]) :- S > 0, S2 is S-X, parteQueSuma(XS, S2, P).
parteQueSuma([_|XS], S, P) :- S > 0, parteQueSuma(XS, S, P).

