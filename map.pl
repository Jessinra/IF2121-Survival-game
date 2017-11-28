
/*** ==============================       MAP     ================================== ***/

/** ~~~~~~~~~~~~~~~~~~~~             declaration of constants              ~~~~~~~~~~~~~~~~~~~~~~~~~**/

world_width(25).
world_height(15).



/** ~~~~~~~~~~~~~~~~~~~~             initializing              ~~~~~~~~~~~~~~~~~~~~~~~~~**/

init_world:-
	/* Rules to generate plain map */

	world_height(WH),
	init_world_row(WH),
	create_border, create_woods, create_mount,
	create_river, create_swamp, create_caves.
	


init_world_row(Row):-
	/* initialize plain world by row : basis */
	
	Row == 0, !.
	
init_world_row(Row):-
	/* initialize plain world by row : recursive */
	
	world_width(WD),
	create_plain_world(Row, 1, WD),!,
	New_row is Row -1, 
	init_world_row(New_row).

	

create_plain_world(_,_,Span):-
	/* initialize all map : basis */

	Span == 0, !.
	
create_plain_world(Row, Col, Span):-
	/* initialize all map : recursive */

	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,
	
	New_row is Row,
	New_col is Col + 1,
	New_span is Span - 1,
	asserta(world(plain, Row, Col)),!,

	create_plain_world(New_row, New_col, New_span),!.	
	


	
/** ~~~~~~~~~~~~~~~~~~~~             Create custom world : general rules             ~~~~~~~~~~~~~~~~~~~~~~~~~**/

create_world(_,_,_,Span,_):-
	/* Rulse to create custom world : basis */

	Span == 0, !.
	
create_world(_, Row, _, _, _):-
	/* Rulse to create custom world : invalid row */
	
	world_height(WH), Row > WH,
	write('The world is inbalanced,... dimensional overflow !'),nl.
	
create_world(_, _, Col, _, _):-
	/* Rulse to create custom world : invalid col */
	
	world_width(WD), Col > WD,
	write('The world is inbalanced,... dimensional overflow !'),nl.
	
create_world(Type, Row, Col, Span, Is_row):-
	/* Rulse to create custom world : recursive col */
	
	/*
	type : what kind of terain
	row : starting row
	col : starting col
	span : how many tiles spanning
	is_row : span to which direction ? true -> span row -> downward | false -> span col -> rightward 
	*/

	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,
	
	\+ Is_row,
	New_row is Row,
	New_col is Col + 1,
	New_span is Span - 1,
	
	world(C_Type, Row, Col),
	retract(world(C_Type, Row, Col)),
	asserta(world(Type, Row, Col)),!,
	
	create_world(Type, New_row, New_col, New_span, Is_row),!.
	
create_world(Type, Row, Col, Span, Is_row):-
	/* Rulse to create custom world : recursive row */
	
	/*
	type : what kind of terain
	row : starting row
	col : starting col
	span : how many tiles spanning
	is_row : span to which direction ? true -> span row -> downward | false -> span col -> rightward 
	*/
	
	world_height(WH), Row =< WH,
	world_width(WD), Col =< WD,

	Is_row,
	New_row is Row + 1,
	New_col is Col,
	New_span is Span - 1,
	
	world(C_Type, Row, Col),
	retract(world(C_Type, Row, Col)),
	asserta(world(Type, Row, Col)),!,
	
	create_world(Type, New_row, New_col, New_span, Is_row),!.
	


/** ~~~~~~~~~~~~~~~~~~~~             Create custom world : specific terain rules             ~~~~~~~~~~~~~~~~~~~~~~~~~**/

create_border:-
	/* Create border-type terain on map */
	
	world_width(WD),
	world_height(WH),
	create_world(border, 1,1,WD,false),
	create_world(border, 1,1,WH,true),
	create_world(border, WH,1,WD,false),
	create_world(border, 1,WD,WH,true).
	
	
create_woods:-
	/* Create woods-type terain on map */
	
	create_world(woods, 2, 2, 6,false),
	create_world(woods, 3, 2, 5,false),
	create_world(woods, 4, 2, 3,false),
	create_world(woods, 5, 4, 3,false),
	
	create_world(woods, 7, 18, 3,false),
	create_world(woods, 8, 16, 5,false),
	create_world(woods, 9, 15, 3,false),
	create_world(woods, 10, 14, 6,false),
	create_world(woods, 11, 17, 4,false),
	create_world(woods, 12, 18, 3,false).
	
	
create_mount:-
	/* Create mount-type terain on map */
	
	create_world(mount, 14, 2, 2,false),
	create_world(mount, 14, 6, 2,false),
	create_world(mount, 13, 3, 4,false),
	create_world(mount, 12, 4, 4,false),
	create_world(mount, 11, 4, 3,false),
	create_world(mount, 10, 3, 2,false).
	
create_river:-
	/* Create river-type terain on map */
	
	create_world(river, 2, 12, 3,true),
	create_world(river, 5, 11, 2,false),
	create_world(river, 6, 11, 1,false),
	create_world(river, 7, 11, 1,false),
	create_world(river, 8, 12, 3,true),
	create_world(river, 11, 11, 1,false),
	create_world(river, 12, 12, 2,false),
	create_world(river, 13, 13, 2,false),
	create_world(river, 14, 14, 1,false).
	
create_caves:-
	/* Create caves-type terain on map */
	
	create_world(caves, 2, 21, 1,true),
	create_world(caves, 2, 22, 2,true),
	create_world(caves, 2, 23, 4,true),
	create_world(caves, 12, 22, 3,true),
	create_world(caves, 10, 23, 5,true),
	create_world(caves, 2, 24, 13,true).
	
	
create_swamp:-
	/* Create swamp-type terain on map */

	create_world(swamp, 3, 13, 3,true),
	create_world(swamp, 3, 14, 2,false),
	create_world(swamp, 4, 14, 3,false),
	create_world(swamp, 5, 15, 1,false).
	
	