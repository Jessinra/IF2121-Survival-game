
/*** ====================         DECLARATION OF DYNAMIC FACT     =========================== ***/

:- dynamic(game_running/1).	game_running(false).

:- dynamic(player_health/1).		player_health(0).
:- dynamic(player_hunger/1).		player_hunger(0). 
:- dynamic(player_thirst/1).		player_thirst(0). 
:- dynamic(player_pos/2).			player_pos(0, 0). 
:- dynamic(player_weapon/1).		player_weapon(bare_hand).
:- dynamic(player_inventory/1).  	player_inventory([]).
:- dynamic(map_width/1).		map_width(0). 
:- dynamic(map_length/1).		map_length(0). 
:- dynamic(map_items/1).		map_items(0).
:- dynamic(enemies/1).			enemies(0).
:- dynamic(special_terains/1).	special_terains(0).

/*** ====================         MAIN FUNCITON     =========================== ***/


init:-

	/* If game has not been run yet */	
	game_running(false), !,			
	
	/* Modify fact that game is running */	
	retract(game_running(false)),
	asserta(game_running(true)), 
	
	show_title,
	load_game('cache.txt'),

	set_object,
	init_world,
	save_game('cache.txt').
 
init:-

	/* If game has already begun */
	game_running(true),
	write('Game has already begun !'), nl.
	
/*** ==============================       MAP     ================================== ***/

world_width(15).
world_height(10).

/** ~~~~~~~~~~~~~~~~~ initializing ~~~~~~~~~~~~~~~~~**/

init_world:-
	/* Rules to generate plain map */
	world_height(WH),
	init_world_row(WH).

init_world_row(Row):-
	Row == 0, !.
	
init_world_row(Row):-
	world_width(WD),
	create_plain_world(Row, 1, WD),!,
	New_row is Row -1, 
	init_world_row(New_row).

create_plain_world(_,_,Span):-
	Span == 0, !.
	
create_plain_world(Row, Col, Span):-

	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,
	
	New_row is Row,
	New_col is Col + 1,
	New_span is Span - 1,

	asserta(world(plain, Row, Col)),!,
	
	create_plain_world(New_row, New_col, New_span),!.	
	
/**~~~~~~~~~~~~~~~~~ Create custom world ~~~~~~~~~~~~~~~~~**/

create_world(_,_,_,Span,_):-
	Span == 0, !.
	
create_world(_, Row, _, _, _):-
	world_height(WH), Row > WH,
	write('The world is inbalanced,... dimensional overflow !'),nl.
	
create_world(_, _, Col, _, _):-
	world_width(WD), Col > WD,
	write('The world is inbalanced,... dimensional overflow !'),nl.
	
create_world(Type, Row, Col, Span, Is_row):-
	/*
	type : what kind of terain
	row : starting row
	col : starting col
	span : how many tiles spanning
	is_row : span to which direction ? true -> span row -> downward | false -> span col -> rightward 
	*/

	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,
	
	\+ Is_row,
	New_row is Row,
	New_col is Col + 1,
	New_span is Span - 1,
	
	world(C_Type, Row, Col),
	retract(world(C_Type, Row, Col)),
	asserta(world(Type, Row, Col)),!,
	
	create_world(Type, New_row, New_col, New_span, Is_row),!.
	
create_world(Type, Row, Col, Span, Is_row):-
	/*
	type : what kind of terain
	row : starting row
	col : starting col
	span : how many tiles spanning
	is_row : span to which direction ? true -> span row -> downward | false -> span col -> rightward 
	*/
	
	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,

	Is_row,
	New_row is Row + 1,
	New_col is Col,
	New_span is Span - 1,
	
	world(C_Type, Row, Col),
	retract(world(C_Type, Row, Col)),
	asserta(world(Type, Row, Col)),!,
	
	create_world(Type, New_row, New_col, New_span, Is_row),!.
	
/**~~~~~~~~~~~~~~~~~ Displaying map ~~~~~~~~~~~~~~~~~**/

print_map_symbol(X,Y):-
	/* Printing map elemetn as symbol */
	world(Type,X,Y),!,
	format(" ~p ",[Type]).
	
print_whole_map(Row, Col):-

	world_width(WD),
	world_height(WH),
	Row == WH, 
	Col == WD, !,
	print_map_symbol(Row, Col),
	!.

print_whole_map(Row, Col):-

	world_width(WD),
	print_map_symbol(Row,Col),
	
	Col < WD,
	New_col is Col + 1, !,
	print_whole_map(Row, New_col).
	
print_whole_map(Row, Col):-

	world_width(WD),
	
	Col == WD, nl,
	New_row is Row + 1, !,
	print_whole_map(New_row, 1).

/*** ====================        SAVE AND LOAD       ======================== ***/

load_game(Filename):-
	/* Function to load file */
	
	open(Filename, read, Stream),

	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y), 
	player_weapon(Weapon),
	player_inventory(Inventory),
	
	retract(player_health(Health)),
	retract(player_hunger(Hunger)),
	retract(player_thirst(Thirst)),
	retract(player_pos(Pos_x, Pos_y)),
	retract(player_weapon(Weapon)),
	retract(player_inventory(Inventory)),
	
	/* Read player data */
	read(Stream, New_Health), 	 
	read(Stream, New_Hunger), 	 
	read(Stream, New_Thirst), 	 
	read(Stream, New_Pos_x), 	
	read(Stream, New_Pos_y),	
	read(Stream, New_Weapon),	
	read(Stream, New_Inventory), 
	
	asserta(player_health(New_Health)),
	asserta(player_hunger(New_Hunger)),
	asserta(player_thirst(New_Thirst)),
	asserta(player_pos(New_Pos_x, New_Pos_y)),
	asserta(player_weapon(New_Weapon)),
	asserta(player_inventory(New_Inventory)),
	
	map_width(Map_width), 
	map_length(Map_length), 
	map_items(Map_items),
	enemies(Enemies),
	special_terains(Special_terains),

	retract(map_width(Map_width)),
	retract(map_length(Map_length)),
	retract(map_items(Map_items)),
	retract(enemies(Enemies)),
	retract(special_terains(Special_terains)),
	
	/* Read map data */
	read(Stream, New_Map_width),    	
    read(Stream, New_Map_length),	
	read(Stream, New_Map_items),		
	read(Stream, New_Enemies),			
	read(Stream, New_Special_terains),	

	asserta(map_width(New_Map_width)),
	asserta(map_length(New_Map_length)),
	asserta(map_items(New_Map_items)),
	asserta(enemies(New_Enemies)),
	asserta(special_terains(New_Special_terains)),
	
	write('Data successfully loaded !'), nl,
	close(Stream).

	
save_game(Filename):-
	/* Function to save file */
	
	open(Filename, write, Stream),

	/* Gathering data */
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y), 
	player_weapon(Weapon),
	player_inventory(Inventory),
	
	map_width(Map_width), 
	map_length(Map_length), 
	map_items(Map_items),
	enemies(Enemies),
	special_terains(Special_terains),

	/* Write player data */
	write(Stream, Health), 			write(Stream, '.'), nl(Stream),
	write(Stream, Hunger), 			write(Stream, '.'), nl(Stream),
	write(Stream, Thirst), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_x), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_y), 			write(Stream, '.'), nl(Stream),
	write(Stream, Weapon), 			write(Stream, '.'), nl(Stream),
	write(Stream, Inventory), 		write(Stream, '.'), nl(Stream),
	
	/* Write map data */
	write(Stream, Map_width),		write(Stream, '.'), nl(Stream),
	write(Stream, Map_length), 		write(Stream, '.'), nl(Stream),
	write(Stream, Map_items), 		write(Stream, '.'), nl(Stream),
	write(Stream, Enemies), 		write(Stream, '.'), nl(Stream),
	write(Stream, Special_terains), write(Stream, '.'), nl(Stream),
	
	write('Save data successfully created !'), nl,
	close(Stream).
	

/*** ====================        MODIFY FACT       ======================== ***/	

modify_player_health(Change):- 
	/* rules to change player health */
	
	player_health(X),
	retract(player_health(X)),
	Z is X + Change,
	asserta(player_health(Z)).
	
modify_player_hunger(Change):- 
	/* rules to change player hunger */
	
	player_hunger(X),
	retract(player_hunger(X)),
	Z is X + Change,
	asserta(player_hunger(Z)).
	
modify_player_thirst(Change):- 
	/* rules to change player thirst */
	
	player_thirst(X),
	retract(player_thirst(X)),
	Z is X + Change,
	asserta(player_thirst(Z)).
	
modify_player_position(Change_X, Change_Y):-
	/* rules to change player position */
	
	player_pos(X, Y),
	retract(player_pos(X, Y)),
	NX is X + Change_X,
	NY is Y + Change_Y,
	asserta(player_pos(NX, NY)).

modify_player_weapon(New_weapon):- 
	/* rules to change player thirst */
	
	player_weapon(X),
	retract(player_weapon(X)),
	asserta(player_weapon(New_weapon)).
	
modify_inventory(New_inventory):- 
	/* rules to change inventory */
	player_inventory(Y),
	retract(player_inventory(Y)),
	asserta(player_inventory(New_inventory)).
	
modify_map_items(New_map_items):-
	/* rules to change items on map */
	map_items(C),
	retract(map_items(C)),
	asserta(map_items(New_map_items)).
	

modify_enemies:- !.
	
/*** ====================        OBJECT         ======================== ***/

set_object:-
	/* Rules to specify which category does specific items belong to */
	
	asserta(medicine(first_aid)),
	asserta(medicine(bandage)),
	asserta(medicine(pain_killer)),
	asserta(medicine(herbs)),
	asserta(medicine(stimulant)),
	
	asserta(food(canned_food)),
	asserta(food(fruits)),
	asserta(food(raw_meat)),
	asserta(food(mushrooms)),
	asserta(food(edible_plant)),
	
	asserta(water(bottled_water)),
	asserta(water(clean_water)),
	asserta(water(bottled_tea)),
	
	asserta(weapon(rifle)),
	asserta(weapon(long_sword)),
	asserta(weapon(bow_arrow)),
	asserta(weapon(long_bow)),
	asserta(weapon(spear)),

	/* Set object value as fact */

	asserta(other(cloth)),
	asserta(other(maps)),
	asserta(other(backpack)),
	asserta(other(pouch)),
	asserta(other(empty_bottle)),
	asserta(other(empty_can)),
	asserta(other(magic_wand)),
	asserta(other(stick)),
	
	asserta(special(radar)),
	asserta(special(barrier)),
	asserta(special(flare)),

	asserta(stataddition(first_aid,100)), 
	asserta(stataddition(bandage,70)),
	asserta(stataddition(pain_killer,40)),
	asserta(stataddition(herbs,20)),
	asserta(stataddition(stimulant,10)),
	
	asserta(stataddition(canned_food,100)),
	asserta(stataddition(fruits,70)),
	asserta(stataddition(raw_meat,40)),
	asserta(stataddition(mushrooms,20)),
	asserta(stataddition(edible_plant,10)),
	
	asserta(stataddition(bottled_water,100)),
	asserta(stataddition(clean_water,70)),
	asserta(stataddition(bottled_tea,40)),

	asserta(weapon_atk(rifle, 37)),
	asserta(weapon_atk(long_sword, 29)),
	asserta(weapon_atk(bow_arrow, 22)),
	asserta(weapon_atk(long_bow, 31)),
	asserta(weapon_atk(spear, 24)).


/*** ====================       CHANGE INVENTORY       ======================== ***/

addObj([], C, [C]) :- !.
addObj([A|B], C, [A|D]) :- addObj(B, C, D).

delObj([], _, []) :- !.
delObj([A|B], C, B) :- C == A, !.
delObj([A|B], C, [A|D]) :- C \== A, delObj(B, C, D).

schObj([], _, 0) :- !.
schObj([A|_], C, X) :- A == C, !, X is 1.
schObj([A|B], C, X) :- A \== C, schObj(B, C, X).	

print_inventory(Inventory):-
	Inventory = [], !.

print_inventory(Inventory):-
	[Head|Tail] = Inventory,
	format(" -  ~p \n", [Head]),
	print_inventory(Tail).

	
/***  ========================      INITIATE PLAYER        ======================== ***/

%initPlayer:-random(1,15,X),random(1,15,Y),/*look_pos(X,Y)*/,!,initPlayer.
%initPlayer:-random(1,15,X),random(1,15,Y),asserta(player_pos(X,Y,)).
	

get_terain_position([]):- !.
get_terain_position([Head | Tail]) :- [_,Terain_x, Terain_y] = Head , asserta(pos_terrains(Terain_x,Terain_y)),get_terain_position(Tail).  

get_enemy([]):- !.
get_enemy([Head|Tail]):- [H,AE,X,Y] = Head , asserta(enemy(H,AE,X,Y)),get_enemy(Tail).


/***  ========================      MOVE          ======================== ***/


%n:- player_pos(Pos_X,Pos_Y), Pos_Y\==15 ,Pos_Z is Pos_Y+1,pos_terrains(Terain_x,Terain_y),Pos_Z==Terain_y,Pos_X==Terain_x,!,write('cant move there\n'),nl.
%n:- player_pos(Pos_X,Pos_Y), Pos_Y\==15 ,Pos_Z is Pos_Y+1,retract(player_pos(Pos_X,Pos_Y)),asserta(player_pos(Pos_X,Pos_Z)).

%e:- player_pos(Pos_X,Pos_Y), Pos_X\==1 ,Pos_Z is Pos_X+1,pos_terrains(Terain_x,Terain_y),Pos_Y==Terain_y,Pos_Z==Terain_x,!,write('cant move there\n'),nl.
%e:- player_pos(Pos_X,Pos_Y), Pos_X\==1 ,Pos_Z is Pos_X+1,retract(player_pos(Pos_X,Pos_Y)),asserta(player_pos(Pos_Z,Pos_Y)).

%w:- player_pos(Pos_X,Pos_Y), Pos_X\==15 ,Pos_Z is Pos_X-1,pos_terrains(Terain_x,Terain_y),Pos_Y==Terain_y,Pos_Z==Terain_x,!,write('cant move there\n'),nl.
%w:- player_pos(Pos_X,Pos_Y), Pos_X\==15 ,Pos_Z is Pos_X-1,retract(player_pos(Pos_X,Pos_Y)),asserta(player_pos(Pos_Z,Pos_Y)).

%s:- player_pos(Pos_X,Pos_Y), Pos_Y\==1 ,Pos_Z is Pos_Y-1 ,pos_terrains(Terain_x,Terain_y),Pos_Z==Terain_y,Pos_X==Terain_x,!,write('cant move there\n'),nl.
%s:- player_pos(Pos_X,Pos_Y), Pos_Y\==1 ,Pos_Z is Pos_Y-1 ,retract(player_pos(Pos_X,Pos_Y)),asserta(player_pos(Pos_X,Pos_Z)).



/***  ========================       ATTACK        ======================== ***/


%player:- player_health(H),player_hunger(Hu),player_thirst(T),player_pos(Pos_X,Pos_Y),player_weapon(W),player_inventory(I),asserta(player(H,Hu,T,Pos_X,Pos_Y,W,I)).


%attack:- player(H,Hu,T,Pos_X,Pos_Y,W,I) W=:= 1,enemy(HE,AE,Pos_X,Pos_Y),retract(H,Hu,T,Pos_X,Pos_Y,W,I),retract(enemy(HE,AE,Pos_X,Pos_Y)),
%		   F is H - AE , HA is W - HE , HE\==0, write ('you get attacked '),asserta(player(F,Hu,T,Pos_X,Pos_Y,W,I)),asserta(enemy(HA,AE,Pos_X,Pos_Y))).

%attack:- player(H,Hu,T,Pos_X,Pos_Y,W,I) W=:= 1,enemy(HE,AE,Pos_X,Pos_Y),retract(H,Hu,T,Pos_X,Pos_Y,W,I),retract(enemy(HE,AE,Pos_X,Pos_Y)),
%		   F is H - AE , HA is W - HE , HE==0, write ('an enemy killed '),asserta(player(F,Hu,T,Pos_X,Pos_Y,W,I)),asserta(enemy(HA,AE,Pos_X,Pos_Y))).

%attack :- player(_,_,_,_,_,_,W,_), W =:= 1, write('No more enemy to attack in this place').

%attack :- write('you\'re not using any weapon').


/*** ====================        COMMAND        ======================== ***/	

map:-
	print_whole_map(1, 1).

look:-
	/* Rules to look surounding */
	
	player_pos(Pos_x, Pos_y),
	X1 is Pos_x - 1, Y1 is Pos_y - 1, print_map_symbol(X1,Y1),
	X2 is Pos_x + 0, Y2 is Pos_y - 1, print_map_symbol(X2,Y2),
	X3 is Pos_x + 1, Y3 is Pos_y - 1, print_map_symbol(X3,Y3),
	nl,
	X4 is Pos_x - 1, Y4 is Pos_y + 0, print_map_symbol(X4,Y4),
	write(' you '),
	X6 is Pos_x + 1, Y6 is Pos_y + 0, print_map_symbol(X6,Y6),
	nl,
	X7 is Pos_x - 1, Y7 is Pos_y + 1, print_map_symbol(X7,Y7),
	X8 is Pos_x + 0, Y8 is Pos_y + 1, print_map_symbol(X8,Y8),
	X9 is Pos_x + 1, Y9 is Pos_y + 1, print_map_symbol(X9,Y9).

	
take(Object) :- 
	player_pos(A,B),
	map_items(Oldmapitems),
	schObj(Oldmapitems, [Object,A,B], D), /* Cek apakah barang tersebut posisinya sama dengan player */
	D == 1,
	player_inventory(OldInventory),
	addObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	delObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	format("~p has been taken from this area.", [Object]), !.
	
take(Object) :- 
	player_pos(A,B),
	map_items(Oldmapitems),
	schObj(Oldmapitems, [Object,A,B], D), /* Cek apakah barang tersebut posisinya sama dengan player */
	D \== 1, !,
	format("~p was not found in this area.", [Object]), !.
	
drop(Object) :- 
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1,
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	addObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	format("You dropped ~p in this area.", [Object]), !.
	
drop(Object) :- 

	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D \== 1, !,
	format("You don't have ~p in your inventory.", [Object]), !.
	
use(Object) :-
	food(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_hunger(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You eat ~p. ", [Object]),
	format("Your hunger raised by ~p. ", [Addition]).

use(Object) :-
	medicine(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_health(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You used ~p. ", [Object]),
	format("Your health raised by ~p. ", [Addition]).
	
use(Object) :-
	water(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_thirst(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You drink ~p. ", [Object]),
	format("Your thirst raised by ~p. ", [Addition]).
	
use(Object) :-
	weapon(Object),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_weapon(Object),
	format("You wield ~p right now.", [Object]).
	
use(Object) :-
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D \== 1, !,
	format("You don't have ~p in your inventory.", [Object]).
	
status:-
	/* Command to show player's status */
	
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y),
	player_weapon(Weapon),	


	write('+========================+'), nl,
	write('|        STATUS          |'), nl,
	write('+========================+'), nl,
	format(" Health       : ~p~n",[Health]),
	format(" Hunger       : ~p~n",[Hunger]), 
	format(" Thirst       : ~p~n",[Thirst]), 
	format(" Weapon       : ~p~n",[Weapon]), 
	format(" Position     : <~p,~p> ~n",[Pos_x, Pos_y]),
	 write(' Inventory    : '),nl, show_inventory.


quit:-
	/* Command to quit and exit prolog */
	
	save_game('cache.txt'),
	write('Created auto-save data'), nl,
	write('Exiting in : 3..'), nl, sleep(1),
	write('2..'), nl, sleep(1),
	write('1..'), nl, sleep(1),
	halt.


/*** ====================        DISPLAY        ======================== ***/	
	
show_title:-
	/* Rules to show title */

	write('                                                                                                                                               '), nl,
	write('@@         @@@@       @@@@   @@@@    @@@@           @@      @@ @@@    @@ @@    @@ @@@    @@    @@@@    @@    @@    @@ @@@    @@   @@  @@@@@    '), nl,
	write('@@       @@    @@   @@    @@  @@   @@    @@         @@      @@ @@@@   @@ @@   @@  @@@@   @@  @@    @@  @@    @@    @@ @@@@   @@  @@  @@   @@   '), nl,
	write('@@      @@      @@ @@         @@  @@                @@      @@ @@ @@  @@ @@  @@   @@ @@  @@ @@      @@ @@    @@    @@ @@ @@  @@       @@       '), nl,
	write('@@      @@      @@ @@    @@@  @@  @@                @@      @@ @@  @@ @@ @@@@@@   @@  @@ @@ @@      @@  @@  @@@@  @@  @@  @@ @@         @@     '), nl,
	write('@@       @@    @@   @@    @@  @@   @@    @@          @@    @@  @@   @@@@ @@   @@  @@   @@@@  @@    @@    @@@@  @@@@   @@   @@@@      @@   @@   '), nl,
	write('@@@@@@@    @@@@       @@@@   @@@@    @@@@              @@@@    @@    @@@ @@    @@ @@    @@@    @@@@       @@    @@    @@    @@@       @@@@@    '), nl,
	write('                                                                                                                                               '), nl,
	write('@@@@@@@     @@@    @@@@@@@@ @@@@@@@@ @@      @@@@@@@      @@@@     @@@@@@@        @@@@      @@      @@   @@@    @@   @@@@@@     @@@@@          '), nl,
	write('@@    @@  @@   @@     @@       @@    @@      @@        @@     @@   @@    @@     @@    @@    @@      @@   @@@@   @@   @@    @@  @@   @@         '), nl,
	write('@@@@@@@@ @@     @@    @@       @@    @@      @@@@@@@   @@          @@    @@    @@      @@   @@      @@   @@ @@  @@   @@     @@  @@             '), nl,
	write('@@    @@ @@@@@@@@@    @@       @@    @@      @@        @@    @@@   @@@@@@@     @@      @@   @@      @@   @@  @@ @@   @@     @@    @@           '), nl,
	write('@@    @@ @@     @@    @@       @@    @@      @@         @@    @@   @@    @@     @@    @@     @@    @@    @@   @@@@   @@    @@  @@   @@         '), nl,
	write('@@@@@@@  @@     @@    @@       @@    @@@@@@@ @@@@@@@      @@@@     @@     @@      @@@@         @@@@      @@    @@@   @@@@@@     @@@@@          '), nl,
	write('                                                                                                                                               '), nl,nl,nl.


show_inventory:-
	player_inventory(Inventory),
	print_inventory(Inventory).


show_message:-
	!.

manual:-
	game_running(false),
	write('How about calling init. to start the game ? :) '),nl,nl,!.

manual:-
	/* Rules to show help */

	nl,nl,
	write('Opening manual book....'), nl,nl,
	write('Objective : Elminate all but yourself'), nl,nl,
	write('Available actions :'), nl,
	write('save(filename).    | Create save data of your current game'), nl,
	write('load(filename).    | Load save data from your previous game'), nl,
	write('manual.            | Cmon, you should know by now...'), nl,nl,

	write('look.              | Take a look at surounding ~ '), nl,
	write('n. s. e. w.        | Move one step toward the future '), nl,
	write('map.               | Display full map (only if you have radar though...'), nl,nl,

	write('take(object).      | Pick a(n) item from ground'), nl,
	write('drop(object).      | Drop a(n) item to the ground'), nl,
	write('use(object).       | Consume a(n) item'), nl,

	write('attack.            | Attack an enemy nearby'), nl,
	write('status.            | Display current status'), nl,nl,

	write('Map\'s legends:'),nl,
	write('M = medicine'),nl,
	write('F = food'),nl,
	write('W = water'),nl,
	write('# = weapon'),nl,
	write('P = you'),nl,
	write('- = accessible'),nl,
	write('X = inaccessible'),nl.


	
/*** ====================       STORAGE       ======================== ***/

printl(List):-
	[Head|Tail] = List,
	write(Head), write(Tail).

printall(Data):-
	Data = [], !.

printall(Data):-
	[Head|Tail] = Data,
	write(Head),write(' '),
	printall(Tail).

