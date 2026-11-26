
:- module('herramienta_21953264_LeytonPezo',
    [
    herramienta/5,
    is_herramienta/1,
    get_nombre_herramienta/2,
    get_rol_herramienta/2,
    get_costo_herramienta/2,
    get_predicado_herramienta/2
   
    ]).
:- use_module(Codigo-Base_21953264_LeytonPezo).

/*TDA Herramienta*/
/*
Nombre(string) -> nombre de la heramienta
Rol(atomo de roles) -> rol de la herramienta, describe la herramienta
Costo(int) -> costo de la herramienta > 0
Predicado (atomo aridad 2)-> predicado asociado la herramineta
*/

/* Constructor Herramienta */

%cabecera: herramienta(Nombre, Rol, Costo, Predicado, Herramienta)/5
%Descripcion: base para crear un TDA herramienta
%Dom: Nombre (string) X Rol (atomo de roles) X Costo (int) X Predicado (atomo aridad 2) 
%Rec: Herramienta
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
herramienta(Nombre, Rol, Costo, Predicado, [Nombre, Rol, Costo, Predicado]).

/* Pertenencia */

%Cabecera: is_herramienta(herramienta)/1
%Descripcion: verifica que la lista corresponde a una herramienta
%Dom: Lista
%Rec: booleano
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
is_herramienta([A, B, C, D]) :-
    string(A),
    rol(B),
    atom(B),
    integer(C),
    (C > 0),
    atom(D).

/* Selectores */

%Cabecera: get_nombre_herramienta(herramienta, nombre)/2
%Descripcion: obtiene el nombre de una herramienta
%Dom: herramienta 
%Rec: string
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
get_nombre_herramienta([Nombre, _, _, _], Nombre).

%Cabecera: get_rol_herramienta(herramienta, rol)/2
%Descripcion: obtiene el rol de una herramienta
%Dom: herramienta 
%Rec: rol
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
get_rol_herramienta([_, Rol, _, _], Rol).

%Cabecera: get_costo_herramienta(herramienta, costo)/2
%Descripcion: obtiene el costo de una herramienta
%Dom: herramienta 
%Rec: int
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
get_costo_herramienta([_, _, Costo, _], Costo).

%Cabecera: get_predicado_herramienta(herramienta, predicado)/2
%Descripcion: obtiene el predicado de una herramienta
%Dom: herramienta 
%Rec: atomo aridad 2
%Estrategia (backtracking,recurcion,fuerza bruta, no aplica): no aplica
get_predicado_herramienta([_, _, _, Predicado], Predicado).

