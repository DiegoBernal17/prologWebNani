
:- dynamic exception/3.
:- multifile exception/3.


drop(A) :-
	have(object(A, _, _, breakable(yes))),
	retract(object(A, _, _, breakable(yes))),
	writeMsgGreen("You have broken the object").
drop(A) :-
	(   have(object(A, B, C, D)),
	    retract(have(object(A, B, C, D))),
	    here(E),
	    assert(location(A, E, B, C, D)),
	    writeMsgGreen("You have thrown it but it has not been broken")
	;   writeMsgRed("Do you not have the Object"),
	    fail
	).

:- dynamic door/3.

door(hall, bathroom_1, open).
door(livingroom, hall, open).
door(hall, kitchen, open).
door(hall, garage, open).
door(garage, laudry, open).
door(hall, stairs, open).
door(hallway, stairs, open).
door(hallway, bathroom_2, open).
door(hallway, office, open).
door(hallway, cellar, closed).
door(hallway, bedroom_1, open).
door(hallway, bedroom_2, open).
door(bedroom_2, wardrobe, open).
door(wardrobe, bathroom_3, open).
door(hallway, terrace, open).

connect(A, B) :-
	doors(A, B).
connect(B, A) :-
	doors(A, B).

writeMsgGreen(A) :-
	write('<b class="msgGreen">'),
	write(A),
	write('</b>').

door_key(cellar, key_1).

where_food(A, B) :-
	edible(A, B),
	write(A),
	nl,
	fail.
where_food(A, B) :-
	tastes_yucky(A, B),
	write(A),
	nl,
	fail.

location(A, B) :-
	location(A, B, _, _, _).

:- dynamic strength/1.

strength(200).

:- dynamic file_search_path/2.
:- multifile file_search_path/2.

file_search_path(library, A) :-
	library_directory(A).
file_search_path(swi, A) :-
	system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    system:
    (   current_prolog_flag(arch, A),
	atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    system:
    (   (   current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    system:
    (   getenv('PATH', A),
	(   current_prolog_flag(windows, true)
	->  atomic_list_concat(B, ;, A)
	;   atomic_list_concat(B, :, A)
	),
	'$member'(C, B),
	'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    link_xpce:
    (   current_prolog_flag(arch, A),
	atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	user:link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    user:
    (   link_xpce:current_prolog_flag(arch, A),
	link_xpce:atom_concat('lib/', A, B)
    ).
file_search_path(library, A) :-
	user:library_directory(A).
file_search_path(swi, A) :-
	user:system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    user:
    (   system:current_prolog_flag(arch, A),
	system:atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    user:
    (   (   system:current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    user:
    (   system:getenv('PATH', A),
	(   system:current_prolog_flag(windows, true)
	->  system:atomic_list_concat(B, ;, A)
	;   system:atomic_list_concat(B, :, A)
	),
	system:'$member'(C, B),
	system:'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	user:'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	user:'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	user:'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	user:'$pack':pack_dir(_, foreign, A).

help :-
	write('Commands: look, inventory, goto(Place), take(Object), take(ItemToTake, Object), put(Item, Object), eat(Object), drink(Object), turn_on, turn_off, view_object(Object), use_key(Place), drop(Object)').

edible(A, B) :-
	location(A, B, type(edible), _, _).

list_have(A) :-
	have(object(A, _, _, _)),
	tab(2),
	write('<a href="#" style="color: chocolate" onclick="open_menu('),
	write("'"),
	write(A),
	write("'"),
	write(')">'),
	write(A),
	write('</a>'),
	nl,
	fail.
list_have(_).

:- dynamic room/2.

room(garage, turned_off).
room(dinningroom, turned_on).
room(hall, turned_on).
room(bathroom_1, turned_off).
room(livingroom, turned_on).
room(laundry, turned_off).
room(stairs, turned_on).
room(hallway, turned_on).
room(bathroom_2, turned_off).
room(terrace, turned_on).
room(bedroom_1, turned_off).
room(bedroom_2, turned_off).
room(bathroom_3, turned_off).
room(wardrobe, turned_off).
room(office, turned_off).
room(cellar, turned_off).
room(kitchen, turned_on).

look :-
	here(A),
	write('<b>You are in the: </b>'),
	write(A),
	nl,
	status_light,
	write('<b>You can see:</b>'),
	nl,
	list_things(A),
	write('<b>You can go to: </b>'),
	nl,
	list_connections(A).

:- dynamic have/1.

have(object(book, type(read), weight(20), breakable(no))).
have(object(freezer, type(object), weight(120), breakable(no))).
have(object(key_1, type(key), weight(3), breakable(yes))).

:- dynamic prolog_file_type/2.
:- multifile prolog_file_type/2.

prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).

list_things_object(A) :-
	location(B, A),
	tab(2),
	write('<a href="#" style="color: orange" onclick="view_object_inside('),
	write("'"),
	write(B),
	write("','"),
	write(A),
	write("'"),
	write(')">'),
	write(B),
	write('</a>'),
	nl,
	fail.
list_things_object(_).

:- dynamic resource/3.
:- multifile resource/3.


:- dynamic expand_query/4.
:- multifile expand_query/4.


doors(B, A) :-
	door(A, B, _).
doors(A, B) :-
	door(A, B, _).

eat(A) :-
	(   have(object(A, type(edible), _, _)),
	    retract(have(object(A, type(edible), _, _))),
	    writeMsgGreen('Eaten')
	;   have(object(A, type(tastes_yucky), _, _)),
	    retract(have(object(A, type(tastes_yucky), _, _))),
	    writeMsgGreen('Eaten')
	).

finished :-
	write('<h1>You have won!</h1>'),
	halt.

weight(A, B) :-
	location(A, _, _, weight(B), _).

list_connections(A) :-
	connect(A, B),
	tab(2),
	write('<a href="#" onclick="open_menu_door('),
	write("'"),
	write(B),
	write("'"),
	write(')">'),
	write(B),
	write('</a>'),
	nl,
	fail.
list_connections(_).

:- dynamic expand_answer/2.
:- multifile expand_answer/2.


list_things(A) :-
	location(B, A),
	room(A, turned_on),
	tab(2),
	write('<a href="#" style="color: orange" onclick="view_object('),
	write("'"),
	write(B),
	write("'"),
	write(')">'),
	write(B),
	write('</a>'),
	nl,
	fail.
list_things(_).

:- thread_local thread_message_hook/3.
:- dynamic thread_message_hook/3.
:- volatile thread_message_hook/3.


close_door(A) :-
	(   here(B),
	    connect(A, B),
	    door(A, B, open),
	    retract(door(A, B, open)),
	    assert(door(A, B, closed)),
	    writeMsgGreen('Door closed')
	;   writeMsgRed("The door isn't opened"),
	    fail
	).

status_light :-
	(   here(A),
	    room(A, turned_on),
	    write('<b style="color: #ffcc00" >*The light is on here*</b>'),
	    nl
	;   write('<b style="color: #000" >*The light is off here*</b>'),
	    nl
	).

:- dynamic here/1.

here(stairs).

drink(A) :-
	A=caguama,
	have(object(A, type(drinkable), _, _)),
	retract(have(object(A, type(drinkable), _, _))),
	retract(strength(_)),
	assert(strength(200)),
	writeMsgGreen("You have taken the caguama of power. Now you can lift everything").
drink(A) :-
	have(object(A, type(drinkable), _, _)),
	retract(have(object(A, type(drinkable), _, _))),
	writeMsgGreen('Drunk').

view_object_inside(A, B) :-
	(   weight(A, C),
	    write('<a href="#" style="color: #ff6161" onclick="take_inside('),
	    write("'"),
	    write(A),
	    write("', '"),
	    write(B),
	    write("'"),
	    write(')">'),
	    write('Take object</a>'),
	    nl,
	    write('<b>This object is: </b>'),
	    write(A),
	    nl,
	    write('<b>Weight of this is: </b>'),
	    write(C),
	    nl
	;   writeMsgRed('Unknow object'),
	    fail
	).

writeMsgGreen(A, B) :-
	string_concat(A, B, C),
	writeMsgGreen(C).

:- dynamic message_hook/3.
:- multifile message_hook/3.


doors(B, A, C) :-
	door(A, B, C).
doors(A, B, C) :-
	door(A, B, C).

:- dynamic portray/1.
:- multifile portray/1.


turn_off :-
	(   here(A),
	    room(A, turned_on),
	    retract(room(A, turned_on)),
	    assert(room(A, turned_off)),
	    writeMsgGreen('Light off!')
	;   writeMsgRed('Light alredy off'),
	    fail
	).

goto(B) :-
	(   here(A),
	    connect(A, B),
	    doors(A, B, open),
	    retract(here(A)),
	    assert(here(B)),
	    writeMsgGreen('Ready'),
	    nl,
	    look
	;   writeMsgRed('Door closed or Impossible to go'),
	    nl,
	    writeMsgRed('If it is closed, look for the key.'),
	    fail
	).

view_object(A) :-
	(   weight(A, B),
	    write('<a href="#" style="color: #ff6161" onclick="take('),
	    write("'"),
	    write(A),
	    write("'"),
	    write(')">'),
	    write('Take object</a>'),
	    nl,
	    write('<b>This object is: </b>'),
	    write(A),
	    nl,
	    write('<b>Weight of this is: </b>'),
	    write(B),
	    nl,
	    write('<b>Contains inside: </b>'),
	    nl,
	    list_things_object(A)
	;   writeMsgRed('Unknow object'),
	    fail
	).

turn_on :-
	(   here(A),
	    room(A, turned_off),
	    retract(room(A, turned_off)),
	    assert(room(A, turned_on)),
	    writeMsgGreen('Light on!')
	;   writeMsgRed('Light alredy on'),
	    fail
	).

:- multifile message_property/2.


drinkable(A, B) :-
	location(A, B, type(drinkable), _, _).

tastes_yucky(A, B) :-
	location(A, B, type(tastes_yucky), _, _).

take(A, B) :-
	A=nani,
	here(C),
	location(B, C),
	location(A, B),
	finished.
take(C, A) :-
	here(B),
	location(A, B),
	location(C, A),
	can_up(C),
	retract(location(C, A, D, E, F)),
	assert(have(object(C, D, E, F))),
	writeMsgGreen('Taken: ', C).

:- multifile prolog_list_goal/1.


:- dynamic location/5.

location(crackers, kitchen, type(edible), weight(6), breakable(yes)).
location(broccoli, kitchen, type(tastes_yucky), weight(5), breakable(no)).
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
location(small_sofa, livingroom, type(object), weight(50), breakable(yes)).
location(medium_sofa, livingroom, type(object), weight(90), breakable(yes)).
location(big_sofa, livingroom, type(object), weight(70), breakable(yes)).
location(box_small, garage, type(object), weight(16), breakable(no)).
location(box_medium, garage, type(object), weight(24), breakable(no)).
location(box_big, garage, type(object), weight(35), breakable(no)).
location(clothes, box_medium, type(object), weight(18), breakable(no)).
location(washing_machine, laundry, type(object), weight(80), breakable(no)).
location(flashlight, cellar, type(object), weight(18), breakable(no)).
location(flowervase, dinningroom, type(object), weight(30), breakable(yes)).
location(big_table, dinningroom, type(object), weight(35), breakable(yes)).
location(chocomilk, big_table, type(drinkable), weight(10), breakable(yes)).
location(chair_1, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_2, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_3, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_4, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_5, dinningroom, type(object), weight(22), breakable(yes)).
location(chair_6, dinningroom, type(object), weight(22), breakable(yes)).
location(mirror, hall, type(object), weight(39), breakable(yes)).
location(small_table, hall, type(object), weight(45), breakable(yes)).
location(desk, office, type(object), weight(80), breakable(yes)).
location(computer, office, type(object), weight(50), breakable(yes)).
location(laptop, office, type(object), weight(25), breakable(yes)).
location(weed, desk, type(usable), weight(3), breakable(no)).
location(toilet, bathroom_1, type(usable), weight(100), breakable(yes)).
location(toilet, bathroom_2, type(usable), weight(100), breakable(yes)).
location(toilet, bathroom_3, type(usable), weight(100), breakable(yes)).
location(handwash, bathroom_1, type(usable), weight(80), breakable(yes)).
location(handwash, bathroom_2, type(usable), weight(80), breakable(yes)).
location(handwash, bathroom_3, type(usable), weight(80), breakable(yes)).
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

:- dynamic prolog_event_hook/1.
:- multifile prolog_event_hook/1.


use_key(A) :-
	(   action_door(A, closed, open),
	    writeMsgGreen('The door has been opened')
	;   action_door(A, open, closed),
	    writeMsgGreen('The door has been closed')
	;   writeMsgRed('The door can not be opened/closed or the key of this door is missing'),
	    fail
	).

writeMsgRed(A) :-
	write('<b class="msgRed">'),
	write(A),
	write('</b>').

:- dynamic library_directory/1.
:- multifile library_directory/1.

library_directory(B) :-
    '$parms':
    (   cached_library_directory(local, A=lib, A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(user,
				 expand_file_name('~/lib/prolog', [A]),
				 A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(system,
				 absolute_file_name(swi(library), A),
				 A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(clp,
				 absolute_file_name(swi('library/clp'), A),
				 A),
	B=A
    ).
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(local, A=lib, A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(user, expand_file_name('~/lib/prolog', [A]), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(system, absolute_file_name(swi(library), A), A),
	B=A.
library_directory(B) :-
	'$parms':cached_library_directory(clp, absolute_file_name(swi('library/clp'), A), A),
	B=A.

where_drink(A, B) :-
	drinkable(A, B),
	write(A),
	nl,
	fail.

:- dynamic prolog_load_file/2.
:- multifile prolog_load_file/2.


take(A) :-
	here(B),
	location(A, B),
	can_up(A),
	retract(location(A, B, C, D, E)),
	assert(have(object(A, C, D, E))),
	writeMsgGreen('Taken: ', A).

inventory :-
	list_have(_).

open_door(A) :-
	(   here(B),
	    connect(A, B),
	    door(A, B, closed),
	    retract(door(A, B, closed)),
	    assert(door(A, B, open)),
	    writeMsgGreen('Open door')
	;   writeMsgRed("The door isn't closed"),
	    fail
	).

save :-
	tell('checkpoint.pl'),
	listing,
	told.

action_door(A, D, E) :-
	here(C),
	have(object(B, _, _, _)),
	door_key(A, B),
	doors(C, A, D),
	retract(door(C, A, D)),
	assert(door(C, A, E)).

can_up(A) :-
	(   weight(A, B),
	    strength(C),
	    B<C
	;   weight(A, B),
	    strength(C),
	    B>=C,
	    writeMsgRed('Is very weight'),
	    fail
	).
