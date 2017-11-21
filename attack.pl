/***  ========================       ATTACK        ======================== ***/


%player:- player_health(H),player_hunger(Hu),player_thirst(T),player_pos(Pos_X,Pos_Y),player_weapon(W),player_inventory(I),asserta(player(H,Hu,T,Pos_X,Pos_Y,W,I)).


%attack:- player(H,Hu,T,Pos_X,Pos_Y,W,I) W=:= 1,enemy(HE,AE,Pos_X,Pos_Y),retract(H,Hu,T,Pos_X,Pos_Y,W,I),retract(enemy(HE,AE,Pos_X,Pos_Y)),
%		   F is H - AE , HA is W - HE , HE\==0, write ('you get attacked '),asserta(player(F,Hu,T,Pos_X,Pos_Y,W,I)),asserta(enemy(HA,AE,Pos_X,Pos_Y))).

%attack:- player(H,Hu,T,Pos_X,Pos_Y,W,I) W=:= 1,enemy(HE,AE,Pos_X,Pos_Y),retract(H,Hu,T,Pos_X,Pos_Y,W,I),retract(enemy(HE,AE,Pos_X,Pos_Y)),
%		   F is H - AE , HA is W - HE , HE==0, write ('an enemy killed '),asserta(player(F,Hu,T,Pos_X,Pos_Y,W,I)),asserta(enemy(HA,AE,Pos_X,Pos_Y))).

%attack :- player(_,_,_,_,_,_,W,_), W =:= 1, write('No more enemy to attack in this place').

%attack :- write('you\'re not using any weapon').

