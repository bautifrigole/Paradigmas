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
    encontrar_ruta_aux(Origen, Destino, [Origen], Camino).

% Caso base: llegamos al destino
encontrar_ruta_aux(Destino, Destino, Camino, Camino).

% Caso recursivo: encontramos una conexión intermedia y continuamos la búsqueda.
encontrar_ruta_aux(Origen, Destino, Camino, CaminoFinal) :-
    conectada(Origen, Intermedia),
    \+ member(Intermedia, Camino),  % Evita ciclos.
    append(Camino, [Intermedia], CaminoExtendido), % Añade la conexión intermedia al camino.
    encontrar_ruta_aux(Intermedia, Destino, CaminoExtendido , CaminoFinal), !. % Usamos corte porque solo queremos la primera solucion.