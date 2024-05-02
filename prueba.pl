%Variable para señalar el numero en cada extremo
:- dynamic extremos/1.
%extremos(Arr,Ab,Iz,De).
extremos([0,0,0,0]).
%Variable para señalar en que extremo hay mula
:- dynamic mula/1.
mula([0,0,0,0]).
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
puntaje([0,0]).

%Variables para las fichas de cada jugador
:- dynamic jugador1/1.
:- dynamic jugador2/1.
jugador1([]).
jugador2([]).

%Variables para la fila horizontal y vertical
:- dynamic fila_horizontal/1.
fila_horizontal([]).
:- dynamic fila_vertical/1.
fila_vertical([]).


%Revlver las fichas
revolver:- 
    writeln("Revolviendo las fichas"),
    fichas(Fichas),
    random_permutation(Fichas, FichasRevueltas),
    retract(fichas(_)), assert(fichas(FichasRevueltas)).


%Repartir fichas (5 a cada jugador)
repartir:- 
    writeln("Repartiendo las fichas"),
    fichas(Fichas),
    repartirFichas(Fichas, 5, FichasJ1, FichasJ2),
    retract(jugador1(_)), assert(jugador1(FichasJ1)),
    retract(jugador2(_)), assert(jugador2(FichasJ2)),
    writeln("¡Comenzemos!").

%Repartir fichas (Auxiliar)
repartirFichas(Fichas, 0, FichasJ1, FichasJ2).
repartirFichas([H1, H2 | T], N, [H1 | FichasJ1], [H2 | FichasJ2]):-
    N > 0,
    N1 is N-1,
    repartirFichas(T, N1, FichasJ1, FichasJ2).


%Validar si algun jugador tiene mula del 5
contiene_Mula55():- 
    member([5,5], jugador1),
    writeln("El jugador 1 tiene la mula del 5"),
    colocarFicha(jugador1);
    member([5,5], jugador2),
    writeln("El jugador 2 tiene la mula del 5"),
    colocarFicha(jugador2);
    writeln("Ningun jugador tiene la mula del 5"),
    contiene_Multipo5(jugador1, 2).

%Validar ficha multiplo de 5
contiene_Multipo5(_, 0):-
    writeln("No hay fichas jugables"),
    terminar_juego().
contiene_Multipo5(Jugador, N):-
    writeln("Validando fichas de los jugadores"),
    member([5,_], Jugador),
    writeln("El jugador ", N," tiene una ficha multiplo de 5"),
    colocarFicha();
    member([_,5], Jugador),
    writeln("El jugador ", N," tiene una ficha multiplo de 5"),
    colocarFicha(Jugador);
    N1 is N-1,
    writeln("El jugador no tiene fichas multiplo de 5"),
    contiene_Multipo5(jugador2, N1).

%validar si el jugador puede poner alguna ficha
puedeColocarFicha(Jugador):-
    extremos([Arr,Ab,Iz,De]),
    member([Arr, _], Jugador),
    writeln("El jugador puede poner la ficha ", [Arr, _]),
    colocarFicha([Arr, _]);
    member([Ab, _], Jugador),
    writeln("El jugador puede poner la ficha ", [Ab, _]),
    colocarFicha([Ab, _]);
    member([Iz, _], Jugador),
    writeln("El jugador puede poner la ficha ", [Iz, _]),
    colocarFicha([Iz, _]);
    member([De, _], Jugador),
    writeln("El jugador puede poner la ficha ", [De, _]),
    colocarFicha([De, _]);
    member([_, Arr], Jugador),
    writeln("El jugador puede poner la ficha ", [_, Arr]),
    colocarFicha([_, Arr]);
    member([_, Ab], Jugador),
    writeln("El jugador puede poner la ficha ", [_, Ab]),
    colocarFicha([_, Ab]);
    member([_, Iz], Jugador),
    writeln("El jugador puede poner la ficha ", [_, Iz]),
    colocarFicha([_, Iz]);
    member([_, De], Jugador),
    writeln("El jugador puede poner la ficha ", [_, De]),
    colocarFicha([_, De]);
    writeln("El jugador no tiene fichas que pueda poner"),
    tomarFicha(Jugador).


%Colocar ficha
colocarFicha(Jugador):-
    writeln("Colocando ficha"),
    extremos([Arr,Ab,Iz,De]),
    

    

%Sumar puntos de cada extremo (solo se suman si el resultado es multiplo de 5 se suma)
%si el resultado es 13 solo se sumarian 10 puntos
%(en caso de haber una mula se suma [1:1 vale 2, 3:3 vale 6])

%Validar si hay fichas en la reserva

%Tomar ficha de la reserva(hasta que pueda poner alguna)
tomarFicha(Jugador):-
    writeln("Tomando ficha de la reserva"),
    fichas(Fichas),
    tomarFichaReserva(fichas, Jugador).

tomarFichaReserva([H | T], Jugador):-
    retract(fichas(_)), assert(fichas(T)),
    puedeColocarFicha(Jugador).


%Si un jugador se queda sin fichas termina el juego

%Los dos jugadores no tienen fichas que puedan poner y no hay fichas en reserva se termina el juego


%El juego termina cuando:
terminar_juego():-
    writeln("El juego ha terminado"),
    imprimir_puntaje().


%Imprimir puntaje de cada jugador
imprimir_puntaje():-
    puntaje([P1, P2]),
    writeln("Puntaje del jugador 1: ", P1),
    writeln("Puntaje del jugador 2: ", P2),
    ganador().


%Determinar ganador
ganador():-
    puntaje([P1, P2]),
    P1 > P2,
    writeln("El jugador 1 ha ganado");
    P2 > P1,
    writeln("El jugador 2 ha ganado");
    writeln("Empate").


%Iniciar juego
iniciar:- 
    writeln("Iniciando juego"),
    revolver,
    repartir,
    contiene_Mula55().

%Siguiente turno
siguiente_turno(Jugador):-.

        

