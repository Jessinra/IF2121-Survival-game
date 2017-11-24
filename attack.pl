/***  ========================       ATTACK        ======================== ***/


attack:-  

	player_pos(Pos_row, Pos_col),
	player_weapon(W),
    W \== bare_hands,
    enemy_on_map(EAtk, Pos_row, Pos_col),
	enemies(Enemy_list),!,
	
    modify_player_health(-EAtk),
	format("You took ~p damages !!\n",[EAtk]),!,
    
	retract(enemy_on_map(EAtk, Pos_row, Pos_col)), 
    delObj(Enemy_list, [EAtk, Pos_row, Pos_col], Del_Enemy_list),
    modify_enemies(Del_Enemy_list),
	write('An enemy killed !'),nl,!,
	check_game_condition.
		  
attack:-  
	
	player_pos(Pos_row, Pos_col),
	player_weapon(W),
	W == bare_hands,
	enemy_on_map(EAtk, Pos_row, Pos_col),!,
	
	modify_player_health(-EAtk),
	format("You took ~p damages !!\n",[EAtk]),
	write('you\'re not using any weapon'),nl,!,
	check_game_condition.
	
attack:-  

	player_pos(Pos_row, Pos_col),
	\+ enemy_on_map(_, Pos_row, Pos_col),!,
	
	write('No more enemy to attack in this place'),nl,!,
	check_game_condition.
	

