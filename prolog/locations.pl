% KITCHEN
location(apple, kitchen, type(edible), weight(10), breakable(yes)).
location(crackers, kitchen, type(edible), weight(6), breakable(yes)).
location(broccoli, kitchen, type(tastes_yucky), weight(5), breakable(no)).
location(freezer, kitchen, type(object), weight(120), breakable(no)).
location(caguama, freezer, type(drinkable), weight(15), breakable(yes)).
location(jugo_naranja, freezer, type(drinkable), weight(10), breakable(yes)).
location(medium_table, kitchen, type(object), weight(24), breakable(yes)).
location(chair_1, kitchen, type(object), weight(18), breakable(yes)).
location(chair_2, kitchen, type(object), weight(18), breakable(yes)).
location(chair_3, kitchen, type(object), weight(18), breakable(yes)).
location(chair_4, kitchen, type(object), weight(18), breakable(yes)).
location(note, chair_3, type(object), weight(2), breakable(no)).
location(stove, kitchen, type(object), weight(110), breakable(no)).
location(microwave, kitchen, type(object), weight(50), breakable(yes)).
location(drawers, kitchen, type(object), weight(20), breakable(no)).
location(drawe_1, drawers, type(object), weight(20), breakable(no)).
location(drawe_2, drawers, type(object), weight(20), breakable(no)).
location(drawe_3, drawers, type(object), weight(20), breakable(no)).
location(drawe_4, drawers, type(object), weight(20), breakable(no)).
location(bread, drawe_1, type(edible), weight(12), breakable(yes)).
location(pans, drawe_2, type(object), weight(8), breakable(no)).
location(spices, drawe_3, type(object), weight(5), breakable(no)).
location(canned_corn, drawe_4, type(object), weight(14), breakable(yes)).
location(canned_tunna, drawe_4, type(object), weight(14), breakable(yes)).

% LIVINGROOM
location(small_sofa, livingroom, type(object), weight(50), breakable(yes)).
location(medium_sofa, livingroom, type(object), weight(90), breakable(yes)).
location(big_sofa, livingroom, type(object), weight(70), breakable(yes)).

% GARAGE
location(box_small, garage, type(object), weight(16), breakable(no)).
location(box_medium, garage, type(object), weight(24), breakable(no)).
location(box_big, garage, type(object), weight(35), breakable(no)).
location(clothes, box_medium, type(object), weight(18), breakable(no)).

% LAUNDRY
location(washing_machine, laundry, type(object), weight(80), breakable(no)).
% CELLAR
location(flashlight, cellar, type(object), weight(18), breakable(no)).

% DINNINGROOM
location(flowervase, dinningroom, type(object), weight(30), breakable(yes)).
location(big_table, dinningroom, type(object), weight(35), breakable(yes)).
location(chocomilk, big_table, type(drinkable), weight(10), breakable(yes)).
location(chair_1, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_2, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_3, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_4, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_5, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_6, dinningroom, type(object), weight(22), breakable(yes)).

% HALL
location(mirror, hall, type(object), weight(39), breakable(yes)).
location(small_table, hall, type(object), weight(45), breakable(yes)).
location(key_1, small_table, type(key), weight(3), breakable(yes)).

% OFFICE
location(desk, office, type(object), weight(80), breakable(yes)).
location(computer, office, type(object), weight(50), breakable(yes)).
location(laptop, office, type(object), weight(25), breakable(yes)).
location(weed, desk, type(usable), weight(3), breakable(no)).

% BATHROOMS
location(toilet, bathroom_1, type(usable), weight(100), breakable(yes)).
location(toilet, bathroom_2, type(usable), weight(100), breakable(yes)).
location(toilet, bathroom_3, type(usable), weight(100), breakable(yes)).
location(handwash, bathroom_1, type(usable), weight(80), breakable(yes)).
location(handwash, bathroom_2, type(usable), weight(80), breakable(yes)).
location(handwash, bathroom_3, type(usable), weight(80), breakable(yes)).

% BEDROOMS
location(bed_1, bedroom_1, type(usable), weight(90), breakable(no)).
location(bed_2, bedroom_2, type(usable), weight(90), breakable(no)).
location(pillow_1, bed_1, type(object), weight(10), breakable(no)).
location(pillow_2, bed_1, type(object), weight(10), breakable(no)).
location(pillow_3, bed_2, type(object), weight(10), breakable(no)).
location(pillow_4, bed_2, type(object), weight(10), breakable(no)).

location(box_1, cellar, type(object), weight(15), breakable(yes)).
location(box_2, cellar, type(object), weight(15), breakable(yes)).
location(box_3, cellar, type(object), weight(15), breakable(yes)).
location(box_4, cellar, type(object), weight(15), breakable(yes)).
location(box_5, cellar, type(object), weight(15), breakable(yes)).

location(nani, box_4, type(object), weight(10), breakable(no)).

edible(X,Y) :-
  location(X, Y, type(edible), _, _).
tastes_yucky(X,Y) :-
  location(X, Y, type(tastes_yucky), _, _).
drinkable(X,Y) :-
  location(X, Y, type(drinkable), _, _).

location(X,Y) :-
  location(X,Y,_,_,_).

weight(Object, W) :-
  location(Object, _, _, weight(W), _).

