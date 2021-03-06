
/***  ========================      INITIALIZATION        ======================== ***/


/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~          Declaration of constants             ~~~~~~~~~~~~~~~~~~~~~~~~~~**/

amount(medicine, 25, 30).
amount(food, 22, 27).
amount(water, 21, 25).
amount(weapon, 13, 18).
amount(others, 30, 40).
amount(special, 7, 13).
amount(enemy, 20, 30).
amount(enemy_atk, 23, 35).
amount(player_init_hp, 150, 200).
amount(player_init_hunger, 100, 150).
amount(player_init_thirst, 100, 150).
amount(player_hp, 0, 200).
amount(player_hunger, 0 , 150).
amount(player_thirst, 0, 150).
amount(inventory, 0, 10).



/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~          Initialization section             ~~~~~~~~~~~~~~~~~~~~~~~~~~**/

initPlayer:-
	/* initialize player info */
	
	world_width(WD),
	world_height(WH),
	
	WH1 is WH - 1,
	WD1 is WD - 1,
	
	/* Get current conditions */
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y), 
	player_weapon(Weapon),
	player_inventory(Inventory),
	
	/* Remove current conditions */
	retract(player_health(Health)),
	retract(player_hunger(Hunger)),
	retract(player_thirst(Thirst)),
	retract(player_pos(Pos_x, Pos_y)),
	retract(player_weapon(Weapon)),
	retract(player_inventory(Inventory)),
	
	/* Initialize random value */
	amount(player_init_hp, Init_hp_min, Init_hp_max), 
	randomize,random(Init_hp_min, Init_hp_max, New_init_hp),
	
	amount(player_init_hunger, Init_hunger_min, Init_hunger_max),
	randomize,random(Init_hunger_min, Init_hunger_max, New_init_hunger),
	
	amount(player_init_thirst, Init_thirst_min, Init_thirst_max),
	randomize,random(Init_thirst_min, Init_thirst_max, New_init_thirst),
	
	randomize,random(2, WH1, Row), 
	randomize,random(3, WD1, Col),
	
	/* Set random generated value into status */
	asserta(player_health(New_init_hp)),
	asserta(player_hunger(New_init_hunger)),
	asserta(player_thirst(New_init_thirst)),
	asserta(player_pos(Row, Col)),
	asserta(player_weapon(bare_hands)),
	asserta(player_inventory([])).
	
	

init:-
	/* Rules to initialize game : game not started */

	game_running(false),!,
	write('How about try to start. first ? :)'),nl.
	
init:-
	/* Rules to initialize game : game started, not initialized */

	game_running(true),!,
	game_initialized(false),!,

	retract(game_initialized(false)),
	asserta(game_initialized(true)),
	
	/* General initialization */
	set_object,
	init_world, 
	init_item_on_map,
	init_enemy_on_map,
	
	save_game('cache.txt').
	
init:-
	/* Rules to initialize game : game started, initialized */

	game_running(true),!,
	game_initialized(true),!,
	
	write('Your game has already begun !'),nl.
	




	
/** ~~~~~~~~~~~~~~~~~~~~~~~~~~            game mode          ~~~~~~~~~~~~~~~~~~~~~~~~~~~ **/

cont:-
	/* Continue last game : game not started */

	game_type_set(false),
	game_running(false),!,
	write('How about starting the game first ? :) '),nl.
	
cont:-
	/* Continue last game : game started, not initialized */

	game_type_set(false),
	game_running(true),!,
	
	retract(game_type_set(false)),
	asserta(game_type_set(true)),
	load_game('cache.txt'),
	init.

cont:-
	/* Continue last game : game started, initialized */

	game_type_set(true),!,
	write('You are already in game .... '),nl.	


new_game:-
	/* Create new game : game not started */

	game_running(false),!,
	write('How about starting the game first ? :) ').
	
new_game:-
	/* Create new game : game started, not initialized */

	game_running(true),!,
	
	nl,nl,nl,nl,write('~ Generating new world ~'),nl,sleep(3),nl,
	initPlayer,
	set_enemies,
	random_object,
	init,
	show_preface.



/** ~~~~~~~~~~~~~~~~~~~~~~~~~~         in-game checking           ~~~~~~~~~~~~~~~~~~~~~~~~~~~ **/

check_game_condition:-
	/* Rules to check if player is dead caused of 0 health */

	player_health(Health),
	
	Health =< 0,!,
	write('          Your vision slowly turns to black and your heart beats slower every time. The last thing you felt was the cold spreading through your body.'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                            You\'ve lost too much blood...            '),!,sleep(5),quit.

check_game_condition:-
	/* Rules to check if player is dead caused of 0 hunger */

	player_hunger(Hunger),
	
	Hunger =< 0,!,
	write('                         Your vision slowly turns to black and you can\'t move at all... The last thing you felt was ...'), nl,nl, sleep(2),
	write('                                                                       save me...'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                                You died due to hunger...            '),!,sleep(5),quit.
	
check_game_condition:-
	/* Rules to check if player is dead caused of 0 thirst */

	player_thirst(Thirst),

	Thirst =< 0,!,
	write('                           Your vision slowly turns to black and you can\'t think of anything ... The last thing you felt was ...'), nl, sleep(2),
	write('                                                                         save me...'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                               You died due to dehidration...            '),!,sleep(5),quit.
	
	
	
check_game_condition:-
	/* Rules to check if no more enemies */
	
	enemies(Enemies),
	
	Enemies == [],!,
	nl,nl,nl,show_congratulation,
	write('                                               You heard the horn sound, you are very familiar with it. '),nl,sleep(2),
	write('                                       Every year you would hear the exact sound when the game has reached an end,.. '),nl,sleep(2),
	write('                                 The horn signals that a victorious warrior has come out alive after the fierce battle...'),nl,nl,sleep(3),
	write('                                                                You have won the Games!...            '),nl,!.

check_game_condition :- !.
	/* Check in game condition : basis */