%inorder(+AB,-Lista)
inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, L2), inorder(D, L3), append(L2, [R|L3], L).

%arbolConInorder(+Lista,-AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(I, R, D)) :- append(L2, [R|L3], L), arbolConInorder(L2, I), arbolConInorder(L3, D).

%aBB(+T)
aBB(bin(I, R, D)) :- aBB(I), aBB(D), inorder(I, L1), inorder(D, L2), max_list(L1, R), min_list(L2,R).

%aBBInsertar(+X, +T1, -T2)
aBBInsertar(R,nil, bin(nil,R,nil)).
aBBInsertar(X,bin(I,R,D), bin(I,R,D2)) :- X > R, aBBInsertar(X, D, D2).
aBBInsertar(X,bin(I,R,D), bin(I2,R,D)) :- X < R, aBBInsertar(X, I, I2).