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
	write('cant move there\n'),nl,
	generate_enemy_movement.
	
w:- 
	/* command to move left */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col - 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_row,Pos_new)),
	generate_enemy_movement.

n:- 
	/* command to move up */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row - 1,
	world(border, Pos_new, Pos_col),!,
	write('cant move there\n'),nl,
	generate_enemy_movement.

n:- 
	/* command to move up */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row - 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_new,Pos_col)),
	generate_enemy_movement.
	
e:- 
	/* command to move right */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col + 1,
	world(border, Pos_row, Pos_new),!,
	write('cant move there\n'),nl,
	generate_enemy_movement.
 
e:- 
	/* command to move right */
	 
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_col + 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_row,Pos_new)),
	generate_enemy_movement.

s:- 
	/* command to move down */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row + 1,
	world(border, Pos_new, Pos_col),!,
	write('cant move there\n'),nl,
	generate_enemy_movement.
	
s:- 
	/* command to move down */
	
	player_pos(Pos_row, Pos_col),
	Pos_new is Pos_row + 1,
	retract(player_pos(Pos_row,Pos_col)),
	asserta(player_pos(Pos_new,Pos_col)),
	generate_enemy_movement.
