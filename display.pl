
/*** ====================        DISPLAY        ======================== ***/	
	
show_title:-
	/* Rules to show title */

	write('                                                                                                                                               '), nl,
	write('@@         @@@@       @@@@   @@@@    @@@@           @@      @@ @@@    @@ @@    @@ @@@    @@    @@@@    @@    @@    @@ @@@    @@   @@  @@@@@    '), nl,
	write('@@       @@    @@   @@    @@  @@   @@    @@         @@      @@ @@@@   @@ @@   @@  @@@@   @@  @@    @@  @@    @@    @@ @@@@   @@  @@  @@   @@   '), nl,
	write('@@      @@      @@ @@         @@  @@                @@      @@ @@ @@  @@ @@  @@   @@ @@  @@ @@      @@ @@    @@    @@ @@ @@  @@       @@       '), nl,
	write('@@      @@      @@ @@    @@@  @@  @@                @@      @@ @@  @@ @@ @@@@@@   @@  @@ @@ @@      @@  @@  @@@@  @@  @@  @@ @@         @@     '), nl,
	write('@@       @@    @@   @@    @@  @@   @@    @@          @@    @@  @@   @@@@ @@   @@  @@   @@@@  @@    @@    @@@@  @@@@   @@   @@@@      @@   @@   '), nl,
	write('@@@@@@@    @@@@       @@@@   @@@@    @@@@              @@@@    @@    @@@ @@    @@ @@    @@@    @@@@       @@    @@    @@    @@@       @@@@@    '), nl,
	write('                                                                                                                                               '), nl,
	write('@@@@@@@     @@@    @@@@@@@@ @@@@@@@@ @@      @@@@@@@      @@@@     @@@@@@@        @@@@      @@      @@   @@@    @@   @@@@@@     @@@@@          '), nl,
	write('@@    @@  @@   @@     @@       @@    @@      @@        @@     @@   @@    @@     @@    @@    @@      @@   @@@@   @@   @@    @@  @@   @@         '), nl,
	write('@@@@@@@@ @@     @@    @@       @@    @@      @@@@@@@   @@          @@    @@    @@      @@   @@      @@   @@ @@  @@   @@     @@  @@             '), nl,
	write('@@    @@ @@@@@@@@@    @@       @@    @@      @@        @@    @@@   @@@@@@@     @@      @@   @@      @@   @@  @@ @@   @@     @@    @@           '), nl,
	write('@@    @@ @@     @@    @@       @@    @@      @@         @@    @@   @@    @@     @@    @@     @@    @@    @@   @@@@   @@    @@  @@   @@         '), nl,
	write('@@@@@@@  @@     @@    @@       @@    @@@@@@@ @@@@@@@      @@@@     @@     @@      @@@@         @@@@      @@    @@@   @@@@@@     @@@@@          '), nl,
	write('                                                                                                                                               '), nl,nl,nl.


show_inventory:-
	player_inventory(Inventory),
	print_inventory(Inventory).

manual:-
	/* manual can't be called if game hasn't been started */
	
	game_running(false),
	write('How about calling init. to start the game ? :) '),nl,nl,!.

manual:-
	/* Rules to show help */

	nl,nl,
	write('Opening manual book....'), nl,nl,
	write('Objective : Elminate all but yourself'), nl,nl,
	write('Available actions :'), nl,
	write('save(filename).    | Create save data of your current game'), nl,
	write('load(filename).    | Load save data from your previous game'), nl,
	write('manual.            | Cmon, you should know by now...'), nl,nl,

	write('look.              | Take a look at surounding ~ '), nl,
	write('n. s. e. w.        | Move one step toward the future '), nl,
	write('map.               | Display full map (only if you have radar though...'), nl,nl,

	write('take(object).      | Pick a(n) item from ground'), nl,
	write('drop(object).      | Drop a(n) item to the ground'), nl,
	write('use(object).       | Consume a(n) item'), nl,

	write('attack.            | Attack an enemy nearby'), nl,
	write('status.            | Display current status'), nl,nl,

	write('Map\'s legends:'),nl,
	write('M = medicine'),nl,
	write('F = food'),nl,
	write('W = water'),nl,
	write('# = weapon'),nl,
	write('P = you'),nl,
	write('- = accessible'),nl,
	write('X = inaccessible'),nl.


map:-
	/*print whole map start from row 1 col 1 */
	player_inventory(OldInventory),
	schObj(OldInventory, radar, D), /* Check if radar is available */
	D == 1, !,
	
	write('bip...'), nl, sleep(0.5),
	write('bip...'), nl, sleep(0.4),
	write('bip...'), nl, sleep(0.3),
	write('bip...'), nl, sleep(0.25),
	write('bip...'), nl, sleep(0.2),
	write('bip...'), nl, sleep(0.15),
	write('bip...'), nl, sleep(0.5),nl,nl,
	write('scan success :) '), nl,nl,
	
	nl, print_whole_map(1, 1). 
	
map:-
	/*print whole map start from row 1 col 1 */
	player_inventory(OldInventory),
	schObj(OldInventory, radar, D), /* Check if radar is available */
	D \== 1, !,nl,
	write('I need to find a radar to use...'),nl,nl.
	
look:-
	/* Rules to look surounding */
	
	player_pos(Row, Col),
	Col1 is Col - 1, Row1 is Row - 1, print_map_symbol(Row1,Col1),
	Col2 is Col + 0, Row2 is Row - 1, print_map_symbol(Row2,Col2),
	Col3 is Col + 1, Row3 is Row - 1, print_map_symbol(Row3,Col3),
	nl,
	Col4 is Col - 1, Row4 is Row + 0, print_map_symbol(Row4,Col4),
	print_map_symbol(Row, Col),
	Col6 is Col + 1, Row6 is Row + 0, print_map_symbol(Row6,Col6),
	nl,
	Col7 is Col - 1, Row7 is Row + 1, print_map_symbol(Row7,Col7),
	Col8 is Col + 0, Row8 is Row + 1, print_map_symbol(Row8,Col8),
	Col9 is Col + 1, Row9 is Row + 1, print_map_symbol(Row9,Col9),
	
	nl,nl,nl,
	write('You search for items around you, and apparantly you found '),
	\+ show_item_below_you(Row, Col),
	write(' that\'s all... ').
	
show_item_below_you(Row, Col):-
	
	\+ item_on_map(_, Row, Col),
	format("nothing but your fear. ",[]),!.
	
show_item_below_you(Row, Col):-
	
	item_on_map(Item_name, Row, Col),
	format("a(n) ~p, ",[Item_name]), fail.
	
	
status:-
	/* Command to show player's status */
	
	player_health(Health), 
	player_hunger(Hunger), 
	player_thirst(Thirst), 
	player_pos(Pos_x, Pos_y),
	player_weapon(Weapon),	


	write('+========================+'), nl,
	write('|        STATUS          |'), nl,
	write('+========================+'), nl,
	format(" Health       : ~p~n",[Health]),
	format(" Hunger       : ~p~n",[Hunger]), 
	format(" Thirst       : ~p~n",[Thirst]), 
	format(" Weapon       : ~p~n",[Weapon]), 
	format(" Position     : <~p,~p> ~n",[Pos_x, Pos_y]),
	write(' Inventory    : '),nl, show_inventory.

	
	
/**~~~~~~~~~~~~~~~~~ Displaying map ~~~~~~~~~~~~~~~~~**/


print_map_symbol(Row, Col):-
	/* Printing enemy  as symbol */
	enemy_on_map(_,Row,Col),!,
	format('  <!>  ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing medicine  as symbol */
	item_on_map(Item,Row,Col),
	medicine(Item),!,
	format(' - M - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing food  as symbol */
	item_on_map(Item,Row,Col),
	food(Item),!,
	format(' - F - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing water (drink) as symbol */
	item_on_map(Item,Row,Col),
	water(Item),!,
	format(' - D - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing weapon  as symbol */
	item_on_map(Item,Row,Col),
	weapon(Item),!,
	format(' - W - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing other  as symbol */
	item_on_map(Item,Row,Col),
	other(Item),!,
	format(' - ? - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing special item as symbol */
	item_on_map(Item,Row,Col),
	special(Item),!,
	format(' - ? - ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing your location as symbol */
	player_pos(Pos_y, Pos_x),
	Row == Pos_y,
	Col == Pos_x,!,
	format('  you  ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing border as symbol */
	world(border, Row, Col),!,
	format('  -#-  ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing plain map as symbol */
	world(plain, Row, Col),!,
	format('  ___  ',[]).
	
print_map_symbol(Row, Col):-
	/* Printing map elemetn as symbol */
	world(Type, Row, Col),!,
	format(" ~p ",[Type]).
	

print_whole_map(Row, Col):-
	/* Printing whole map recursively , basis */

	world_width(WD),
	world_height(WH),
	Row == WH, 
	Col == WD, !,
	print_map_symbol(Row, Col),
	!.

print_whole_map(Row, Col):-
	/* Printing whole map recursively , if its still on same row */

	world_width(WD),
	print_map_symbol(Row,Col),
	
	Col < WD,
	New_col is Col + 1, !,
	print_whole_map(Row, New_col).
	
print_whole_map(Row, Col):-
	/* Printing whole map recursively , if it's on last column */

	world_width(WD),
	
	Col == WD, nl, nl,
	New_row is Row + 1, !,
	print_whole_map(New_row, 1).