/*** ====================       CHANGE INVENTORY       ======================== ***/

addObj([], C, [C]):-
	!.
	
addObj([A|B], C, [A|D]) :- addObj(B, C, D).

delObj([], _, []) :- !.
delObj([A|B], C, B) :- C == A, !.
delObj([A|B], C, [A|D]) :- C \== A, delObj(B, C, D).

schObj([], _, 0) :- !.
schObj([A|_], C, X) :- A == C, !, X is 1.
schObj([A|B], C, X) :- A \== C, schObj(B, C, X).	

print_inventory(Inventory):-
	Inventory = [], !.

print_inventory(Inventory):-
	[Head|Tail] = Inventory,
	format(" -  ~p \n", [Head]),
	print_inventory(Tail).