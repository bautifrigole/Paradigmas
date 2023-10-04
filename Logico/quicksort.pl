menores_iguales([],_,[]).
menores_iguales([H|T],X,[H|L]):- X >= H, !, menores_iguales(T,X,L).
menores_iguales([_|T],X,L):- menores_iguales(T,X,L).

mayores([],_,[]).
mayores([H|T],X,[H|L]):- H > X, !, mayores(T,X,L).
mayores([_|T],X,L):- mayores(T,X,L).

quicksort([],[]).
quicksort([H|T],L):- menores_iguales(T,H,L1), mayores(T,H,L2), quicksort(L1,Q1), 
quicksort(L2,Q2), append(Q1,[H|Q2],L).