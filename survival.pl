
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
	save_game('cache.txt').
 
init:-

	/* If game has already begun */
	game_running(true),
	write('Game has already begun !'), nl.
	

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
	
	player_thirst(X),
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
	
	asserta(other(panties)),
	asserta(other(maps)),
	asserta(other(backpack)),
	asserta(other(pouch)),
	asserta(other(refillable_bottle)),
	asserta(other(empty_can)),
	asserta(other(magic_wand)),
	asserta(other(stick)),
	
	asserta(special(radar)),
	asserta(special(tent)),
	asserta(special(flare)).
	

/*** ====================       PENGUBAHAN INVENTORY       ======================== ***/

addObj([], C, [C]) :- !.
addObj([A|B], C, [A|D]) :- addObj(B, C, D).

delObj([], _, []) :- !.
delObj([A|B], C, B) :- C == A, !.
delObj([A|B], C, [A|D]) :- C \== A, delObj(B, C, D).

schObj([], _, 0) :- !.
schObj([A|_], C, X) :- A == C, !, X is 1.
schObj([A|B], C, X) :- A \== C, schObj(B, C, X).	
	
/*** ====================        COMMAND        ======================== ***/	


take(X) :- 
	player_pos(A,B),
	map_items(C),
	schObj(C, [X,A,B], D), /* Cek apakah barang tersebut posisinya sama dengan player */
	D is 1,
	player_inventory(Y),
	addObj(Y, X, Z),
	modify_inventory(Z),
	delObj(C, [X,A,B], E),
	modify_map_items(E).
	
drop(X) :- 
	player_pos(A,B),
	map_items(C),
	player_inventory(Y),
	schObj(Y, X, D), /* Cek apakah barang tersebut ada di inventory */
	D is 1,
	delObj(Y, X, Z),
	modify_inventory(Z),
	addObj(C, [X,A,B], E),
	modify_map_items(E).
	
use(X) :-
	food(X),
	player_inventory(Y),
	schObj(Y, X, D), /* Cek apakah barang tersebut ada di inventory */
	D is 1, !,
	delObj(Y, X, Z),
	modify_inventory(Z),
	modify_player_hunger(50). /* NILAI MUNGKIN BERUBAH */

use(X) :-
	medicine(X),
	player_inventory(Y),
	schObj(Y, X, D), /* Cek apakah barang tersebut ada di inventory */
	D is 1, !,
	delObj(Y, X, Z),
	modify_inventory(Z),
	modify_player_health(50). /* NILAI MUNGKIN BERUBAH */
	
use(X) :-
	water(X),
	player_inventory(Y),
	schObj(Y, X, D), /* Cek apakah barang tersebut ada di inventory */
	D is 1, !,
	delObj(Y, X, Z),
	modify_inventory(Z),
	modify_player_thirst(50). /* NILAI MUNGKIN BERUBAH */
	
use(X) :-
	weapon(X),
	player_inventory(Y),
	schObj(Y, X, D), /* Cek apakah barang tersebut ada di inventory */
	D is 1, !,
	delObj(Y, X, Z),
	modify_inventory(Z),
	modify_player_weapon(X). 
	
status:-
	/* Command to show player's status */
	
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y),
	player_weapon(Weapon),	
	player_inventory(Inventory),

	/* Looks messy here, but tidy in display ~ */
	write('+========================+'), nl,
	write('|                 STATUS                  |'), nl,
	write('+========================+'), nl,
	format(" Health       : ~a~n",[Health]),
	format(" Hunger       : ~a~n",[Hunger]), 
	format(" Thirst         : ~a~n",[Thirst]), 
	format(" Weapon     : ~a~n",[Weapon]), 
	format(" Position     : <~a,~a> ~n",[Pos_x, Pos_y]),
	write(' Inventory   : '), show_inventory.


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

	write('_______________________________________________________________________________________________________________________________________________'), nl,
	write('00_________0000_______0000___0000____0000___________00______00_000____00_00____00_000____00____0000____00____00____00_000____00___00__00000____'), nl,
	write('00_______00____00___00____00__00___00____00_________00______00_0000___00_00___00__0000___00__00____00__00____00____00_0000___00__00__00___00___'), nl,
	write('00______00______00_00_________00__00________________00______00_00_00__00_00__00___00_00__00_00______00_00____00____00_00_00__00_______00_______'), nl,
	write('00______00______00_00____000__00__00________________00______00_00__00_00_000000___00__00_00_00______00__00__0000__00__00__00_00_________00_____'), nl,
	write('00_______00____00___00____00__00___00____00__________00____00__00___0000_00___00__00___0000__00____00____0000__0000___00___0000______00___00___'), nl,
	write('0000000____0000_______0000___0000____0000______________0000____00____000_00____00_00____000____0000_______00____00____00____000_______00000____'), nl,
	write('_______________________________________________________________________________________________________________________________________________'), nl,
	write('0000000_____000____00000000_00000000_00______0000000______0000_____0000000________0000______00______00___000____00___000000_____00000__________'), nl,
	write('00____00__00___00_____00_______00____00______00________00_____00___00____00_____00____00____00______00___0000___00___00____00__00___00________ '), nl,
	write('00000000_00_____00____00_______00____00______0000000___00__________00____00____00______00___00______00___00_00__00___00_____00__00_____________'), nl,
	write('00____00_000000000____00_______00____00______00________00____000___0000000_____00______00___00______00___00__00_00___00_____00____00___________'), nl,
	write('00____00_00_____00____00_______00____00______00_________00____00___00____00_____00____00_____00____00____00___0000___00____00__00___00_________'), nl,
	write('0000000__00_____00____00_______00____0000000_0000000______0000_____00_____00______0000_________0000______00____000___000000_____00000__________'), nl,
	write('_______________________________________________________________________________________________________________________________________________'), nl,nl,nl.

	
show_inventory:-
	!.
	
show_message:-
	!.

show_help:-
	!.
	
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
