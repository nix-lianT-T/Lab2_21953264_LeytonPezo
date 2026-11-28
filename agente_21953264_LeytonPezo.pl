:- module('agente_21953264_LeytonPezo',
    [
    agente/7,
    is_agente/1,
    get_id_agente/2,
    get_nombre_agente/2,
    get_rol_agente/2,
    get_herramientas_agente/2,
    get_tokens_iniciales_agente/2,
    get_tokens_agente/2,
    get_ventana_agente/2,
    get_estado_agente/2,
    get_memoria_agente/2,
    get_supervisor_agente/2,
    get_subordinados_agente/2,
    set_tokens_agente/3,
    set_estado_agente/3,
    set_memoria_agente/3,
    set_supervisor_agente/3,
    set_subordinados_agente/3
    ]).
:- use_module('Codigo-Base_21953264_LeytonPezo').
:- use_module('herramienta_21953264_LeytonPezo').

/*TDA Agente*/
/*
El agente es una lista de elementos:
Id(int > 0) -> identificador del agente
Nombre(string) -> nombre del agente
Rol(atomo de roles) -> rol del agente
Herramientas(lista de herramienta) -> herramientas que tiene
TokensIniciales(int >= 0) -> tokens base
TokensActuales(int >= 0) -> tokens que le quedan
Ventana(int > 0) -> cantidad maxima de tareas en la memoria
Estado(atomo) -> disponible, ocupado o agotado
Memoria(lista de int) -> ids de tareas completadas, de la mas reciente a la mas antigua
Supervisor(int o []) -> id del supervisor
Subordinados(lista de int) -> ids subordinados
*/

/* Constructor Agente */

%Cabecera: agente(Id, Nombre, Rol, Herramientas, Tokens, Ventana, Agente)/7
%Descripcion: base para crear un TDA agente
%Dom: Id (int) X Nombre (string) X Rol (atomo de roles) X Herramientas (lista de herramienta) X Tokens (int) X Ventana (int)
%Rec: Agente
%Estrategia: no aplica
% nace disponible, o agotado si Tokens es 0. Sin supervisor, sin subordinados y con la memoria vacia
agente(Id, Nombre, Rol, Herramientas, Tokens, Ventana,
       [Id, Nombre, Rol, Herramientas, Tokens, Tokens, Ventana, Estado, [], [], []]) :-
    ( Tokens =:= 0 -> Estado = agotado ; Estado = disponible ).

/* Pertenencia */

%Cabecera: is_agente(Termino)/1
%Descripcion: verifica que un termino tiene la forma de un agente
%Dom: Termino (termino)
%Rec: booleano
%Estrategia: no aplica
is_agente([Id, Nombre, Rol, Herramientas, TokensIni, Tokens, Ventana, Estado, Memoria, Supervisor, Subordinados]) :-
    integer(Id), Id > 0,
    string(Nombre),
    rol(Rol),
    is_list(Herramientas),
    forall(member(H, Herramientas), is_herramienta(H)), % forall = "para todo"
    integer(TokensIni), TokensIni >= 0,
    integer(Tokens), Tokens >= 0,
    integer(Ventana), Ventana > 0,
    estadosAgente(Estados),
    member(Estado, Estados),
    is_list(Memoria),
    ( Supervisor == [] ; integer(Supervisor) ), % ";" significa "o"
    is_list(Subordinados).

/* Selectores */

%Cabecera: get_id_agente(Agente, Id)/2
%Descripcion: obtiene el id de un agente
%Dom: Agente (agente)
%Rec: Id (int)
%Estrategia: no aplica
get_id_agente([Id, _, _, _, _, _, _, _, _, _, _], Id).

%Cabecera: get_nombre_agente(Agente, Nombre)/2
%Descripcion: obtiene el nombre de un agente
%Dom: Agente (agente)
%Rec: Nombre (string)
%Estrategia: no aplica
get_nombre_agente([_, Nombre, _, _, _, _, _, _, _, _, _], Nombre).

%Cabecera: get_rol_agente(Agente, Rol)/2
%Descripcion: obtiene el rol de un agente
%Dom: Agente (agente)
%Rec: Rol (atomo de roles)
%Estrategia: no aplica
get_rol_agente([_, _, Rol, _, _, _, _, _, _, _, _], Rol).

%Cabecera: get_herramientas_agente(Agente, Herramientas)/2
%Descripcion: obtiene las herramientas de un agente
%Dom: Agente (agente)
%Rec: Herramientas (lista de herramienta)
%Estrategia: no aplica
get_herramientas_agente([_, _, _, Herramientas, _, _, _, _, _, _, _], Herramientas).

%Cabecera: get_tokens_iniciales_agente(Agente, TokensIni)/2
%Descripcion: obtiene los tokens con los que nacio un agente
%Dom: Agente (agente)
%Rec: TokensIni (int)
%Estrategia: no aplica
get_tokens_iniciales_agente([_, _, _, _, TokensIni, _, _, _, _, _, _], TokensIni).

%Cabecera: get_tokens_agente(Agente, Tokens)/2
%Descripcion: obtiene los tokens actuales de un agente
%Dom: Agente (agente)
%Rec: Tokens (int)
%Estrategia: no aplica
get_tokens_agente([_, _, _, _, _, Tokens, _, _, _, _, _], Tokens).

%Cabecera: get_ventana_agente(Agente, Ventana)/2
%Descripcion: obtiene la ventana de un agente
%Dom: Agente (agente)
%Rec: Ventana (int)
%Estrategia: no aplica
get_ventana_agente([_, _, _, _, _, _, Ventana, _, _, _, _], Ventana).

%Cabecera: get_estado_agente(Agente, Estado)/2
%Descripcion: obtiene el estado de un agente
%Dom: Agente (agente)
%Rec: Estado (atomo)
%Estrategia: no aplica
get_estado_agente([_, _, _, _, _, _, _, Estado, _, _, _], Estado).

%Cabecera: get_memoria_agente(Agente, Memoria)/2
%Descripcion: obtiene la memoria de un agente
%Dom: Agente (agente)
%Rec: Memoria (lista de int)
%Estrategia: no aplica
get_memoria_agente([_, _, _, _, _, _, _, _, Memoria, _, _], Memoria).

%Cabecera: get_supervisor_agente(Agente, Supervisor)/2
%Descripcion: obtiene el id del supervisor de un agente
%Dom: Agente (agente)
%Rec: Supervisor (int o [])
%Estrategia: no aplica
get_supervisor_agente([_, _, _, _, _, _, _, _, _, Supervisor, _], Supervisor).

%Cabecera: get_subordinados_agente(Agente, Subordinados)/2
%Descripcion: obtiene los ids de los subordinados de un agente
%Dom: Agente (agente)
%Rec: Subordinados (lista de int)
%Estrategia: no aplica
get_subordinados_agente([_, _, _, _, _, _, _, _, _, _, Subordinados], Subordinados).

/* Modificadores */

%Cabecera: set_tokens_agente(Agente, NuevosTokens, AgenteNuevo)/3
%Descripcion: entrega una copia del agente con otros tokens actuales
%Dom: Agente (agente) X NuevosTokens (int)
%Rec: AgenteNuevo (agente)
%Estrategia: no aplica
set_tokens_agente([Id, N, R, H, TI, _, V, E, M, S, Sub], NuevosTokens,
                  [Id, N, R, H, TI, NuevosTokens, V, E, M, S, Sub]).

%Cabecera: set_estado_agente(Agente, NuevoEstado, AgenteNuevo)/3
%Descripcion: entrega una copia del agente con otro estado
%Dom: Agente (agente) X NuevoEstado (atomo)
%Rec: AgenteNuevo (agente)
%Estrategia: no aplica
set_estado_agente([Id, N, R, H, TI, T, V, _, M, S, Sub], NuevoEstado,
                  [Id, N, R, H, TI, T, V, NuevoEstado, M, S, Sub]).

%Cabecera: set_memoria_agente(Agente, NuevaMemoria, AgenteNuevo)/3
%Descripcion: entrega una copia del agente con otra memoria
%Dom: Agente (agente) X NuevaMemoria (lista de int)
%Rec: AgenteNuevo (agente)
%Estrategia: no aplica
set_memoria_agente([Id, N, R, H, TI, T, V, E, _, S, Sub], NuevaMemoria,
                   [Id, N, R, H, TI, T, V, E, NuevaMemoria, S, Sub]).

%Cabecera: set_supervisor_agente(Agente, NuevoSupervisor, AgenteNuevo)/3
%Descripcion: entrega una copia del agente con otro supervisor
%Dom: Agente (agente) X NuevoSupervisor (int)
%Rec: AgenteNuevo (agente)
%Estrategia: no aplica
set_supervisor_agente([Id, N, R, H, TI, T, V, E, M, _, Sub], NuevoSupervisor,
                      [Id, N, R, H, TI, T, V, E, M, NuevoSupervisor, Sub]).

%Cabecera: set_subordinados_agente(Agente, NuevosSubordinados, AgenteNuevo)/3
%Descripcion: entrega una copia del agente con otra lista de subordinados
%Dom: Agente (agente) X NuevosSubordinados (lista de int)
%Rec: AgenteNuevo (agente)
%Estrategia: no aplica
set_subordinados_agente([Id, N, R, H, TI, T, V, E, M, S, _], NuevosSubordinados,
                        [Id, N, R, H, TI, T, V, E, M, S, NuevosSubordinados]).