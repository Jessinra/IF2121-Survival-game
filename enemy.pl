/*** ====================        ENEMIES         ======================== ***/



set_enemies([A1,B1,X1,Y1],C,D) :- 
	
	amount(enemy, E_min, E_max),
	
	random(E_min, E_max, Enemy_count),
	random_enemy([A1,B1,X1,Y1],C,Enemy_count,D).
	
random_enemy([],[],0,_) :- !.

random_enemy([B1,X1,Y1],C,E,D) :- 

	world_width(WD),
	world_height(WH),
	
	amount(enemy_atk, EA_min, EA_max),
	random(EA_min, EA_max, Enemy_atk), 
	random(1,WD,Enemy_row), 
	random(1,WH,Enemy_col), 
	
	player_pos(Player_row,Player_col), 
	(sublist([_,Enemy_row,Enemy_col],map_items(C)) #\/ ((Player_row==Enemy_row) #\/(Player_col==Enemy_col))) ->
	random_enemy([Enemy_atk,Enemy_row,Enemy_col],C,E,D); 
	append([Enemy_atk,Enemy_row,Enemy_col],C,D), 
	E1 is E-1, 
	random_enemy([Enemy_atk1,Enemy_row1,Enemy_col1],C,E1,D),
	modify_map_items(D).
	
	
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
	random(1,6,M),
	moveenemy(M, EAtk, Pos_row, Pos_col),fail.
	
generate_enemy_movement:-
	!.
	
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy to right */

	M == 1,!, 
	Pos_new is Pos_col+1,
	\+ world(border, Pos_row, Pos_new),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_row,Pos_new], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_row,Pos_new)),!.
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy to left */

	M == 2,!,
	Pos_new is Pos_col-1,
	\+ world(border, Pos_row, Pos_new),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_row,Pos_new], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_row,Pos_new)),!.
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy down */

	M == 3,!,
	Pos_new is Pos_row+1,
	\+ world(border, Pos_new, Pos_col),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_new,Pos_col], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_new,Pos_col)),!.
	
moveenemy(M, EAtk, Pos_row, Pos_col):- 
	/* Move enemy up */

	M == 4,!,
	Pos_new is Pos_row - 1,
	\+ world(border, Pos_new, Pos_col),
	
	enemies(Enemy_list),
	delObj(Enemy_list, [EAtk,Pos_row,Pos_col], Del_Enemy_list),
	addObj(Del_Enemy_list, [EAtk,Pos_new,Pos_col], New_Enemy_list),
	modify_enemies(New_Enemy_list),
	
	retract(enemy_on_map(EAtk,Pos_row,Pos_col)),
	asserta(enemy_on_map(EAtk,Pos_new,Pos_col)),!.
	
moveenemy(M, _, _):- 

	M == 5,!.

moveenemy(M, _, _):- 

	M == 6,!.	
	
	
	
	
	
	
	