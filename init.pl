
/***  ========================      INITIALIZATION        ======================== ***/


amount(medicine, 25, 30).
amount(food, 27, 35).
amount(water, 15, 25).
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
	
	set_object,
	init_world, create_border,
	init_item_on_map,
	init_enemy_on_map,
	
	save_game('cache.txt').
	
	
/** ~~~~~~~~~~~~            game mode          ~~~~~~~~~~~ **/

cont:-
	game_running(false),!,
	write('How about starting the game first ? :) ').
	
cont:-
	game_running(true),!,
	
	load_game('cache.txt'),
	init.

new_game:-
	game_running(false),!,
	write('How about starting the game first ? :) ').
	
new_game:-
	game_running(true),!,
	
	initPlayer,
	%random_enemy,
	%random_object,
	init.
	
	
	
	
	
	