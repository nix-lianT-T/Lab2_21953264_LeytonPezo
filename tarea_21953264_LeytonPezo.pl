:- module('tarea_21953264_LeytonPezo',
    [
    tarea/8,
    is_tarea/1,
    get_id_tarea/2,
    get_descripcion_tarea/2,
    get_rol_tarea/2,
    get_herramienta_tarea/2,
    get_datos_tarea/2,
    get_complejidad_tarea/2,
    get_prioridad_tarea/2,
    get_estado_tarea/2,
    get_agente_tarea/2,
    get_resultado_tarea/2,
    set_estado_tarea/3,
    set_agente_tarea/3,
    set_resultado_tarea/3
    ]).
:- use_module('Codigo-Base_21953264_LeytonPezo').

/*TDA Tarea*/

/*
La tarea es una lista
Id(int > 0) -> identificador de la tarea
Descripcion(string) -> descripcion de la tarea
Rol(atomo de roles) -> rol que necesita la tarea
Herramienta(string) -> nombre de la herramienta que necesita
Datos(termino) -> entrada de la herramienta, o resultado(IdTarea)
Complejidad(int > 0) -> tokens que suma al costo de ejecutarla
Prioridad(int 1 a 5) -> 1 urgente, 5 baja
Estado(atomo) -> pendiente, asignada, completada o fallida
Agente(int o []) -> id del agente asignado, [] si no tiene
Resultado(termino) -> resultado de la tarea, [] si no tiene
*/

/* Constructor Tarea */

%Cabecera: tarea(Id, Descripcion, Rol, Herramienta, Datos, Complejidad, Prioridad, Tarea)/8
%Descripcion: base para crear un TDA tarea, la tarea nace pendiente, sin agente y sin resultado
%Dom: Id (int) X Descripcion (string) X Rol (atomo de roles) X Herramienta (string) X Datos (termino) X Complejidad (int) X Prioridad (int)
%Rec: Tarea
%Estrategia: no aplica
tarea(Id, Descripcion, Rol, Herramienta, Datos, Complejidad, Prioridad,
      [Id, Descripcion, Rol, Herramienta, Datos, Complejidad, Prioridad, pendiente, [], []]).

/* Pertenencia */

%Cabecera: is_tarea(Termino)/1
%Descripcion: verifica que un termino tiene la forma de una tarea
%Dom: Termino (termino)
%Rec: booleano
%Estrategia: no aplica
is_tarea([Id, Descripcion, Rol, Herramienta, _, Complejidad, Prioridad, Estado, Agente, _]) :-
    integer(Id),
    Id > 0,
    string(Descripcion),
    rol(Rol),
    string(Herramienta),
    integer(Complejidad), 
    Complejidad > 0,
    integer(Prioridad), 
    between(1, 5, Prioridad),
    estadosTarea(Estados),
    member(Estado, Estados),
    ( Agente == [] ; integer(Agente) ).




/* Selectores */

%Cabecera: get_id_tarea(Tarea, Id)/2
%Descripcion: obtiene el id de una tarea
%Dom: Tarea (tarea)
%Rec: Id (int)
%Estrategia: no aplica
get_id_tarea([Id, _, _, _, _, _, _, _, _, _], Id).

%Cabecera: get_descripcion_tarea(Tarea, Descripcion)/2
%Descripcion: obtiene la descripcion de una tarea
%Dom: Tarea (tarea)
%Rec: Descripcion (string)
%Estrategia: no aplica
get_descripcion_tarea([_, Descripcion, _, _, _, _, _, _, _, _], Descripcion).

%Cabecera: get_rol_tarea(Tarea, Rol)/2
%Descripcion: obtiene el rol de una tarea
%Dom: Tarea (tarea)
%Rec: Rol (atomo de roles)
%Estrategia: no aplica
get_rol_tarea([_, _, Rol, _, _, _, _, _, _, _], Rol).

%Cabecera: get_herramienta_tarea(Tarea, Herramienta)/2
%Descripcion: obtiene el nombre de la herramienta que pide una tarea
%Dom: Tarea (tarea)
%Rec: Herramienta (string)
%Estrategia: no aplica
get_herramienta_tarea([_, _, _, Herramienta, _, _, _, _, _, _], Herramienta).

%Cabecera: get_datos_tarea(Tarea, Datos)/2
%Descripcion: obtiene los datos de entrada de una tarea
%Dom: Tarea (tarea)
%Rec: Datos (termino)
%Estrategia: no aplica
get_datos_tarea([_, _, _, _, Datos, _, _, _, _, _], Datos).

%Cabecera: get_complejidad_tarea(Tarea, Complejidad)/2
%Descripcion: obtiene la complejidad de una tarea
%Dom: Tarea (tarea)
%Rec: Complejidad (int)
%Estrategia: no aplica
get_complejidad_tarea([_, _, _, _, _, Complejidad, _, _, _, _], Complejidad).

%Cabecera: get_prioridad_tarea(Tarea, Prioridad)/2
%Descripcion: obtiene la prioridad de una tarea
%Dom: Tarea (tarea)
%Rec: Prioridad (int)
%Estrategia: no aplica
get_prioridad_tarea([_, _, _, _, _, _, Prioridad, _, _, _], Prioridad).

%Cabecera: get_estado_tarea(Tarea, Estado)/2
%Descripcion: obtiene el estado de una tarea
%Dom: Tarea (tarea)
%Rec: Estado (atomo)
%Estrategia: no aplica
get_estado_tarea([_, _, _, _, _, _, _, Estado, _, _], Estado).

%Cabecera: get_agente_tarea(Tarea, Agente)/2
%Descripcion: obtiene el id del agente asignado a una tarea
%Dom: Tarea (tarea)
%Rec: Agente (int o [])
%Estrategia: no aplica
get_agente_tarea([_, _, _, _, _, _, _, _, Agente, _], Agente).

%Cabecera: get_resultado_tarea(Tarea, Resultado)/2
%Descripcion: obtiene el resultado de una tarea
%Dom: Tarea (tarea)
%Rec: Resultado (termino)
%Estrategia: no aplica
get_resultado_tarea([_, _, _, _, _, _, _, _, _, Resultado], Resultado).

/* Modificadores */

%Cabecera: set_estado_tarea(Tarea, NuevoEstado, TareaNu  eva)/3
%Descripcion: entrega una copia de la tarea con otro estado
%Dom: Tarea (tarea) X NuevoEstado (atomo)
%Rec: TareaNueva (tarea)
%Estrategia: no aplica
set_estado_tarea([Id, D, R, H, Da, C, P, _, A, Res], NuevoEstado,
                    [Id, D, R, H, Da, C, P, NuevoEstado, A, Res]).

%Cabecera: set_agente_tarea(Tarea, NuevoAgente, TareaNueva)/3
%Descripcion: entrega una copia de la tarea con otro agente
%Dom: Tarea (tarea) X NuevoAgente (int o [])
%Rec: TareaNueva (tarea)
%Estrategia: no aplica
set_agente_tarea([Id, D, R, H, Da, C, P, E, _, Res], NuevoAgente,
                 [Id, D, R, H, Da, C, P, E, NuevoAgente, Res]).

%Cabecera: set_resultado_tarea(Tarea, NuevoResultado, TareaNueva)/3
%Descripcion: entrega una copia de la tarea con otro resultado
%Dom: Tarea (tarea) X NuevoResultado (termino)
%Rec: TareaNueva (tarea)
%Estrategia: no aplica
set_resultado_tarea([Id, D, R, H, Da, C, P, E, A, _], NuevoResultado,
                    [Id, D, R, H, Da, C, P, E, A, NuevoResultado]).