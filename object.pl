
/*** ====================        OBJECT         ======================== ***/

set_object:-
	/* Rules to specify which category does specific items belong to */
	
	asserta(medicine(first_aid)),
	asserta(medicine(bandage)),
	asserta(medicine(pain_killer)),
	asserta(medicine(herbs)),
	asserta(medicine(stimulant)),
	
	asserta(food(canned_food)),
	asserta(food(fruits)),
	asserta(food(raw_meat)),
	asserta(food(mushrooms)),
	asserta(food(edible_plant)),
	
	asserta(water(bottled_water)),
	asserta(water(clean_water)),
	asserta(water(bottled_tea)),
	
	asserta(weapon(riffle)),
	asserta(weapon(long_sword)),
	asserta(weapon(bow_arrow)),
	asserta(weapon(long_bow)),
	asserta(weapon(spear)),

	/* Set object value as fact */

	asserta(other(cloth)),
	asserta(other(maps)),
	asserta(other(backpack)),
	asserta(other(pouch)),
	asserta(other(empty_bottle)),
	asserta(other(empty_can)),
	asserta(other(magic_wand)),
	asserta(other(stick)),
	
	asserta(special(radar)),
	asserta(special(barrier)),
	asserta(special(void_bomb)),

	asserta(stataddition(first_aid,20)), 
	asserta(stataddition(bandage,25)),
	asserta(stataddition(pain_killer,40)),
	asserta(stataddition(herbs,15)),
	asserta(stataddition(stimulant,25)),
	
	asserta(stataddition(canned_food,40)),
	asserta(stataddition(fruits,15)),
	asserta(stataddition(raw_meat,35)),
	asserta(stataddition(mushrooms,10)),
	asserta(stataddition(edible_plant,15)),
	
	asserta(stataddition(bottled_water,40)),
	asserta(stataddition(clean_water,60)),
	asserta(stataddition(bottled_tea,25)).

	



/**~~~~~~~~~~~~~~~~~~         initialize item into map        ~~~~~~~~~~~~~~~~~**/

init_item_on_map:-
	/* rules to call initialize item from save data */

	map_items(Items),
	set_item_on_map(Items).

set_item_on_map(Items):-
	/* set item into map : basis */

	Items == [], !.

set_item_on_map(Items):-
	/* set item into map : recursive */

	[Head|Tail] = Items,
	[Item_name, Row, Col] = Head,
	
	asserta(item_on_map(Item_name, Row, Col)),!,
	set_item_on_map(Tail).
	

random_object :- 
	/* initialize random function to all item, when started as new game */

	amount(medicine, M_min, M_max),
	randomize,random(M_min, M_max, M_count),
	random_object_medicine([],M_count ),
	
	map_items(Items_after_medicine),
	amount(food, F_min, F_max),
	randomize,random(F_min, F_max, F_count),
	random_object_food(Items_after_medicine,F_count ),
	
	map_items(Items_after_food), 
	amount(water, D_min, D_max),
	randomize,random(D_min, D_max, D_count),
	random_object_water(Items_after_food,D_count ),
	
	map_items(Items_after_water), 
	amount(weapon, W_min, W_max),
	randomize,random(W_min, W_max, W_count),
	random_object_weapon(Items_after_water,W_count ),
	
	map_items(Items_after_weapon),
	amount(special, S_min, S_max),
	randomize,random(S_min, S_max, S_count),
	random_object_special(Items_after_weapon,S_count ),
	
	map_items(Items_after_special), 
	amount(others, O_min, O_max),
	randomize,random(O_min, O_max, O_count),
	random_object_other(Items_after_special,O_count).
	

/* ----------      Medicine section          -------------*/

random_object_medicine(_,0) :- !. 
	/* generate random medicine : basis */ 
	
random_object_medicine(List_init,Count) :- 
	/* generate random medicine : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),	
	randomize,random(1,5,Type),
	random_object_name_medicine(Type,Item_name),
	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_medicine(List_result1, Count1).	

random_object_name_medicine(Type,Item_name) :-
	/* get random name for medicine */

	Type==1,!,
	Item_name=first_aid.

random_object_name_medicine(Type,Item_name) :-
	/* get random name for medicine */

	Type==2,!,
	Item_name=bandage.
	
random_object_name_medicine(Type,Item_name) :-
	/* get random name for medicine */

	Type==3,!,
	Item_name=pain_killer.
	
random_object_name_medicine(Type,Item_name) :-
	/* get random name for medicine */

	Type==4,!,
	Item_name=herbs.
	
random_object_name_medicine(Type,Item_name) :-
	/* get random name for medicine */

	Type==5,!,
	Item_name=stimulant.


/* ----------      Food section          -------------*/

random_object_food(_,0) :- !. 
	/* generate random food : basis */

random_object_food(List_init,Count) :- 
	/* generate random food : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),	
	randomize,random(1,5,Type),	
	random_object_name_food(Type,Item_name),

	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_food(List_result1, Count1).	

random_object_name_food(Type,Item_name) :-
	/* get random name for food */

	Type==1,!,
	Item_name=canned_food.

random_object_name_food(Type,Item_name) :-
	/* get random name for food */

	Type==2,!,
	Item_name=fruits.
	
random_object_name_food(Type,Item_name) :-
	/* get random name for food */

	Type==3,!,
	Item_name=raw_meat.
	
random_object_name_food(Type,Item_name) :-
	/* get random name for food */

	Type==4,!,
	Item_name=mushrooms.
	
random_object_name_food(Type,Item_name) :-
	/* get random name for food */

	Type==5,!,
	Item_name=edible_plant.
	

/* ----------      Drink (water) section          -------------*/

random_object_water(_,0) :- !. 
	/* generate random drink : basis */

random_object_water(List_init,Count) :- 
	/* generate random drink : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),	
	randomize,random(1,3,Type),	
	random_object_name_water(Type,Item_name),
	
	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_water(List_result1, Count1).	

random_object_name_water(Type,Item_name) :-
	/* get random name for drink */

	Type==1,!,
	Item_name=bottled_water.

random_object_name_water(Type,Item_name) :-
	/* get random name for drink */

	Type==2,!,
	Item_name=clean_water.
	
random_object_name_water(Type,Item_name) :-
	/* get random name for drink */

	Type==3,!,
	Item_name=bottled_tea.


/* ----------      Weapon section          -------------*/

random_object_weapon(_,0) :- !. 
	/* generate random weapon : basis */

random_object_weapon(List_init,Count) :- 
	/* generate random weapon : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),		
	randomize,random(1,5,Type),
	random_object_name_weapon(Type,Item_name),

	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_weapon(List_result1, Count1).	

random_object_name_weapon(Type,Item_name) :-
	/* get random name for weapon */

	Type==1,!,
	Item_name=riffle.

random_object_name_weapon(Type,Item_name) :-
	/* get random name for weapon */

	Type==2,!,
	Item_name=long_sword.
	
random_object_name_weapon(Type,Item_name) :-
	/* get random name for weapon */

	Type==3,!,
	Item_name=bow_arrow.
	
random_object_name_weapon(Type,Item_name) :-
	/* get random name for weapon */

	Type==4,!,
	Item_name=long_bow.
	
random_object_name_weapon(Type,Item_name) :-
	/* get random name for weapon */

	Type==5,!,
	Item_name=spear.


/* ----------      Other object section          -------------*/

random_object_other(_,0) :- !. 
	/* generate random other item : basis */

random_object_other(List_init,Count) :- 
	/* generate random other item : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),	
	randomize,random(1,8,Type),
	random_object_name_other(Type,Item_name),

	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_other(List_result1, Count1).	
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==1,!,
	Item_name=cloth.

random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==2,!,
	Item_name=maps.
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==3,!,
	Item_name=backpack.
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==4,!,
	Item_name=pouch.
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==5,!,
	Item_name=empty_bottle.

random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==6,!,
	Item_name=empty_can.
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==7,!,
	Item_name=magic_wand.
	
random_object_name_other(Type,Item_name) :-
	/* get random name for other item */

	Type==8,!,
	Item_name=stick.


/* ----------      Special object section          -------------*/

random_object_special(_,0) :- !. 
	/* generate random special item : basis */

random_object_special(List_init,Count) :- 
	/* generate random special item : recursive */

	world_width(WD),
	world_height(WH),
	WD1 is WD - 1,
	WH1 is WH - 1,
	
	randomize,random(2,WH1, Item_row),
	randomize,random(2,WD1, Item_col),	
	randomize,random(1,3,Type),	
	random_object_name_special(Type,Item_name),

	addObj(List_init,[Item_name,Item_row,Item_col],List_result1),
	modify_map_items(List_result1),!,
	
	Count1 is Count-1,
	random_object_special(List_result1, Count1).	

random_object_name_special(Type,Item_name) :-
	/* get random name for special item */

	Type==1,!,
	Item_name=radar.

random_object_name_special(Type,Item_name) :-
	/* get random name for special item */

	Type==2,!,
	Item_name=barrier.
	
random_object_name_special(Type,Item_name) :-
	/* get random name for special item */

	Type==3,!,
	Item_name=void_bomb.	
	
	





/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       take item       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~**/ 	
	
take(Object) :- 
	/* rules to take a(n) object from map into inventory : found, not full inventory */
	
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),
	amount(inventory, _, Max_inventory),

	/* Check if an object exist in player's current posititon */
	schObj(Oldmapitems, [Object,A,B], D), 
	D == 1,

	/* inventory's not full */
	inv_count(OldInventory, X), X < Max_inventory,
	
	addObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	
	delObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	
	retract(item_on_map(Object,A,B)),
	
	format("~p has been taken from this area.", [Object]),!, 
	generate_enemy_movement,!.
	
take(Object) :- 
	/* rules to take a(n) object from map into inventory : found, full inventory */
	
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),
	amount(inventory, _, Max_inventory),

	/* Check if an object exist in player's current posititon */
	schObj(Oldmapitems, [Object,A,B], D), 
	D == 1,
	
	/* inventory is full */
	inv_count(OldInventory, X), X == Max_inventory,!,
	write('Your inventory is full!.'), !.

take(Object) :- 
	/* rules to take a(n) object from map into inventory : not found */
	
	player_pos(A,B),
	map_items(Oldmapitems),

	/* Check if an object exist in player's current posititon */
	schObj(Oldmapitems, [Object,A,B], D),
	D \== 1, !,
	
	format("~p was not found in this area.", [Object]), !,
	generate_enemy_movement,!.
	





/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       drop item       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~**/ 	

drop(Object) :- 
	/* rule to drop a(n) object to map  : found */
	
	player_pos(A,B),
	map_items(Oldmapitems),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D), 
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	
	addObj(Oldmapitems, [Object,A,B], NewMapItems),
	modify_map_items(NewMapItems),
	
	asserta(item_on_map(Object, A, B)),
	
	format("You dropped ~p in this area.", [Object]), !,
	generate_enemy_movement,!.
	
drop(Object) :- 
	/* rule to drop a(n) object to map  : not found */
	
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D), 
	D \== 1, !,
	
	format("You don't have ~p in your inventory.", [Object]),!,
	generate_enemy_movement,!.






/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       use item       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~**/ 	

use(_) :-
	/* rule to use object : player holding weapon */

	\+player_weapon(bare_hands),!,
	write('My hand\'s full, maybe I should store my weapon first'),nl.


use(Object) :-
	/* rule to use object : Food - Full */

	player_weapon(bare_hands),
	food(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	player_hunger(Hunger),
	amount(player_hunger, _, Max_hunger),
	Hunger > Max_hunger, !,
	write('You are already full!'),!,
	generate_enemy_movement,!.
	

use(Object) :-
	/* rule to use object : Food - general state */

	player_weapon(bare_hands),
	food(Object),
	player_inventory(OldInventory),
	schObj(OldInventory, Object, D),

	/* Check if object exist in inventory */
	D == 1,
	stataddition(Object, Addition),
	
	player_hunger(Hunger),
	amount(player_hunger, _, Max_hunger),
	Hunger + Addition =< Max_hunger, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_hunger(Addition), 
	format("You ate the ~p. ", [Object]),
	format("Your hunger raised by ~p. ", [Addition]),!,
	generate_enemy_movement,!.


use(Object) :-
	/* rule to use object : Food - almost full */

	player_weapon(bare_hands),
	food(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	stataddition(Object, Addition),
	player_hunger(Hunger),
	amount(player_hunger, _, Max_hunger),
	Hunger + Addition > Max_hunger, !,

	MinAdd is Max_hunger - Hunger,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_hunger(MinAdd), 
	format("You ate the ~p. ", [Object]),
	format("Your hunger raised by ~p. ", [MinAdd]),!,
	generate_enemy_movement,!.


use(Object) :-
	/* rule to use object : Medicine - Full */

	player_weapon(bare_hands),
	medicine(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	amount(player_hp, _, Max_hp),
	player_health(Health),
	Health >= Max_hp, !,
	write('You are healthy already!'),!,
	generate_enemy_movement,!.

	
use(Object) :-
	/* rule to use object : Medicine - general state */

	player_weapon(bare_hands),
	medicine(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	stataddition(Object, Addition),
	player_health(Health),
	amount(player_hp, _, Max_hp),
	Health + Addition =< Max_hp, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_health(Addition), 
	format("You used ~p. ", [Object]),
	format("Your health raised by ~p. ", [Addition]),!,
	generate_enemy_movement,!.

	
use(Object) :-
	/* rule to use object : Medicine - almost full  */

	player_weapon(bare_hands),
	medicine(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	stataddition(Object, Addition),
	player_health(Health),
	amount(player_hp, _, Max_hp),
	Health + Addition > Max_hp, !,
	
	MinAdd is Max_hp - Health,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_health(MinAdd), 
	format("You used ~p. ", [Object]),
	format("Your health raised by ~p. ", [MinAdd]),!,
	generate_enemy_movement,!.

	
use(Object) :-
	/* rule to use object : Drink - Full */

	water(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	player_thirst(Thirst),
	amount(player_thirst, _, Max_thirst),
	Thirst >= Max_thirst, 
	write('You are not thirsty.'), !,
	generate_enemy_movement,!.


use(Object) :-
	/* rule to use object : Drink - general state */

	water(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	stataddition(Object, Addition),
	player_thirst(Thirst),
	amount(player_thirst, _, Max_thirst),

	Thirst + Addition =< Max_thirst, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_thirst(Addition), 
	format("You drank ~p. ", [Object]),
	format("Your thirst raised by ~p. ", [Addition]),
	generate_enemy_movement,!.


use(Object) :-
	/* rule to use object : Drink - almost full */

	water(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1,
	
	stataddition(Object, Addition),
	player_thirst(Thirst),
	amount(player_thirst, _, Max_thirst),
	Thirst + Addition >= Max_thirst, !,
	
	MinAdd is Max_thirst - Thirst,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_thirst(MinAdd), 
	format("You drank ~p. ", [Object]),
	format("Your thirst raised by ~p. ", [MinAdd]),
	generate_enemy_movement,!.


use(Object) :-
	/* rule to use object : weapon */

	weapon(Object),
	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D == 1, !,
	
	delObj(OldInventory, Object, NewInventory),
	modify_inventory(NewInventory),
	modify_player_weapon(Object),
	format("You wield ~p right now.", [Object]),!,
	generate_enemy_movement,!.
	

use(Object) :-
	/* rule to use object : item not found */

	player_inventory(OldInventory),

	/* Check if object exist in inventory */
	schObj(OldInventory, Object, D),
	D \== 1, !,
	
	format("Sadly you don't have ~p in your inventory.", [Object]),!,
	generate_enemy_movement,!.







/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~               store                  ~~~~~~~~~~~~~~~~~~~~~~~~~~**/

store:-
	/* Used to store current weapon into inventory */

	player_weapon(Current_weapon),
	player_inventory(OldInventory),

	addObj(OldInventory, Current_weapon, NewInventory),
	modify_inventory(NewInventory),
	modify_player_weapon(bare_hands),
	format("You stored your ~p, let's hope the best..", [Current_weapon]),!,
	generate_enemy_movement,!.







/** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~               void bomb section                  ~~~~~~~~~~~~~~~~~~~~~~~~~~**/
	
void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 0,!,
	
	write('What are you trying to do ? '),nl,!,
	generate_enemy_movement,!.
	

void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 1,
	
	write('A R E   Y O U   S U R E  ???'),nl,
	write(' <yes / no> : '), read(Input), Input == yes,!,
	
	\+ activate_bomb,!,
	delObj(OldInventory, void_bomb, NewInventory),
	modify_inventory(NewInventory),
	
	write('BOOOMMM !!!!..'), nl, sleep(1),
	write('..'), nl, sleep(1),
	write('..'), nl, sleep(1),
	write('You opened your eyes slowly, and you realized suddenly everything\'s gone...'),!,
	generate_enemy_movement,!.
	

void_bomb:-
	/* Rule to use void_bomb, remove all enemy around player */

	player_inventory(OldInventory),
	schObj(OldInventory, void_bomb, D), D == 1,
	
	write('Good choice,... better save it for later use...'),!,
	generate_enemy_movement,!.


activate_bomb:-
	/* Rule to activate void bomb, remove enemies */

	player_pos(Row, Col),
	enemy_on_map(EAtk,ERow, ECol),
	enemies(Enemy_list),
	abs(ERow - Row) =< 1,
	abs(ECol - Col) =< 1,

	delObj(Enemy_list, [EAtk, ERow, ECol], Del_Enemy_list),
    modify_enemies(Del_Enemy_list),
	retract(enemy_on_map(EAtk, ERow,ECol)),fail.
	
	
	
