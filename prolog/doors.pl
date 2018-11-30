:- discontiguous (door/3).

door(hall, bathroom_1, open).
door(livingroom, hall, open).
door(hall, kitchen, open).
door(hall, garage, open).
door(garage, laudry, open).
door(hall, stairs, open).

doors(X,Y) :-
  door(Y,X,_).
doors(X,Y) :-
  door(X,Y,_).
doors(X,Y,Z) :-
  door(Y,X,Z).
doors(X,Y,Z) :-
  door(X,Y,Z).

door(hallway, stairs, open).
door(hallway, bathroom_2, open).
door(hallway, office, open).
door(hallway, cellar, closed).
door(hallway, bedroom_1, open).
door(hallway, bedroom_2, open).
door(bedroom_2, wardrobe, open).
door(wardrobe, bathroom_3, open).
door(hallway, terrace, open).

door_key(cellar, key_1).

