es_padre(shmiSkywalker, anakinSkywalker).
es_padre(anakinSkywalker, lukeSkywalker).
es_padre(anakinSkywalker, leiaOrgana).
es_padre(padmeAmidala, lukeSkywalker).
es_padre(padmeAmidala, leiaOrgana).
es_padre(leiaOrgana, kyloRen).
es_padre(hanSolo, kyloRen).

% Padres adoptivos
es_padre(owenLars, lukeSkywalker).
es_padre(beruLars, lukeSkywalker).
es_padre(bailOrgana, leiaOrgana).
es_padre(brehaOrgana, leiaOrgana).

es_hermano(X,Y):-es_padre(Z,X),es_padre(Z,Y),X\==Y.
es_primo(X,Y):- es_padre(Z, Y), es_padre(W, X), es_hermano(W, Z).
es_nieto(X,Y):- es_padre(Y,Z),es_padre(Z,X).

es_descendiente(X,Y):- es_padre(Y,X).
es_descendiente(X,Y):- es_padre(Y,Z), es_descendiente(X,Z).es_padre(anakinSkywalker, lukeSkywalker).
es_padre(anakinSkywalker, leiaOrgana).
es_padre(padmeAmidala, lukeSkywalker).
es_padre(padmeAmidala, leiaOrgana).
es_padre(leiaOrgana, kyloRen).
es_padre(hanSolo, kyloRen).

es_padre_adoptivo(owenLars, lukeSkywalker).
es_padre_adoptivo(beruLars, lukeSkywalker).
es_padre_adoptivo(bailOrgana, leiaOrgana).
es_padre_adoptivo(brehaOrgana, leiaOrgana).

es_hermano(X,Y):-es_padre(Z,X),es_padre(Z,Y),X\==Y.
es_primo(X,Y):- es_padre(Z, Y), es_padre(W, X), es_hermano(W, Z).
es_nieto(X,Y):- es_padre(Y,Z),es_padre(Z,X).

es_descendiente(X,Y):- es_padre(Y,X).
es_descendiente(X,Y):- es_padre_adoptivo(Y, X).
es_descendiente(X,Y):- es_padre(Y,Z), es_descendiente(X,Z).
es_descendiente(X,Y):- es_padre_adoptivo(Y,Z), es_descendiente(X,Z).
