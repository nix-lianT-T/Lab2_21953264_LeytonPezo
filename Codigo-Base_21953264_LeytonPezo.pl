:- module(Codigo-Base_21953264_LeytonPezo, 
    [
    roles/1,
    rol/1,
    estadosAgente/1,
    estadosTarea/1,
    umbralCalidad/1,
    complejidadMaxima/1,
    costoDelegacion/1,
    randomPuro/2,
    calidad/5
    ]
    ).


% Roles de agente. Solo el orquestador puede supervisar.
roles([orquestador, analista, comunicador, ejecutor, generico]).
rol(R) :- roles(Rs), member(R, Rs).
% Estados de un agente y de una tarea
estadosAgente([disponible, ocupado, agotado]).
estadosTarea([pendiente, asignada, completada, fallida]).
% Constantes de la plataforma
umbralCalidad(20).       % bajo este valor la respuesta es insatisfactoria
complejidadMaxima(20).   % sobre este valor una tarea se planifica en subtareas
costoDelegacion(2).      % tokens que gasta el agente que delega
% Generador pseudoaleatorio puro: relaciona cada Xn con un único Xn1
randomPuro(Xn, Xn1) :- Xn1 is (Xn * 1103515245 + 12345) mod 2147483648.
% Calidad de una respuesta: entero entre 0 y 99.
% Simula que un LLM a veces responde mal.
% Intento es 1 en la ejecución y 2 en la reflexión.
% Con esta fórmula, la reflexión también puede dejar la tarea fallida.
calidad(Seed, IdTarea, Ciclo, Intento, Q) :-
    X is Seed * (IdTarea + 2 * Ciclo + Intento) + IdTarea,
    randomPuro(X, R),
    Q is (R // 65536) mod 100.
