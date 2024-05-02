% PENDIENTES: 

 

:- dynamic cerillos/1.

 

cerillos([0,5,3,1]).

 
empieza:- 
    write("Puedes quitar todos los cerillos que quieras de una linea"), nl,
    write("Pierde quien quite el último, Sólo tenemos 4 líneas"), nl,
    jugar(jugador).

 

jugar(jugador):- 
    imprimeCajetilla,
    write("De qué linea quieres quitar: "),        read(Linea),
    validaLinea(Linea, LineaN),
    write("Cuántos:"),        read(Cuantos),
    cerillos(Cerillos),
    quitaCerillos(LineaN, Cuantos, Cerillos, Nuevos),
    retract(cerillos(_)), assert(cerillos(Nuevos)),
    jugar(compu).

 

jugar(compu):- 
    piensa,
    write("La compu está jugando").

 

%quitaCerillos(Posición, Cuantos, ListaOrigen, NuevaLista):- 
quitaCerillos(1, Cuantos, [H|T], [Nuevo|T]):- 
    Aux is H - Cuantos,
    (   (Aux>0, Nuevo is Aux   );
        (Nuevo is 0   )).
quitaCerillos(Posicion, Cuantos, [H|T], [H|RAux] ):- 
    Siguiente is Posicion -1,
    quitaCerillos(Siguiente, Cuantos, T, RAux).

 

validaLinea(Linea, Linea):- Linea>0, Linea<5.
validaLinea(_, LineaN):- 
    write("Sólo tenemos 4 lineas. Elige 1-4: "),
    read(L), validaLinea(L, LineaN).
        
imprimeCajetilla:-
    nl, cerillos(Cerillos), write(Cerillos), nl.

 

%contar(ValorBuscado, Lista, Veces)
contar(_, [], 0).
contar(N, [N|T], Contador):-
    contar(N, T, ContadorParcial),
    Contador is ContadorParcial +1.
contar(N, [_|T], Contador):-
    contar(N, T, Contador).

 

diferentes(ListaAExcluir, [H|_], ValorDiferente):- 
    not(member(H,ListaAExcluir)), ValorDiferente is H.
diferentes(ListaAExcluir, [_|T], ValorDiferente):- 
    diferentes(ListaAExcluir, T, ValorDiferente).

 

%identificar el q no nos sirve y generar el q ocupamos
%genera0123(ListaTenemos, NumOcupamos)
genera0123(Referencia, Num):-
    cerillos(Cerillos),
    diferentes(Referencia, Cerillos, ValorACambiar),
    nth1(Posic, Cerillos, ValorACambiar),
    Quitar is ValorACambiar - Num,
    quitaCerillos(Posic, Quitar, Cerillos, NuevaLista),
    retract(cerillos(_)), assert(cerillos(NuevaLista)),
    cerillos(Cerillos2), write(Cerillos2).

 

piensa:- % Piensa:    0111
    cerillos(Cerillos),
    (   ( contar(1, Cerillos, 3), genera0123([1], 0));   % Falta 0
        (      contar(1, Cerillos, 2),   % Falta 1
            contar(0, Cerillos, 1), 
            genera0123([0,1], 1))).

 

piensa:-     %  Piensa: 0022
    cerillos(Cerillos),
    (   ( contar(2, Cerillos, 2),   
            contar(0, Cerillos, 1), 
            genera0123([0,2], 0)  ); % Falta 0
        (    contar(0, Cerillos, 2),  
            contar(2, Cerillos, 1), 
            genera0123([0,2], 2)   )). % Falta 2
 
% Piensa: 
piensa:- 
    cerillos(Cerillos),
    checa0123(Cerillos),
    write("No se puede hacer nada"), nl.             
variaciones( [[0, [1,2,3]], [1, [0,2,3]], [2, [0,1,3]],[3, [0,1,2]] ] ). 

 

checa0123([]).
checa0123([H|T]):-
    cerillos(Cerillos),
    contar(H, Cerillos, 1),
    checa0123(T).