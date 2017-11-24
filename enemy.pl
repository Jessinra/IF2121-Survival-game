/*** ====================        ENEMIES         ======================== ***/



set_enemies:- 
	amount(enemy, E_min, E_max),
	randomize,random(E_min, E_max, Enemy_count),
	random_enemies(Enemy_count,_).
	
random_enemies(0,_) :- !. /* berubah */
random_enemies(Count,List_result) :- /* berubah */
	/* generate random enemies */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	randomize,random(2,WH1, Enemy_row),
	randomize,random(2,WD1, Enemy_col),
	
	player_pos(Player_row,Player_col),	
	sama(Enemy_row,Player_row,S1),
	sama(Player_col,Enemy_col,S2), 
	#\(#/\(S1,S2)),!,
	
	amount(enemy_atk, EA_min, EA_max),
	randomize,random(EA_min, EA_max, Enemy_atk),
	addObj(List_result,[Enemy_atk,Enemy_row,Enemy_col],List_result1),
	modify_enemies(List_result1),
	
	Count1 is Count-1,
	random_enemies(Count1, List_result1).

random_enemies(Count,List_result) :- /* berubah */
	/* generate random enemies */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	randomize,random(2,WH1, Enemy_row),
	randomize,random(2,WD1, Enemy_col),
	player_pos(Player_row,Player_col),	
	sama(Enemy_row,Player_row,S1),
	sama(Player_col,Enemy_col,S2), 
	#/\(S1,S2),!,
	
	random_enemies(Count, List_result).	

sama(X,Y,Z):- /* berubah */
	=:=(X,Y),
	Z is 1.
sama(X,Y,Z):- /* berubah */
	\==(X,Y),
	Z is 0.
	
	
init_enemy_on_map:-
	enemies(Enemies),
	set_enemy_on_map(Enemies).

set_enemy_on_map(Enemies):-
	Enemies == [], !.

set_enemy_on_map(Enemies):-
	[Head|Tail] = Enemies,
	[Atk, Row, Col] = Head,
	
	asserta(enemy_on_map(Atk, Row, Col)),
	set_enemy_on_map(Tail).
	
/* Note : random 1 - 6, this make sure enemy only has 66.66% chance to move */

generate_enemy_movement:-

	enemy_on_map(EAtk,Pos_row,Pos_col),
	attackenemy(EAtk, Pos_row, Pos_col),fail.
	
generate_enemy_movement:-

	enemy_on_map(EAtk,Pos_row,Pos_col),
	randomize,random(1,6,M),
	moveenemy(M, EAtk, Pos_row, Pos_col),fail.
	
generate_enemy_movement:-
	!.
	
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy to right */
	
	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 1,!, 
	Pos_new is Pos_col+1,
	\+ world(border, Pos_row, Pos_new),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_row,Pos_new], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_row,Pos_new)).
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy to left */
	
	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 2,!,
	Pos_new is Pos_col-1,
	\+ world(border, Pos_row, Pos_new),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_row,Pos_new], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_row,Pos_new)).
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy down */

	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 3,!,
	Pos_new is Pos_row+1,
	\+ world(border, Pos_new, Pos_col),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_new,Pos_col], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_new,Pos_col)).
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy up */

	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 4,!,
	Pos_new is Pos_row - 1,
	\+ world(border, Pos_new, Pos_col),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_new,Pos_col], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_new,Pos_col)).
	
moveenemy(M, _, Pos_row, Pos_col):- 
	
	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 5,!.

moveenemy(M, _, Pos_row, Pos_col):- 

	player_pos(Player_row, Player_col),
	(Player_row \== Pos_row; Player_col \== Pos_col),!,
	M == 6,!.	
	

attackenemy(EAtk, Pos_row, Pos_col):-
	
	player_pos(Player_row, Player_col),
	Player_row == Pos_row,
	Player_col == Pos_col,!,
	
	modify_player_health(-EAtk),
	format("\nYou took ~p damages !!\n",[EAtk]),
	check_game_condition.	
	
	
	
	
	