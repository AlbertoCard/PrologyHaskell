%Variable para señalar el número en cada extremo
:- dynamic extremos/1.
%extremos(Arr, Ab, Iz, De).
extremos([0,0,0,0]).

%Variable para señalar en qué extremo hay mula
:- dynamic mula/1.
%mula(Arr, Ab, Iz, De).
mula([0,0,0,0]).

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
    repartirFichas(T, N1, FichasJ1, FichasJ2).




%Imprimir las fichas de un jugador
imprimirFichasJugador(Jugador, Fichas):-
    write("Fichas de "), write(Jugador), write(": "), write(Fichas), nl.




%Validar si algún jugador tiene mula del 5
contiene_Mula55( _, 0):- 
    jugador(jugador1, FichasJ1),
    write("Ningún jugador tiene la mula del 5"), nl,
    retract(turno(_)), assertz(turno(jugador2)),
    contiene_Multipo5(FichasJ1, 2).

contiene_Mula55(Fichas, N):-
    turno(JugadorEnTurno),
    member([5,5], Fichas)
    -> write("El "), write(JugadorEnTurno), write(" tiene la mula del 5"), nl,
        colocarMula5,
        jugar,
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
    write("Ningún jugador puede colocar una ficha múltiplo de 5"), nl, !.
    %terminar_juego().

contiene_Multipo5(Fichas, N):-
    (
        member([5,_], Fichas)
        ;   
        member([_,5], Fichas)
    ) -> 
    	(   turno(JugadorEnTurno),
        write("El "), write(JugadorEnTurno), write(" tiene una ficha múltiplo de 5"), nl,
        jugar
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
        puedeColocarFicha(Jugador)
    ;
        write("El jugador no tiene fichas"), nl,
        terminar_juego.



%Cambiar turno
cambiarTurno(jugador1):-
    retract(turno(_)),
    assertz(turno(jugador2)),
    write("Cambiando al turno del jugador 2"), nl,
    jugar.

cambiarTurno(jugador2):-
    retract(turno(_)),
    assertz(turno(jugador1)),
    write("Cambiando al turno del jugador 1"), nl,
    jugar.



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
    write("La mula del 5 ha sido colocada"), nl.



%validar si puede colocar una ficha
puedeColocarFicha(Jugador) :-
    extremos([Arr, Ab, Iz, De]),
    jugador(Jugador, Fichas),
    (
        member([Arr, Extremo], Fichas), Ficha = [Arr, Extremo], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([_, Ab, Iz, De])), assertz(extremos([Extremo, Ab, Iz, De])),
        retract(fila_vertical(FilaV)), assertz(fila_vertical([Ficha|FilaV]))
        ;   
        member([Ab, Extremo], Fichas), Ficha = [Ab, Extremo], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, _, Iz, De])), assertz(extremos([Arr, Extremo, Iz, De])),
        retract(fila_vertical(FilaV)), assertz(fila_vertical([Ficha|FilaV]))
        ;   
        member([Iz, Extremo], Fichas), Ficha = [Iz, Extremo], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, Ab, _, De])), assertz(extremos([Arr, Ab, Extremo, De])),
        retract(fila_horizontal(FilaH)), assertz(fila_horizontal([Ficha|FilaH]))
        ;   
        member([De, Extremo], Fichas), Ficha = [De, Extremo], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, Ab, Iz, _])), assertz(extremos([Arr, Ab, Iz, Extremo]))
        ;   
        member([Extremo, Arr], Fichas), Ficha = [Extremo, Arr], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([_, Ab, Iz, De])), assertz(extremos([Extremo, Ab, Iz, De])),
        retract(fila_vertical(FilaV)), assertz(fila_vertical([Ficha|FilaV]))
        ;   
        member([Extremo, Ab], Fichas), Ficha = [Extremo, Ab], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, _, Iz, De])), assertz(extremos([Arr, Extremo, Iz, De])),
        retract(fila_vertical(FilaV)), assertz(fila_vertical([Ficha|FilaV]))
        ;   
        member([Extremo, Iz], Fichas), Ficha = [Extremo, Iz], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, Ab, _, De])), assertz(extremos([Arr, Ab, Extremo, De])),
        retract(fila_horizontal(FilaH)), assertz(fila_horizontal([Ficha|FilaH]))
        ;   
        member([Extremo, De], Fichas), Ficha = [Extremo, De], select(Ficha, Fichas, FichasNuevas),
        retract(jugador(Jugador,_)), assertz(jugador(Jugador, FichasNuevas)),
        retract(extremos([Arr, Ab, Iz, _])), assertz(extremos([Arr, Ab, Iz, Extremo])),
        retract(fila_horizontal(FilaH)), assertz(fila_horizontal([Ficha|FilaH]))
    ) -> 
        write("El jugador coloca la ficha :"), write(Ficha), nl,
        sumarPuntaje(Jugador),
        cambiarTurno(Jugador)
    ;
        write("El jugador no puede poner una ficha"), nl,
        hayFichasReserva -> 
            (   write("El jugador roba una ficha"), nl,
            robarFicha(Jugador),
            puedeColocarFicha(Jugador))
        ;
            write("No hay fichas para robar"), nl,
            terminar_juego.



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
    write("El jugador roba la ficha: "), write(Ficha), nl.




%sumar puntaje
sumarPuntaje(jugador1):-
    puntaje([PuntajeJ1, PuntajeJ2]),
    extremos([Arr, Ab, Iz, De]),
    PuntajeJ1N is PuntajeJ1 + Arr + Ab + Iz + De,
    retract(puntaje(_)), assertz(puntaje([PuntajeJ1N, PuntajeJ2])).

sumarPuntaje(jugador2):-
    puntaje([PuntajeJ1, PuntajeJ2]),
    extremos([Arr, Ab, Iz, De]),
    PuntajeJ2N is PuntajeJ2 + Arr + Ab + Iz + De,
    retract(puntaje(_)), assertz(puntaje([PuntajeJ1, PuntajeJ2N])).























%El juego termina
terminar_juego:-
    write("El juego ha terminado"), nl,
    imprimir_puntaje.

%Imprimir puntaje de cada jugador
imprimir_puntaje:-
    puntaje([P1, P2]),
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
