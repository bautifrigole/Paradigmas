es_padre(shmiSkywalker, anakinSkywalker).
es_padre(anakinSkywalker, lukeSkywalker).
es_padre(anakinSkywalker, leiaOrgana).
es_padre(padmeAmidala, lukeSkywalker).
es_padre(padmeAmidala, leiaOrgana).
es_padre(leiaOrgana, kyloRen).
es_padre(hanSolo, kyloRen).

% Padres adoptivos
es_padre(owenLars, lueSkywalker).
es_padre(beruLars, lukeSkywalker).
es_padre(bailOrgana, leiaOrgana).
es_padre(brehaOrgana, leiaOrgana).

es_hermano(X,Y):-es_padre(Z,X),es_padre(Z,Y),X\==Y.
es_primo(X,Y):- es_padre(Z, Y), es_padre(W, X), es_hermano(W, Z).
es_nieto(X,Y):- es_padre(Y,Z),es_padre(Z,X).

es_descendiente(X,Y):- es_padre(Y,X).
es_descendiente(X,Y):- es_padre(Y,Z), es_descendiente(X,Z).

hijos(X,L):- hijosR(X,[],L).

hijosR(X,L1,L2):- es_padre(X,Y), not(member(Y,L1)),append([Y],L1,L3),hijosR(X,L3,L2),!.
hijosR(_,L,L).

ancestros(X,L):- ancestrosR(X,[],L).

ancestrosR(X,L1,L2):- es_descendiente(X,Y), not(member(Y,L1)),append([Y],L1,L3),ancestrosR(X,L3,L2),!.
ancestrosR(_,L,L).


% Predicado para encontrar todos los antepasados de una persona en una lista plana.
todos_antepasados(Persona, Antepasados) :-
    findall(Antepasado, antepasados_aux(Persona, Antepasado), Antepasados).

% Caso base: una persona no tiene antepasados.
antepasados_aux(Persona, Persona) :- \+ es_padre(_, Persona).

% Caso recursivo: encuentra los antepasados de una persona.
antepasados_aux(Persona, Antepasado) :-
    es_padre(Padre, Persona),
    antepasados_aux(Padre, Antepasado).






% Predicado para encontrar el primer número par en una lista.
encontrar_primer_par([X|_], X) :-
    X mod 2 =:= 0,  % Verifica si X es par.
    !.  % Corte aquí, detiene la búsqueda después de encontrar el primer número par.

% Caso recursivo: cuando el primer elemento no es par, continúa buscando en el resto de la lista.
encontrar_primer_par([_|Resto], PrimerPar) :-
    encontrar_primer_par(Resto, PrimerPar).

% Caso base: si la lista está vacía, no se puede encontrar ningún número par.
encontrar_primer_par([], no_par).
