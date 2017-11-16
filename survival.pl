
init:-
	show_title,
	main_read,
	main_write.
	
	

/*** ====================        SAVE AND LOAD       ======================== ***/

main_read:-
	/* Function to load file */
	
	open('cache.txt', read, Stream),

	/* Read player data */
	read(Stream, Health), 	 
	read(Stream, Hunger), 	 
	read(Stream, Thirst), 	 
	read(Stream, Pos_x), 	
	read(Stream, Pos_y),	 
	read(Stream, Inventory), 
	
	asserta(player_health(Health)),
	asserta(player_hunger(Hunger)),
	asserta(player_thirst(Thirst)),
	asserta(player_pos(Pos_x, Pos_y)),
	asserta(player_inventory(Inventory)),
	
	
	/* Read map data */
	read(Stream, Map_width),    	
    read(Stream, Map_length),	
	read(Stream, Map_items),		
	read(Stream, Enemies),			
	read(Stream, Special_terains),	

	asserta(map_width(Map_width)),
	asserta(map_length(Map_length)),
	asserta(map_items(Map_items)),
	asserta(enemies(Enemies)),
	asserta(special_terains(Special_terains)),
	
	close(Stream).

	
main_write:-
	/* Function to save file */
	
	open('cache.txt', write, Stream),

	/* Gathering data */
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y), 
	player_inventory(Inventory),
	
	map_width(Map_width), 
	map_length(Map_length), 
	map_items(Map_items),
	enemies(Enemies),
	special_terains(Special_terains),

	/* Write player data */
	write(Stream, Health), 			write(Stream, '.'), nl(Stream),
	write(Stream, Hunger), 			write(Stream, '.'), nl(Stream),
	write(Stream, Thirst), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_x), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_y), 			write(Stream, '.'), nl(Stream),
	write(Stream, Inventory), 		write(Stream, '.'), nl(Stream),
	
	/* Write map data */
	write(Stream, Map_width),		write(Stream, '.'), nl(Stream),
	write(Stream, Map_length), 		write(Stream, '.'), nl(Stream),
	write(Stream, Map_items), 		write(Stream, '.'), nl(Stream),
	write(Stream, Enemies), 		write(Stream, '.'), nl(Stream),
	write(Stream, Special_terains), write(Stream, '.'), nl(Stream),

	close(Stream).


	

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

	
modify_inventory:- !.
	
modify_map_items:- !.

modify_enemies:- !.
	
	
	
/*** ====================        DISPLAY        ======================== ***/	
	
show_title:-
	/* Rules to show title */

	write('_______________________________________________________________________________________________________________________________________________'), nl,
	write('00_________0000_______0000___0000____0000___________00______00_000____00_00____00_000____00____0000____00____00____00_000____00___00__00000____'), nl,
	write('00_______00____00___00____00__00___00____00_________00______00_0000___00_00___00__0000___00__00____00__00____00____00_0000___00__00__00___00___'), nl,
	write('00______00______00_00_________00__00________________00______00_00_00__00_00__00___00_00__00_00______00_00____00____00_00_00__00_______00_______'), nl,
	write('00______00______00_00____000__00__00________________00______00_00__00_00_000000___00__00_00_00______00__00__0000__00__00__00_00_________00_____'), nl,
	write('00_______00____00___00____00__00___00____00__________00____00__00___0000_00___00__00___0000__00____00____0000__0000___00___0000______00___00___'), nl,
	write('0000000____0000_______0000___0000____0000______________0000____00____000_00____00_00____000____0000_______00____00____00____000_______00000____'), nl,
	write('_______________________________________________________________________________________________________________________________________________'), nl,
	write('0000000_____000____00000000_00000000_00______0000000______0000_____0000000________0000______00______00___000____00___000000_____00000__________'), nl,
	write('00____00__00___00_____00_______00____00______00________00_____00___00____00_____00____00____00______00___0000___00___00____00__00___00________ '), nl,
	write('00000000_00_____00____00_______00____00______0000000___00__________00____00____00______00___00______00___00_00__00___00_____00__00_____________'), nl,
	write('00____00_000000000____00_______00____00______00________00____000___0000000_____00______00___00______00___00__00_00___00_____00____00___________'), nl,
	write('00____00_00_____00____00_______00____00______00_________00____00___00____00_____00____00_____00____00____00___0000___00____00__00___00_________'), nl,
	write('0000000__00_____00____00_______00____0000000_0000000______0000_____00_____00______0000_________0000______00____000___000000_____00000__________'), nl,
	write('_______________________________________________________________________________________________________________________________________________').

show_message:-
	!.

show_help:-
	!.
	
/*** ====================       STORAGE       ======================== ***/

printl(List):-
	[Head|Tail] = List,
	write(Head), write(Tail).

printall(Data):-
	Data = [], !.

printall(Data):-
	[Head|Tail] = Data,
	write(Head),write(' '),
	printall(Tail).
