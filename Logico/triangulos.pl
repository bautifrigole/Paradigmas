% Problema: Dado tres números enteros positivos, determinar si forman un triángulo y en caso de ser así, determinar el tipo de triángulo que es.

% Solución 1
mayor_cero(X,Y,Z):- X>0, Y>0, Z>0.
suma_dos_lados(X,Y,Z):- X+Y >= Z, X+Z >= Y, Y+Z >= X.

triangulo(X,Y,Z):- mayor_cero(X,Y,Z), suma_dos_lados(X,Y,Z).

tipo_triangulo(X,X,X,T):- triangulo(X,X,X), T = "equilatero", !.
tipo_triangulo(X,X,Z,T):- triangulo(X,X,Z), X \== Z, T = "isosceles", !.
tipo_triangulo(X,Y,X,T):- triangulo(X,Y,X), X \== Y, T = "isosceles", !.
tipo_triangulo(X,Y,Y,T):- triangulo(X,Y,Y), Y \== X, T = "isosceles", !.
tipo_triangulo(X,Y,Z,T):- triangulo(X,Y,Z), T = "escaleno", !.

% Solución 2
mayor_cero(X,Y,Z):- X>0, Y>0, Z>0.
suma_dos_lados(X,Y,Z):- X+Y >= Z, X+Z >= Y, Y+Z >= X.

es_triangulo(X,Y,Z):- mayor_cero(X,Y,Z), suma_dos_lados(X,Y,Z).

tipo_triangulo(X,Y,Z,T):- X=Y, Y=Z, !, T = "equilatero".
tipo_triangulo(X,Y,_,T):- X=Y, !, T = "isosceles".
tipo_triangulo(_,Y,Z,T):- Y=Z, !, T = "isosceles".
tipo_triangulo(_,_,_,T):- T = "escaleno".

triangulo(X,Y,Z,T):- es_triangulo(X,Y,Z), tipo_triangulo(X,Y,Z,T).
