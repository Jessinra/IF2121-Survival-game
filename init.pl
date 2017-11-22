
/***  ========================      INITIALIZATION        ======================== ***/


amount(medicine, 25, 30).
amount(food, 22, 27).
amount(water, 21, 25).
amount(weapon, 13, 18).
amount(others, 30, 40).
amount(special, 7, 13).
amount(enemy, 20, 30).
amount(enemy_atk, 17, 51).
amount(player_init_hp, 150, 200).
amount(player_init_hunger, 150, 200).
amount(player_init_thirst, 150, 200).

initPlayer:-
	/* initialize player info */
	
	world_width(WD),
	world_height(WH),
	
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
	
	amount(player_init_hp, Init_hp_min, Init_hp_max), 
	random(Init_hp_min, Init_hp_max, New_init_hp),
	
	amount(player_init_hunger, Init_hunger_min, Init_hunger_max),
	random(Init_hunger_min, Init_hunger_max, New_init_hunger),
	
	amount(player_init_thirst, Init_thirst_min, Init_thirst_max),
	random(Init_thirst_min, Init_thirst_max, New_init_thirst),
	
	random(1, WH, Row), random(1, WD, Col),
	
	asserta(player_health(New_init_hp)),
	asserta(player_hunger(New_init_hunger)),
	asserta(player_thirst(New_init_thirst)),
	asserta(player_pos(Row, Col)),
	asserta(player_weapon(bare_hand)),
	asserta(player_inventory([])).
	
	
init:-
	game_running(false),!,
	
	write('How about try to start. first ? :)'),nl.
	
init:-
	/* General initialization */
	game_running(true),!,
	game_initialized(false),!,
	
	
	retract(game_initialized(false)),
	asserta(game_initialized(true)),
	
	set_object,
	init_world, 
	
	
	init_item_on_map,
	init_enemy_on_map,
	
	save_game('cache.txt').
	
init:-
	/* General initialization */
	game_running(true),!,
	game_initialized(true),!,
	
	write('Your game has already begun !'),nl.
	
	
/** ~~~~~~~~~~~~            game mode          ~~~~~~~~~~~ **/

cont:-
	game_type_set(false),
	game_running(false),!,
	write('How about starting the game first ? :) '),nl.
	
cont:-

	game_type_set(false),
	game_running(true),!,
	
	retract(game_type_set(false)),
	asserta(game_type_set(true)),
	load_game('cache.txt'),
	init.

cont:-
	game_type_set(true),!,
	write('You are already in game .... '),nl.	

new_game:-
	game_running(false),!,
	write('How about starting the game first ? :) ').
	
new_game:-
	game_running(true),!,
	
	initPlayer,
	%random_enemy,
	%random_object,
	init.

check_game_condition:-

	player_health(Health),
	
	Health == 0,!,
	write('          Your vision slowly turns to black and your heart beats slower every time. The last thing you felt was the cold spreading through your body.'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                            You\'ve lost too much blood...            ').

check_game_condition:-
	
	player_hunger(Hunger),
	
	Hunger == 0,!,
	write('                         Your vision slowly turns to black and you can\'t move at all... The last thing you felt was ...'), nl,nl, sleep(2),
	write('                                                                       save me...'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                                You died due to hunger...            ').
	
check_game_condition:-
	
	player_thirst(Thirst),
	Thirst == 0,!,
	write('                           Your vision slowly turns to black and you can\'t think of anything ... The last thing you felt was ...'), nl, sleep(2),
	write('                                                                         save me...'), nl, sleep(2),
	nl,nl,nl,show_you_died,
	write('                                                               You died due to dehidration...            ').
	
check_game_condition:-
	
	enemies(Enemies),
	
	Enemies == [],!,
	nl,nl,nl,show_congratulation,
	write('                                               You heard the horn sound, you are very familiar with it. '),nl,
	write('                            Every year you would hear the exact sound when watching the Hunger Games in your district. '),nl,
	write('                                                   The horn signals the end of the Hunger Games.'),nl,nl,
	write('                                                               You have won the Games!...            '),nl.
	
	
	
	
	