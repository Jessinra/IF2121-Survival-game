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
	
modify_enemies(New_enemy_list):-
	/* rules to change enemies on map */
	enemies(C),
	retract(enemies(C)),
	asserta(enemies(New_enemy_list)).
	
	
	
	
