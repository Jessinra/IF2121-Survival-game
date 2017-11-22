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
	
	asserta(weapon(riffle)),
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
	asserta(special(void_bomb)),

	asserta(stataddition(first_aid,20)), 
	asserta(stataddition(bandage,25)),
	asserta(stataddition(pain_killer,40)),
	asserta(stataddition(herbs,15)),
	asserta(stataddition(stimulant,25)),
	
	asserta(stataddition(canned_food,40)),
	asserta(stataddition(fruits,15)),
	asserta(stataddition(raw_meat,35)),
	asserta(stataddition(mushrooms,10)),
	asserta(stataddition(edible_plant,15)),
	
	asserta(stataddition(bottled_water,40)),
	asserta(stataddition(clean_water,60)),
	asserta(stataddition(bottled_tea,25)).

	
/**~~~~~~~~~~~~~~~~~~         initialize item into map        ~~~~~~~~~~~~~~~~~**/
init_item_on_map:-
	/* initialize item to map from save data */
	map_items(Items),
	set_item_on_map(Items).

set_item_on_map(Items):-
	Items == [], !.

set_item_on_map(Items):-
	[Head|Tail] = Items,
	[Item_name, Row, Col] = Head,
	
	asserta(item_on_map(Item_name, Row, Col)),
	set_item_on_map(Tail).
	


random_object([A1,X1,Y1],C,D) :- 
	/* initialize item to map when started as new game */
	
	amount(medicine, M_min, M_max),
	random(M_min, M_max, E),
	random_object_medicine([A1,X1,Y1],C,E,D),
	
	amount(medicine, F_min, F_max),
	random(F_min, F_max, E),
	random_object_food([A1,X1,Y1],C,E,D),
	
	amount(medicine, D_min, D_max),
	random(D_min, D_max, E),
	random_object_water([A1,X1,Y1],C,E,D),
	
	amount(medicine, W_min, W_max),
	random(W_min, W_max, E),
	random_object_weapon([A1,X1,Y1],C,E,D),
	
	amount(medicine, S_min, S_max),
	random(S_min, S_max, E),
	random_object_special([A1,X1,Y1],C,E,D),
	
	amount(medicine, O_min, O_max),
	random(O_min, O_max, E),
	random_object_others([A1,X1,Y1],C,E,D).

random_object_medicine([],[],0,_) :- !.
random_object_medicine([A1,X1,Y1],C,E,D) :-
	/* generate random medicine */

	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_medicine([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_medicine([A1,X1,Y1],C,E1,D),
	modify_map_items(D).

random_object_food([],[],0,_) :- !.
random_object_food([A1,X1,Y1],C,E,D) :-  
	/* generate random food */
	
	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_food([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_food([A1,X1,Y1],C,E1,D),
	modify_map_items(D).

random_object_water([],[],0,_) :- !.
random_object_water([A1,X1,Y1],C,E,D) :-  
	/* generate random water */
	
	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_water([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_water([A1,X1,Y1],C,E1,D),
	modify_map_items(D).

random_object_weapon([],[],0,_) :- !.
random_object_weapon([A1,X1,Y1],C,E,D) :-  
	/* generate random weapon */
	
	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_weapon([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_weapon([A1,X1,Y1],C,E1,D),
	modify_map_items(D).

random_object_special([],[],0,_) :- !.
random_object_special([A1,X1,Y1],C,E,D) :-  
	/* generate random special item */
	
	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_special([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_special([A1,X1,Y1],C,E1,D),
	modify_map_items(D).		
	
random_object_others([],[],0,_) :- !.
random_object_others([A1,X1,Y1],C,E,D) :-  
	/* generate random other item */
	
	world_width(WD),
	world_height(WH),
	
	random(1,WD,X),
	random(1,WH,Y),
	player_pos(X2,Y2),
	(sublist([_,X,Y],C)#\/((X2==X)#\/(Y2==Y)))->
	random_object_others([A,X,Y],C,E,D);
	append([A,X,Y],C,D),
	E1 is E-1,
	random_object_others([A1,X1,Y1],C,E1,D),
	modify_map_items(D).		
	
	
/**~~~~~~~~~~       take, drop and use item       ~~~~~~~~~~~~~**/ 	
	
	
	
take(Object) :- 
	/* rules to take a(n) object from map into inventory -- if found case*/
	
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),
	schObj(Oldmapitems, [Object,A,B], D), /* Cek apakah barang tersebut posisinya sama dengan player */
	D == 1,
	
	
	addObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	
	delObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	
	retract(item_on_map(Object,A,B)),
	
	format("~p has been taken from this area.", [Object]), 
	generate_enemy_movement,!.
	
take(Object) :- 
	/* rules to take a(n) object from map into inventory -- if not found case */
	
	player_pos(A,B),
	map_items(Oldmapitems),
	schObj(Oldmapitems, [Object,A,B], D), /* Cek apakah barang tersebut posisinya sama dengan player */
	D \== 1, !,
	
	format("~p was not found in this area.", [Object]), 
	generate_enemy_movement,!.
	
drop(Object) :- 
	/* rule to drop a(n) object to map  -- if found case */
	
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	
	addObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	
	asserta(item_on_map(Object, A, B)),
	
	format("You dropped ~p in this area.", [Object]), 
	generate_enemy_movement,!.
	
drop(Object) :- 
	/* rule to drop a(n) object to map  -- if not found case */
	
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D \== 1, !,
	
	format("You don't have ~p in your inventory.", [Object]),
	generate_enemy_movement,!.

use(_) :-
	/* rule to use object -- basis */
	\+player_weapon(bare_hands),!,
	write('My hand\'s full, maybe I should store my weapon first'),nl.
	
use(Object) :-
	/* rule to eat object */
	player_weapon(bare_hands),
	food(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_hunger(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You ate the ~p. ", [Object]),
	format("Your hunger raised by ~p. ", [Addition]),
	generate_enemy_movement,!.

use(Object) :-
	/* rule to use object */
	player_weapon(bare_hands),
	medicine(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_health(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You used ~p. ", [Object]),
	format("Your health raised by ~p. ", [Addition]),
	generate_enemy_movement,!.
	
use(Object) :-
	/* rule to drink object */

	water(Object),
	stataddition(Object, Addition),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_thirst(Addition), /* NILAI MUNGKIN BERUBAH */
	format("You drank ~p. ", [Object]),
	format("Your thirst raised by ~p. ", [Addition]),
	generate_enemy_movement,!.
	
use(Object) :-
	/* rule to equip weapon */

	weapon(Object),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_weapon(Object),
	format("You wield ~p right now.", [Object]),
	generate_enemy_movement,!.
	
use(Object) :-
	/* trying to use non-existent item */
	
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D), /* Cek apakah barang tersebut ada di inventory */
	D \== 1, !,
	
	format("Sadly you don't have ~p in your inventory.", [Object]),
	generate_enemy_movement,!.

	
store:-
	/* Used to store current weapon into inventory */

	player_weapon(Current_weapon),
	player_inventory(OldInventory),
	addObj(OldInventory, Current_weapon, NewInventory),
	modify_inventory(NewInventory),
	modify_player_weapon(bare_hands),
	format("You stored your ~p, let's hope the best..", [Current_weapon]),
	generate_enemy_movement,!.


	
void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 0,!,
	
	write('What are you trying to do ? '),nl,
	generate_enemy_movement,!.
	
void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 1,
	
	write('A R E   Y O U   S U R E  ???'),nl,
	write(' <yes / no> : '), read(Input), Input == yes,!,
	
	\+ activate_bomb,!,
	delObj(OldInventory, void_bomb, NewInventory),
	modify_inventory(NewInventory),
	
	write('BOOOMMM !!!!..'), nl, sleep(1),
	write('..'), nl, sleep(1),
	write('..'), nl, sleep(1),
	write('You opened your eyes slowly, and you realized suddenly everything\'s gone...'),
	generate_enemy_movement,!.
	
void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 1,
	
	write('Good choice,... better save it for later use...'),
	generate_enemy_movement,!.

activate_bomb:-
	
	player_pos(Row, Col),
	enemy_on_map(ERow, ECol),
	abs(ERow - Row) =< 1,
	abs(ECol - Col) =< 1,
	retract(enemy_on_map(ERow,ECol)),fail.
	
	
	