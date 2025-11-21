%  corteMásParejo(+L,-L1,-L2)
corteMásParejo(L, L1 , L2):- unCorte(L,L1,L2,D),
    not(hayCorteMejor(L,D)).

    
unCorte(L,L1,L2,D) :- append(L1,L2,L), sum_list(L1, N1), sum_list(L2,N2), D is abs(N1 - N2).

hayCorteMejor(L,D):- unCorte(L,_,_,D2), D2 < D.