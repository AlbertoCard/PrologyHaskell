%Para probar este programa se debe correr asignarFichas
%Este programa termina cuando:
%En los extremos hay una ficha con puntaje par
%en ambos lados de la pieza

%predicados y hechos nuevos

%se actualiza en el predicado colocarFicha
:- dynamic terminar/1.
terminar(0).

%validar si sumo puntaje 2 veces
%se usa en el predicado cambiarTurno
fichaPar:-
    terminar(X),
    X = 1,
    write("Ficha par en los extremos"),nl.

%validar si la ficha es par
%se usa en el predicado colocarFicha
laFichaEsPar([X,Y]):-
    (X mod 2 =:= 0; Y mod 2 =:= 0, X \= 0, Y \= 0)
    -> retract(terminar(_)), assertz(terminar(1)).


%Juego completo

%Variable para señalar el número en cada extremo
:- dynamic extremos/1.
%extremos(Arr, Ab, Iz, De).
extremos([0,0,0,0]).

%Variable para señalar en qué extremo hay mula
:- dynamic mula/1.
%mula(Arr, Ab, Iz, De).
mula([1,1,1,1]).

%Variables para la fila horizontal y vertical
:- dynamic fila_horizontal/1.
fila_horizontal([]).
:- dynamic fila_vertical/1.
fila_vertical([]).

%Variable para las 28 Fichas
:- dynamic fichas/1.
fichas([[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],
        [1,1],[1,2],[1,3],[1,4],[1,5],[1,6],
        [2,2],[2,3],[2,4],[2,5],[2,6],
        [3,3],[3,4],[3,5],[3,6],
        [4,4],[4,5],[4,6],
        [5,5],[5,6],
        [6,6]]).

%Variable para el puntaje de cada jugador
:- dynamic puntaje/1.
% puntaje(J1, J2).
puntaje([0,0]).

%Variables para las fichas de cada jugador
:- dynamic jugador/2.
jugador(jugador1,[]).
jugador(jugador2,[]).

%Variable para saber de qué jugador es el turno
:- dynamic turno/1.
%turno(J1).
turno(jugador1).

%Variable con la ficha multiplo de 5
:- dynamic multiplo5/1.
multiplo5([0,0]).

%asignar fichas manualmente
asignarFichas:-
    retract(jugador(jugador1,_)), assertz(jugador(jugador1, [[0,0],[0,1],[0,2],[0,3],[0,4]])),
    retract(jugador(jugador2,_)), assertz(jugador(jugador2, [[1,1],[1,2],[1,3],[1,4],[1,5]])),
    jugador(jugador1, FichasJ1),
    jugador(jugador2, FichasJ2),
    imprimirFichasJugador("jugador1", FichasJ1),
    imprimirFichasJugador("jugador2", FichasJ2),
    eliminarFichas.

%eliminar fichas asignadas manualmente
eliminarFichas:-
    fichas(Fichas),
    jugador(jugador1, FichasJ1),
    jugador(jugador2, FichasJ2),
    subtract(Fichas, FichasJ1, FichasNuevas),
    subtract(FichasNuevas, FichasJ2, FichasNuevas2),
    retract(fichas(_)), assertz(fichas(FichasNuevas2)),
    revolver,
    contiene_Mula55(FichasJ1, 2).



%Iniciar juego
iniciar:- 
    write("Iniciando el juego"), nl,
    revolver,
    repartir,
    write("turno de jugador1"), nl,
    jugador(jugador1, FichasJ1),
    contiene_Mula55(FichasJ1, 2).



%Revolver las fichas
revolver:- 
    write("Revolviendo las fichas"), nl,
    fichas(Fichas),
    random_permutation(Fichas, FichasRevueltas),
    retract(fichas(_)), assertz(fichas(FichasRevueltas)).



%Repartir fichas (5 a cada jugador)
repartir:- 
    write("Repartiendo las fichas"), nl,
    fichas(Fichas),
    repartirFichas(Fichas, 5, FichasJ1, FichasJ2),
    imprimirFichasJugador("jugador1", FichasJ1), 
    imprimirFichasJugador("jugador2", FichasJ2), 
    retract(jugador(jugador1,_)), assertz(jugador(jugador1, FichasJ1)),
    retract(jugador(jugador2,_)), assertz(jugador(jugador2, FichasJ2)),
    write("¡Comenzemos!"), nl.


%Repartir fichas (Auxiliar)
repartirFichas(_, 0, [], []).
repartirFichas([H1, H2 | T], N, [H1 | FichasJ1], [H2 | FichasJ2]):-
    N > 0,
    N1 is N-1,
    retract(fichas(_)), assertz(fichas(T)),
    repartirFichas(T, N1, FichasJ1, FichasJ2).




%Imprimir las fichas de un jugador
imprimirFichasJugador(Jugador, Fichas):-
    write("Fichas de "), write(Jugador), write(": "), write(Fichas), nl.




%Validar si algún jugador tiene mula del 5
contiene_Mula55( _, 0):- 
    jugador(jugador1, FichasJ1),
    write("Ningún jugador tiene la mula del 5"), nl,
    retract(turno(_)), assertz(turno(jugador1)),
    contiene_Multipo5(FichasJ1, 2).

contiene_Mula55(Fichas, N):-
    turno(JugadorEnTurno),
    member([5,5], Fichas)
    -> write("El "), write(JugadorEnTurno), write(" tiene la mula del 5"), nl,
        colocarMula5,
        cambiarTurno(JugadorEnTurno),
    	!
    ; 
    	retract(turno(JugadorEnTurno)),
        assertz(turno(jugador2)),
    	write("El "), write(JugadorEnTurno), write(" NO tiene la mula del 5"), nl,
        jugador(jugador2, FichasJ2),
    	N1 is N-1,
        contiene_Mula55(FichasJ2, N1).



%Validar si algun jugador puede colocar alguna ficha con un 5
contiene_Multipo5(_, 0):- 
    write("Ningún jugador puede colocar una ficha múltiplo de 5"), nl, !,
    cambiarTurno(jugador1).

contiene_Multipo5(Fichas, N):-
    (
        %validar si alguna ficha es multiplo de 5 usando multiplo5
        tieneMultiplo5(Fichas)
    ) -> 
    	(   turno(JugadorEnTurno),
        write("El "), write(JugadorEnTurno), write(" tiene una ficha múltiplo de 5"), nl,
        colocarMultiplo5(Fichas)
        ),
    	!
    ;
    	turno(JugadorEnTurno),
    	write("El "), write(JugadorEnTurno), write(" NO tiene una ficha múltiplo de 5"), nl,
        retract(turno(JugadorEnTurno)),
        assertz(turno(jugador2)),
        jugador(jugador2, FichasJ2),
        N1 is N-1,
        contiene_Multipo5(FichasJ2, N1).



%Jugar (validar que pueda colocar alguna ficha y después colocarla)
% (si no puede colocar ninguna ficha, robar una ficha)
jugar:-
    turno(Jugador),
    write("Turno del jugador: "), write(Jugador), nl,
    tieneFichas(Jugador) -> 
        puedeColocarFicha(Jugador),
        cambiarTurno(Jugador)
    ;
        write("El jugador no tiene fichas"), nl,
        terminar_juego.



%Cambiar turno
cambiarTurno(jugador1):-
    extremos([Arr, Ab, Iz, De]),
    write("Extremos: "), write([Arr, Ab, Iz, De]), nl,
    puntaje([P1, P2]),
    write("Puntaje del jugador 1: "), write(P1), nl,
    write("Puntaje del jugador 2: "), write(P2), nl,
    fichaPar -> terminar_juego
    ;
        (retract(turno(_)),
        assertz(turno(jugador2)),
        write("Cambiando al turno del jugador 2"), nl,
        jugar).

cambiarTurno(jugador2):-
    extremos([Arr, Ab, Iz, De]),
    write("Extremos: "), write([Arr, Ab, Iz, De]), nl,
    puntaje([P1, P2]),
    write("Puntaje del jugador 1: "), write(P1), nl,
    write("Puntaje del jugador 2: "), write(P2), nl,
    fichaPar -> terminar_juego
    ;
        (retract(turno(_)),
        assertz(turno(jugador1)),
        write("Cambiando al turno del jugador 1"), nl,
        jugar).



%colocar la mula del 5 en el tablero
colocarMula5:-
    turno(Jugador),
    jugador(Jugador, Fichas),
    write("Colocando la mula del 5"), nl,
    retract(extremos([_, _, _, _])), assertz(extremos([5,5,5,5])),
    select([5,5], Fichas, FichasNuevas),
    retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
    retract(fila_horizontal(FilaH)), assertz(fila_horizontal([5,5|FilaH])),
    retract(fila_vertical(FilaV)), assertz(fila_vertical([5,5|FilaV])),
    sumarPuntaje(Jugador),
    write("La mula del 5 ha sido colocada"), nl.



%validar si puede colocar una ficha
puedeColocarFicha(Jugador) :-
    extremos([Arr, Ab, Iz, De]),
    jugador(Jugador, Fichas),
    (
        % Verificar si alguna ficha puede colocarse en alguno de los extremos
            member([Arr, _], Fichas) -> Lugar = "arriba"
        ;   member([Ab, _], Fichas) -> Lugar = "abajo"
        ;   member([Iz, _], Fichas) -> Lugar = "izquierda"
        ;   member([De, _], Fichas) -> Lugar = "derecha"
        ;   member([_, Arr], Fichas) ->  Lugar = "arriba"
        ;   member([_, Ab], Fichas) -> Lugar = "abajo"
        ;   member([_, Iz], Fichas) -> Lugar = "izquierda"
        ;   member([_, De], Fichas) -> Lugar = "derecha"
    )
    ->  %write("El jugador puede poner la ficha "), write(Lugar), nl,
        colocarFicha(Jugador, Lugar)
    ;   write("El jugador no tiene fichas que pueda poner"), nl,
        hayFichasReserva -> 
            (  robarFicha(Jugador))
        ;
            write("No hay fichas para robar"), nl,
            terminar_juego.



%Colocar una ficha en el tablero
colocarFicha(Jugador, Lugar) :-
    extremos([Arr, Ab, Iz, De]),
    mula([MulaArr, MulaAb, MulaIz, MulaDe]),
    jugador(Jugador, Fichas),
    (
        Lugar == "arriba",
        (
            member([Arr, Extremo], Fichas) -> Ficha = [Arr, Extremo]
            ;   
            member([Extremo, Arr], Fichas) -> Ficha = [Extremo, Arr]
        )
    ;   Lugar == "abajo",
        (
            member([Ab, Extremo], Fichas) -> Ficha = [Ab, Extremo]
            ;   
            member([Extremo, Ab], Fichas) -> Ficha = [Extremo, Ab]
        )
    ;   Lugar == "izquierda",
        (
            member([Iz, Extremo], Fichas) -> Ficha = [Iz, Extremo]
            ;   
            member([Extremo, Iz], Fichas) -> Ficha = [Extremo, Iz]
        )
    ;   Lugar == "derecha",
        (
            member([De, Extremo], Fichas) -> Ficha = [De, Extremo]
            ;   
            member([Extremo, De], Fichas) -> Ficha = [Extremo, De]
        )
    ),
    select(Ficha, Fichas, FichasNuevas),
    retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
    (
    Lugar == "arriba" -> 
        (retract(extremos([_, Ab, Iz, De])), assertz(extremos([Extremo, Ab, Iz, De])),
            (Extremo = Arr -> retract(mula(_)), assertz(mula([2, MulaAb, MulaIz, MulaDe])) ; retract(mula(_)), assertz(mula([1, MulaAb, MulaIz, MulaDe])) ),
        retract(fila_vertical(FilaV)), append([Ficha], FilaV, NuevaFilaV), assertz(fila_vertical(NuevaFilaV)))
    ;   Lugar == "abajo" -> 
        (retract(extremos([Arr, _, Iz, De])), assertz(extremos([Arr, Extremo, Iz, De])),
            (Extremo = Ab -> retract(mula(_)), assertz(mula([MulaArr, 2, MulaIz, MulaDe])) ; retract(mula(_)), assertz(mula([MulaArr, 1, MulaIz, MulaDe])) ),
        retract(fila_vertical(FilaV)), append(FilaV, [Ficha], NuevaFilaV), assertz(fila_vertical(NuevaFilaV)))
    ;   Lugar == "izquierda" -> 
        (retract(extremos([Arr, Ab, _, De])), assertz(extremos([Arr, Ab, Extremo, De])),
            (Extremo = Iz -> retract(mula(_)), assertz(mula([MulaArr, MulaAb, 2, MulaDe])) ; retract(mula(_)), assertz(mula([MulaArr, MulaAb, 1, MulaDe])) ),
        retract(fila_horizontal(FilaH)), append([Ficha], FilaH, NuevaFilaH), assertz(fila_horizontal(NuevaFilaH)))
    ;   Lugar == "derecha" -> 
        (retract(extremos([Arr, Ab, Iz, _])), assertz(extremos([Arr, Ab, Iz, Extremo])),
             (Extremo = De -> retract(mula(_)), assertz(mula([MulaArr, MulaAb, MulaIz, 2])) ; retract(mula(_)), assertz(mula([MulaArr, MulaAb, MulaIz, 1])) ),
        retract(fila_horizontal(FilaH)), append(FilaH, [Ficha], NuevaFilaH), assertz(fila_horizontal(NuevaFilaH)))
	),
    sumarPuntaje(Jugador),
    write("La ficha "), write(Ficha), write(" ha sido colocada en la fila "), write(Lugar), nl,
    laFichaEsPar(Ficha).






%Validar si el jugador tiene fichas en la mano
tieneFichas(Jugador):-
    jugador(Jugador, Fichas),
    length(Fichas, N),
    N > 0.



%Validar que haya fichas de reserva
hayFichasReserva:-
    fichas(Fichas),
    length(Fichas, N),
    N > 0.



%Robar una ficha
robarFicha(Jugador):-
    jugador(Jugador, Fichas),
    fichas(FichasReserva),
    FichasReserva = [Ficha | FichasReservaNuevas],
    append(Fichas, [Ficha], FichasNuevas),
    retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
    retract(fichas(_)), assertz(fichas(FichasReservaNuevas)),
    write("El jugador roba la ficha: "), write(Ficha), nl,
    puedeColocarFicha(Jugador).




%sumar puntaje
sumarPuntaje(jugador1):-
    puntaje([PuntajeJ1, PuntajeJ2]),
    extremos([Arr, Ab, Iz, De]),
    mula([MulaArr, MulaAb, MulaIz, MulaDe]),
    Modulo is (Arr * MulaArr) + (Ab * MulaAb) + (Iz * MulaIz) + (De * MulaDe),
    PuntajeJ1N is PuntajeJ1 + (Modulo - mod(Modulo, 5)),
    retract(puntaje(_)), assertz(puntaje([PuntajeJ1N, PuntajeJ2])).

sumarPuntaje(jugador2):-
    puntaje([PuntajeJ1, PuntajeJ2]),
    extremos([Arr, Ab, Iz, De]),
    mula([MulaArr, MulaAb, MulaIz, MulaDe]),
    Modulo is (Arr * MulaArr) + (Ab * MulaAb) + (Iz * MulaIz) + (De * MulaDe),
    PuntajeJ2N is PuntajeJ2 + (Modulo - mod(Modulo, 5)),
    retract(puntaje(_)), assertz(puntaje([PuntajeJ1, PuntajeJ2N])).


%validar que tenga una ficha cuya suma de sus lados sea multipo de 5
validarMultiplo5([X,Y]):-
    0 is (X+Y) mod 5 
    -> retract(multiplo5(_)), assertz(multiplo5([X,Y]))
    ; false.

tieneMultiplo5([Ficha | Resto]):-
    validarMultiplo5(Ficha)
    -> true
    ; tieneMultiplo5(Resto).

tieneMultiplo5([]):- false.



%Colocar ficha multiplo de 5
colocarMultiplo5([Ficha | Resto]):-
    validarMultiplo5(Ficha)
    -> colocarFichaMultiplo5(Ficha)
    ; colocarMultiplo5(Resto).


colocarFichaMultiplo5([X,Y]):-
    turno(Jugador),
    jugador(Jugador, Fichas),
    select([X,Y], Fichas, FichasNuevas),
    retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
    retract(multiplo5(_)), assertz(multiplo5([X,Y])),
    retract(extremos([_, _, _, _])),
    assertz(extremos([X,Y,X,Y])),
    retract(fila_horizontal(_)), assertz(fila_horizontal([X,Y])),
    retract(fila_vertical(_)), assertz(fila_vertical([X,Y])),
    write("La ficha "), write([X,Y]), write(" ha sido colocada en el tablero"), nl,
    sumar_puntajeMult5(Jugador, [X,Y]),
    cambiarTurno(Jugador).


sumar_puntajeMult5(jugador1, [X,Y]):-
    puntaje([P1, P2]),
    NP is P1 + (X + Y),
    retract(puntaje(_)), assertz(puntaje([NP, P2])).

sumar_puntajeMult5(jugador2, [X,Y]):-
    puntaje([P1, P2]),
    NP is P2 + (X + Y),
    retract(puntaje(_)), assertz(puntaje([P1, NP])).


%El juego termina
terminar_juego:-
    write("El juego ha terminado"), nl,
    imprimir_filas.

%mostrar ambas filas
imprimir_filas:-
    fila_horizontal(FilaH),
    fila_vertical(FilaV),
    write("Fila horizontal: "), write(FilaH), nl,
    write("Fila vertical: "), write(FilaV), nl,
    sumar_fichas_perdedor.

    

%sumar las fichas del perdedor al puntaje del ganador
%se suman los puntos de cada lado de la ficha y se redondea al multiplo de 5 mas cercano
%se suma el puntaje al jugador que tiene el turno
sumar_fichas_perdedor:-
    jugador(jugador1, FichasJ1),
    jugador(jugador2, FichasJ2),
    sumar_final(FichasJ1),
    sumar_final(FichasJ2),
    imprimir_puntaje.


sumar_final([[X,Y] | Resto]):-
    sumar_p1([X,Y]),
    sumar_final(Resto).

sumar_final([]).

sumar_p1([X,Y]):-
    puntaje([P1, P2]),
    Np is X+Y,
    NP is P1 + (Np - mod(Np, 5)),
    retract(puntaje(_)), assertz(puntaje([NP, P2])).

sumar_p1([]).

sumar_p2([X,Y]):-
    puntaje([P1, P2]),
    Np is X+Y,
    NP is P2 + (Np - mod(Np, 5)),
    retract(puntaje(_)), assertz(puntaje([P1, NP])).



%Imprimir puntaje de cada jugador
imprimir_puntaje:-
    puntaje([P1, P2]),
    jugador(jugador1, Fichas),
    jugador(jugador2, Fichas2),
    imprimirFichasJugador(jugador1, Fichas),
    imprimirFichasJugador(jugador2, Fichas2),
    write("Puntaje del jugador 1: "), write(P1), nl,
    write("Puntaje del jugador 2: "), write(P2), nl,
    ganador.

%Determinar ganador
ganador:-
    puntaje([P1, P2]),
    (   P1 > P2
    ->  write("El jugador 1 ha ganado"), nl
    ;   P2 > P1
    ->  write("El jugador 2 ha ganado"), nl
    ;   write("Empate"), nl
    ).
