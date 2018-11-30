:- include(rooms).
:- include(doors).
:- include(locations).
:- dynamic here/1.
:- dynamic location/5.
:- dynamic have/1.
:- dynamic room/2.
:- dynamic door/3.
:- dynamic strength/1.

% LUGAR ACTUAL DONDE UNO SE ENCUNTRA
here(hall).
% PESO MÁXIMO QUE PUEDE CARGAR
strength(39).

% OBJETOS INICIALES EN EL INVENTARIO
have( object(book, type(read), weight(20), breakable(no)) ).

% PARA CHECAR SI ES COMIDA Y BEBIDA
where_food(Object, Place) :-
  edible(Object, Place),write(Object),nl,fail.
where_food(Object, Place) :-
  tastes_yucky(Object, Place),write(Object),nl,fail.
where_drink(Object, Place) :-
  drinkable(Object, Place),write(Object),nl,fail.

% ABRIR ALGUNA PUERTA
open_door(X) :-
  here(Y),
  connect(X,Y),
  door(X, Y, closed),
  retract(door(X, Y, closed)),
  assert(door(X, Y, open)),
  writeMsgGreen('Open door');
  writeMsgRed("The door isn't closed"),fail.

% CERRAR ALGUNA PUERTA
close_door(X) :-
  here(Y),
  connect(X, Y),
  door(X, Y, open),
  retract(door(X, Y, open)),
  assert(door(X, Y, closed)),
  writeMsgGreen('Door closed');
  writeMsgRed("The door isn't opened"),fail.

% CHECAR SI ESTÁN CONECTADAS LAS PUERTAS
connect(X,Y) :- doors(X,Y).
connect(X,Y) :- doors(Y,X).

% LISTAR COSAS MEDIANTE UN LUGAR
list_things(Place) :-
  location(X, Place),
  room(Place, turned_on),
  tab(2),
  write('<a href="#" style="color: orange" onclick="view_object('),
  write("'"),
  write(X),
  write("'"),
  write(')">'),
  write(X),
  write('</a>'),
  nl,fail.
list_things(_).

% LISTAR COSAS DE UN OBJECTO
list_things_object(Object) :-
  location(X, Object),
  tab(2),
  write('<a href="#" style="color: orange" onclick="view_object_inside('),
  write("'"),
  write(X),
  write("','"),
  write(Object),
  write("'"),
  write(')">'),
  write(X),
  write('</a>'),
  nl,fail.
list_things_object(_).

% LISTAR LOS LUGARES QUE CONECTAN CON EL LUGAR DADO
list_connections(Place) :-
  connect(Place, X),
  tab(2),
  write('<a href="#" onclick="open_menu_door('),
  write("'"),
  write(X),
  write("'"),
  write(')">'),
  write(X),
  write('</a>'),
  nl,fail.
list_connections(_).

% LISTAR COSAS QUE SE TIENEN CARGANDO
list_have(X) :-
  have(object(X,_,_,_)),
  tab(2),
  write('<a href="#" style="color: chocolate" onclick="open_menu('),
  write("'"),
  write(X),
  write("'"),
  write(')">'),
  write(X),
  write('</a>'),
  nl,fail.
list_have(_).

% MUESTRA SI LA LUZ DE LA HABITACIÓN ESTÁ ENCENDIDA O APAGADA
status_light :-
  here(Place),
  room(Place, turned_on),
  write('<b style="color: #ffcc00" >*The light is on here*</b>'),nl;
  write('<b style="color: #000" >*The light is off here*</b>'),nl.

% ESTO SIRVE PARA MIRAR LA INFORMACIÓN DE LA HABITACIÓN ACTUAL
look :- 
  here(Place),
  write('<b>You are in the: </b>'),
  write(Place),nl,
  status_light,
  write('<b>You can see:</b>'),nl,
  list_things(Place),
  write('<b>You can go to: </b>'),nl,
  list_connections(Place).

% MUESTRA TODO LO QUE SE TIENE EN EL INVENTARIO
inventory :-
  list_have(_).

% IR AL LUGAR DADO
goto(Place) :-
  here(X),
  connect(X, Place),
  doors(X, Place, open),
  retract(here(X)),
  assert(here(Place)),
  writeMsgGreen('Ready'),nl,look;
  writeMsgRed('Door closed or Impossible to go'),nl,
  writeMsgRed('If it is closed, look for the key.'),fail.

% SI PUEDE LEVANTAR EL OBJETO DADO
can_up(Item) :-
  weight(Item, Y),
  strength(S),
  Y < S;
  weight(Item, Y),
  strength(S),
  Y >= S,
  writeMsgRed('Is very weight'),fail.

% TOMAR OBJETO EN EL LUGAR ACTUAL
take(Object) :-
  here(Place),
  location(Object, Place),
  can_up(Object),
  retract(location(Object, Place, X,Y,Z)),
  assert(have(object(Object, X,Y,Z))),
  writeMsgGreen('Taken: ', Object).

% Tomar a nani
take(Item, Object) :-
  Item = nani,
  here(Place),
  location(Object, Place),
  location(Item, Object),
  finished.

% TOMAR OBJETO DENTRO DE UN OBJETO
take(Item, Object) :-
  here(Place),
  location(Object, Place),
  location(Item, Object),
  can_up(Item),
  retract(location(Item, Object, X,Y,Z)),
  assert(have(object(Item,X,Y,Z))),
  writeMsgGreen('Taken: ', Item).

% COMER UN OBJETO QUE SE TENGA EN EL INVENTARIO
eat(Object) :-
  have(object(Object, type(edible),_,_)),
  retract( have(object(Object,type(edible),_,_))),
  writeMsgGreen('Eaten');
  have(object(Object, type(tastes_yucky),_,_)),
  retract( have(object(Object,type(tastes_yucky),_,_))),
  writeMsgGreen('Eaten').

% BEBER UN OBJETO QUE SE TENGA EN EL INVENTARIO
drink(Object) :-
  Object = caguama,
  have(object(Object, type(drinkable),_,_)),
  retract(have(object(Object, type(drinkable),_,_))),
  retract(strength(_)),
  assert(strength(200)),
  writeMsgGreen("You have taken the caguama of power. Now you can lift everything").

drink(Object) :-
  have(object(Object, type(drinkable),_,_)),
  retract(have(object(Object, type(drinkable),_,_))),
  writeMsgGreen('Drunk').

% PRENDER LA LUZ EN LA HABITACIÓN ACTUAL
turn_on :-
  here(X),
  room(X, turned_off),
  retract(room(X, turned_off)),
  assert(room(X, turned_on)),
  writeMsgGreen('Light on!');
  writeMsgRed('Light alredy on'),fail.

% APAGAR LA LUZ EN LA HABITACIÓN ACTUAL
turn_off :-
  here(X),
  room(X, turned_on),
  retract(room(X, turned_on)),
  assert(room(X, turned_off)),
  writeMsgGreen('Light off!');
  writeMsgRed('Light alredy off'),fail.

% PONER UN OBJETO EN OTRO OBJETO
put(Item, Object) :-
  have(object(Item, A,B,C)),
  here(Place),
  location(Object, Place, _,_,_),
  weight(Object, K),
  strength(S),
  K>S,
  retract(have(object(Item, A,B,C))),
  assert(location(Item, Object, A,B,C)),
  writeMsgGreen('Ready.').

% VER EL OBJETO DADO
view_object(Object) :-
  weight(Object, W),
  write('<a href="#" style="color: #ff6161" onclick="take('),
  write("'"),
  write(Object),
  write("'"),
  write(')">'),
  write('Take object</a>'),nl,
  write('<b>This object is: </b>'),write(Object),nl,
  write('<b>Weight of this is: </b>'),write(W),nl,
  write('<b>Contains inside: </b>'),nl,
  list_things_object(Object);
  writeMsgRed('Unknow object'),
  fail.

view_object_inside(Item, Object) :-
  weight(Item, W),
  write('<a href="#" style="color: #ff6161" onclick="take_inside('),
  write("'"),
  write(Item),
  write("', '"),
  write(Object),
  write("'"),
  write(')">'),
  write('Take object</a>'),nl,
  write('<b>This object is: </b>'),write(Item),nl,
  write('<b>Weight of this is: </b>'),write(W),nl;
  writeMsgRed('Unknow object'),
  fail.

% VERIFICA QUE SE TENGA LA LLAVE
action_door(Place, Action, Action2) :-
  here(X),
  have(object(Key, _,_,_)),
  door_key(Place, Key),
  doors(X, Place, Action),
  retract(door(X, Place, Action)),
  assert(door(X, Place, Action2)).

% USAR UNA LLAVE A UNA PUERTA DESTINO
use_key(Place) :-
  action_door(Place, closed, open),
  writeMsgGreen('The door has been opened');
  action_door(Place, open, closed),
  writeMsgGreen('The door has been closed');
  writeMsgRed('The door can not be opened/closed or the key of this door is missing'),fail.

% SOLTAR OBJETO
drop(Object) :-
  have(object(Object,_,_,breakable(yes))),
  retract(object(Object,_,_,breakable(yes))),
  writeMsgGreen("You have broken the object").
drop(Object) :-
  have(object(Object,A,B,C)),
  retract(have(object(Object,A,B,C))),
  here(Place),
  assert(location(Object,Place,A,B,C)),
  writeMsgGreen("You have thrown it but it has not been broken");
  writeMsgRed("Do you not have the Object"), fail.

% TERMINAR EL JUEGO
finished :-
  write('<h1>You have won!</h1>'),
  halt.

% GUARDA EL PROGRESO ACTUAL EN UN ARCHIVO
save :-
 tell('checkpoint.pl'), listing(), told.

% IMPRIME UNA ALERTA
writeMsgGreen(Msg) :-
  write('<b class="msgGreen">'),
  write(Msg),
  write('</b>').
writeMsgGreen(Msg1, Msg2) :-
  string_concat(Msg1, Msg2, Msg),
  writeMsgGreen(Msg).

writeMsgRed(Msg) :-
  write('<b class="msgRed">'),
  write(Msg),
  write('</b>').

% MUESTRA LOS COMANDOS QUE SE PUEDEN USAR
help :-
 write('Commands: look, inventory, goto(Place), take(Object), take(ItemToTake, Object), put(Item, Object), eat(Object), drink(Object), turn_on, turn_off, view_object(Object), use_key(Place), drop(Object)').



