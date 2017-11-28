
/*** ====================        SAVE AND LOAD       ======================== ***/

load_game(Filename):-
	/* Function to load file */
	
	open(Filename, read, Stream),

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
	
	/* Read player data */
	read(Stream, New_Health), 	 
	read(Stream, New_Hunger), 	 
	read(Stream, New_Thirst), 	 
	read(Stream, New_Pos_x), 	
	read(Stream, New_Pos_y),	
	read(Stream, New_Weapon),	
	read(Stream, New_Inventory), 
	
	asserta(player_health(New_Health)),
	asserta(player_hunger(New_Hunger)),
	asserta(player_thirst(New_Thirst)),
	asserta(player_pos(New_Pos_x, New_Pos_y)),
	asserta(player_weapon(New_Weapon)),
	asserta(player_inventory(New_Inventory)),
	
	map_items(Map_items),
	enemies(Enemies),

	retract(map_items(Map_items)),
	retract(enemies(Enemies)),
	
	/* Read map data */
	read(Stream, New_Map_items),		
	read(Stream, New_Enemies),			

	asserta(map_items(New_Map_items)),
	asserta(enemies(New_Enemies)),
	
	write('Data successfully loaded !'), nl,
	close(Stream).

	

save_game(Filename):-
	/* Function to save file */
	
	open(Filename, write, Stream),

	/* Gathering data */
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y), 
	player_weapon(Weapon),
	player_inventory(Inventory),
	
	map_items(Map_items),
	enemies(Enemies),

	/* Write player data */
	write(Stream, Health), 			write(Stream, '.'), nl(Stream),
	write(Stream, Hunger), 			write(Stream, '.'), nl(Stream),
	write(Stream, Thirst), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_x), 			write(Stream, '.'), nl(Stream),
	write(Stream, Pos_y), 			write(Stream, '.'), nl(Stream),
	write(Stream, Weapon), 			write(Stream, '.'), nl(Stream),
	write(Stream, Inventory), 		write(Stream, '.'), nl(Stream),
	
	/* Write map data */
	write(Stream, Map_items), 		write(Stream, '.'), nl(Stream),
	write(Stream, Enemies), 		write(Stream, '.'), nl(Stream),
	
	write('Save data successfully created !'), nl,
	close(Stream).
	