mayor_cero(X,Y,Z):- X>0, Y>0, Z>0.
suma_dos_lados(X,Y,Z):- X+Y >= Z, X+Z >= Y, Y+Z >= X.

triangulo(X,Y,Z):- mayor_cero(X,Y,Z), suma_dos_lados(X,Y,Z).

tipo_triangulo(X,X,X,T):- triangulo(X,X,X), T = "equilatero", !.
tipo_triangulo(X,X,Z,T):- triangulo(X,X,Z), X \== Z, T = "isosceles", !.
tipo_triangulo(X,Y,X,T):- triangulo(X,Y,X), X \== Y, T = "isosceles", !.
tipo_triangulo(X,Y,Y,T):- triangulo(X,Y,Y), Y \== X, T = "isosceles", !.
tipo_triangulo(X,Y,Z,T):- triangulo(X,Y,Z), T = "escaleno", !.

divFromTo([H|T], I , F, T, L):- I<F, I1 is I+1, divFromTo(T,I1,F,T,L).
divFromTo([H|T], I , F, T, [H|L]):- I>=F, I<T, ! , I1 is I+1, divFromTo(T,I1,F,T,L).
divFromTo(_,_,_,_,[]).

%Otro caso con puntos 

conectada(a, b).
conectada(a, c).
conectada(b, d).
conectada(c, e).
conectada(d, f).
conectada(e, f).
conectada(e, b).
conectada(f, g).
conectada(g, a).

% Predicado para encontrar una ruta desde Origen hasta Destino
encontrar_ruta(Origen, Destino, Camino) :-
    encontrar_ruta_aux(Origen, Destino, [Origen], Camino),
    write('Ruta encontrada: '), write(Camino), nl.

% Caso base: llegamos al destino
encontrar_ruta_aux(Destino, Destino, Camino, Camino).

% Caso recursivo: encontramos una conexión intermedia y continuamos la búsqueda.
encontrar_ruta_aux(Origen, Destino, Camino, CaminoFinal) :-
    conectada(Origen, Intermedia),
    \+ member(Intermedia, Camino),  % Evita ciclos.
    append(Camino, [Intermedia], CaminoExtendido), % Añade la conexión intermedia al camino.
    encontrar_ruta_aux(Intermedia, Destino, CaminoExtendido , CaminoFinal), !. % Usamos corte porque solo queremos la primera solucion.