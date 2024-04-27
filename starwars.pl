% Hechos sobre Star Wars
% Personajes principales
personaje(luke_skywalker).
personaje(leia_organa).
personaje(han_solo).
personaje(darth_vader).
personaje(empereor_palpatine).
personaje(yoda).
personaje(obi_wan_kenobi).

% Relaciones
relacion(luke_skywalker, leia_organa, hermanos).
relacion(darth_vader, luke_skywalker, padre).
relacion(darth_vader, leia_organa, padre).
relacion(rey, luke_skywalker, aprendiz).
relacion(kylo_ren, leia_organa, hijo).


% Afiliaciones
afiliacion(luke_skywalker, rebelde).
afiliacion(leia_organa, rebelde).
afiliacion(han_solo, rebelde).
afiliacion(darth_vader, imperio).
afiliacion(empereor_palpatine, imperio).
afiliacion(yoda, jedi).
afiliacion(obi_wan_kenobi, jedi).




% Reglas
% Regla 1: Determinar si dos personajes son aliados
aliados(X, Y) :-
    afiliacion(X, Faccion),
    afiliacion(Y, Faccion),
    X \= Y.

% Regla 2: Determinar si un personaje es maestro de otro
maestro_de(Maestro, Aprendiz) :-
    relacion(Maestro, Aprendiz, aprendiz).

% Regla 3: Determinar si un personaje es enemigo de otro
enemigo(X, Y) :-
    afiliacion(X, FaccionX),
    afiliacion(Y, FaccionY),
    FaccionX \= FaccionY.