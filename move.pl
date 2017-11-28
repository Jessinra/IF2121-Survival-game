
/***  ========================      MOVE          ======================== ***/

w:- 
	/* command to move left : fail condition */

	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col - 1,
	world(border, Pos_row, Pos_new),!,
	write('Seems I can\'t move there....\n'),nl,
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	generate_enemy_movement,
	check_game_condition.
	
w:- 
	/* command to move left */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col - 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_row,Pos_new)),
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	
	generate_enemy_movement,
	check_game_condition.

n:- 
	/* command to move up : fail condition */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row - 1,
	world(border, Pos_new, Pos_col),!,
	write('Seems I can\'t move there....\n'),nl,
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	generate_enemy_movement,
	check_game_condition.

n:- 
	/* command to move up */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row - 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_new,Pos_col)),
	modify_player_hunger(-1),
	modify_player_thirst(-1),

	generate_enemy_movement,
	check_game_condition.
	
e:- 
	/* command to move right : fail condition */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col + 1,
	world(border, Pos_row, Pos_new),!,
	write('Seems I can\'t move there....\n'),nl,
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	
	generate_enemy_movement,
	check_game_condition.
 
e:- 
	/* command to move right */
	 
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col + 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_row,Pos_new)),
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	
	generate_enemy_movement,
	check_game_condition.

s:- 
	/* command to move down : fail condition */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row + 1,
	world(border, Pos_new, Pos_col),!,
	write('Seems I can\'t move there....\n'),nl,
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	
	generate_enemy_movement,
	check_game_condition.
	
s:- 
	/* command to move down */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row + 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_new,Pos_col)),
	modify_player_hunger(-1),
	modify_player_thirst(-1),
	
	generate_enemy_movement,
	check_game_condition.
