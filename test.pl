
test:-
	asserta(item_on_map(first_aid, 5, 5)),
	asserta(item_on_map(bandage, 3, 3)),
	asserta(item_on_map(pain_killer, 3, 5)),
	asserta(item_on_map(herbs, 1, 2)),
	asserta(item_on_map(stimulant, 1, 4)),

	asserta(item_on_map(canned_food, 9, 9)),
	asserta(item_on_map(fruits, 7, 9)),
	asserta(item_on_map(raw_meat, 8, 11)),
	asserta(item_on_map(mushrooms, 6, 12)),
	asserta(item_on_map(edible_plant, 8, 7)),

	asserta(item_on_map(bottled_water, 13, 11)),
	asserta(item_on_map(clean_water, 13, 9)),
	asserta(item_on_map(bottled_tea, 15, 8)),

	asserta(item_on_map(riffle, 7, 13)),
	asserta(item_on_map(long_sword, 8, 13)),
	asserta(item_on_map(bow_arrow, 9, 14)),
	asserta(item_on_map(long_bow, 10, 14)),
	asserta(item_on_map(spear, 11, 15)),
	
	
	
	
	asserta(enemy_on_map(22,4,3)),
	asserta(enemy_on_map(33,5,3)),
	asserta(enemy_on_map(19,14,13)),
	asserta(enemy_on_map(21,12,13)).
	