
/*** ====================         DECLARATION OF DYNAMIC FACT     =========================== ***/

:- dynamic(game_running/1).			game_running(false).
:- dynamic(game_type_set/1). 		game_type_set(false).
:- dynamic(game_initialized/1). 	game_initialized(false).

:- dynamic(player_health/1).		player_health(0).
:- dynamic(player_hunger/1).		player_hunger(0). 
:- dynamic(player_thirst/1).		player_thirst(0). 
:- dynamic(player_pos/2).			player_pos(0, 0). 
:- dynamic(player_weapon/1).		player_weapon(bare_hand).
:- dynamic(player_inventory/1).  	player_inventory([]).
:- dynamic(map_width/1).			map_width(0). 
:- dynamic(map_length/1).			map_length(0). 
:- dynamic(map_items/1).			map_items(0).
:- dynamic(enemies/1).				enemies(0).
:- dynamic(special_terains/1).		special_terains(0).


/*** ====================         INCLUDE OTHER FILE     =========================== ***/

:- include(save_load).
:- include(display).
:- include(object).
:- include(move).
:- include(attack).
:- include(map).
:- include(enemy).
:- include(modify).
:- include(inventory).
:- include(init).
:- include(storage).

/*** ====================         MAIN FUNCITON     =========================== ***/


start:-	
	/* Rules to start the game : not yet started */
	
	/* If game has not been run yet */	
	game_running(false), !,			
	
	/* Modify fact that game is running */	
	retract(game_running(false)),
	asserta(game_running(true)), 
	show_title,nl,nl,nl,
	
	write('          Type cont. to continue, or new_game. to start a new game '),nl ,nl.
	
	
start:-
	/* Rules to start the game : already started */

	/* If game has already begun */
	game_running(true),
	write('Game has already begun !'), nl.
	

quit:-
	/* Command to quit and exit prolog */
	
	save_game('cache.txt'),
	write('Created auto-save data'), nl,
	write('Exiting in : 3..'), nl, sleep(1),
	write('2..'), nl, sleep(1),
	write('1..'), nl, sleep(1),
	halt.
