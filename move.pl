/***  ========================      MOVE          ======================== ***/


%lookTerrain(X,Y):-
%X1 is X-1,Y1 is Y-1,X2 is X+1,Y2 is Y+1,
%write('You are in '),look_terrain(X,Y),write('\n'),
%write('To the north is '),look_terrain(X,Y1),write('\n'),
%write('To the west is '),look_terrain(X1,Y),write('\n'),
%write('To the east is '),look_terrain(X2,Y),write('\n'),
%write('To the south is '),look_terrain(X,Y2),write('\n').


w:- 
	/* command to move left */

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
	
	world(Prev_terain, Pos_row, Pos_col),
	world(New_terain, Pos_row, Pos_new),
	story_change_terains(Prev_terain, New_terain),
	
	generate_enemy_movement,
	check_game_condition.

n:- 
	/* command to move up */
	
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
	
	world(Prev_terain, Pos_row, Pos_col),
	world(New_terain, Pos_new, Pos_col),
	story_change_terains(Prev_terain, New_terain),
	
	generate_enemy_movement,
	check_game_condition.
	
e:- 
	/* command to move right */
	
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
	
	world(Prev_terain, Pos_row, Pos_col),
	world(New_terain, Pos_row, Pos_new),
	story_change_terains(Prev_terain, New_terain),
	
	generate_enemy_movement,
	check_game_condition.

s:- 
	/* command to move down */
	
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
	
	world(Prev_terain, Pos_row, Pos_col),
	world(New_terain, Pos_new, Pos_col),
	story_change_terains(Prev_terain, New_terain),
	
	generate_enemy_movement,
	check_game_condition.
