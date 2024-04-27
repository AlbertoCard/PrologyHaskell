/*
Caso 1: Cepillarme los dientes
Hechos: Mis dientes están sucios
Caso base: Mis dientes están limpios
Caso recursivo: Me sigo cepillando los dientes hasta que mis dientes estén limpios
(mi caso base).

Caso 2: Quiero ir con mi papá a por un café
Hechos: No tengo dinero
Hechos: Mi papá tiene dinero
Caso base: Voy con mi papá para comprar uno
Caso base: Mi papá NO quiso ir conmigo por uno
Caso recursivo: Seguir insistiendo en mi solicitud hasta que alguno de los casos base
se cumpla.

Caso 3: Necesito programar un algoritmo
Hechos: Soy un estudiante y necesito entregar un trabajo
Caso base: Mi código está libre de fallas y listo para ser entregado
Caso base: Mi código aún tiene errores
Caso recursivo: Hacer una serie de pruebas a mi algoritmo hasta que alguno de los
casos base se cumpla.
*/
personajes(stanley, lentes).
personajes(soos, signo_de_interrogacion).
personajes(wendy, bolsa_de_hielo).
personajes(stanford, sombrero_de_fez).
personajes(dipper_pines, arbol_de_pino).
personajes(gideon, estrella_de_5_puntas).
personajes(los_diarios, mano).
personajes(pacifica_noroeste, llama).
personajes(mabel_pines, estrella_fugaz).
personajes(robbie, corazon_remendado).

siguiente(stanley, soos).
siguiente(soos, wendy).
siguiente(wendy, stanford).
siguiente(stanford, dipper_pines).
siguiente(dipper_pines, gideon).
siguiente(gideon, los_diarios).
siguiente(los_diarios, pacifica_noroeste).
siguiente(pacifica_noroeste, mabel_pines).
siguiente(mabel_pines, robbie).
siguiente(robbie, stanley).
             
enSeguidaDe(X, Y) :-
    personajes(X, _),
    personajes(Y, _),
    siguiente(X, Y).

enMedioDe(X, Y, Z) :-
    enSeguidaDe(X, Z),
    enSeguidaDe(Z, Y). 