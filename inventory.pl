
/*** ====================       CHANGE INVENTORY       ======================== ***/

addObj([], C, [C]) :- !.
	/* Add object to list : basis */

addObj([A|B], C, [A|D]) :- addObj(B, C, D).
	/* Add object to list : recrsive */

delObj([], _, []) :- !.
	/* Del object from list : basis */

delObj([A|B], C, B) :- C == A, !.
	/* Del object from list : recursive - found */

delObj([A|B], C, [A|D]) :- C \== A, delObj(B, C, D).
	/* Del object from list : recursive - not found */

schObj([], _, 0) :- !.
	/* Search for object in list : basis */

schObj([A|_], C, X) :- A == C, !, X is 1.
	/* Search for object in list : found */

schObj([A|B], C, X) :- A \== C, schObj(B, C, X).	
	/* Search for object in list : recursive */

print_inventory(Inventory):-
	/* Show object in list : basis */
	Inventory = [], !.

print_inventory(Inventory):-
	/* Show object in list : recursive */

	[Head|Tail] = Inventory,
	format(" -  ~p \n", [Head]),
	print_inventory(Tail).
	
inv_count([], X) :- X is 0, !.
	/* Count object in list : basis */

inv_count([_|B], X) :- inv_count(B, Y), X is Y + 1.
	/* Count object in list : recursive */
