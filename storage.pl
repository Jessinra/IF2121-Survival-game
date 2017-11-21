

/*** =============================             STORAGE            ==========================***/




%get_terain_position([]):- !.
%get_terain_position([Head | Tail]) :- [_,Terain_x, Terain_y] = Head , asserta(pos_terrains(Terain_x,Terain_y)),get_terain_position(Tail).  