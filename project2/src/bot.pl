%# Contains the functions of the Bot's plays
:- use_module(library(random)).
:- use_module(library(lists)).

%# choose_move([GameBoard|Turn], Player, Difficulty, Row, Col, RowRes, ColRes)
%# difficulty 1
choose_move([GameBoard|Turn], Player, 1, Row, Col, RowRes, ColRes):- 
    go_through_row(GameBoard, Turn, 0, [], ListMoves), !,
    length(ListMoves, Size), 
    choose_random([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, ListMoves, Size).

%# difficulty 2
choose_move([GameBoard|Turn], Player, 2, Row, Col, RowRes, ColRes):- 
    go_through_row(GameBoard, Turn, 0, [], ListMoves), !,
    better_moves([GameBoard|Turn], ListMoves, [], BetterMoves),
    choose_best_move([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, ListMoves, BetterMoves).

%# case that bot has a piece that can achieve the goal of the game
choose_best_move([GameBoard|_Turn], _Player, Row, Col, RowRes, ColRes, ListMoves, _BetterMoves):-
    move_achieve_goal(GameBoard, ListMoves, Move), !,
    separate(Move, Row, Col, RowRes, ColRes).
%# case that bot has pieces that can eat pieces of the adversary   
%# first swans eats
choose_best_move([GameBoard|_Turn], _Player, Row, Col, RowRes, ColRes, _ListMoves, BetterMoves):-
    length(BetterMoves, LengthBetter),
    \+ (LengthBetter is 0),
    move_swans(GameBoard, BetterMoves, [], Moves),
    length(Moves, LengthMoves),
    \+ (LengthMoves is 0), !,
    random(0, LengthMoves, Index),
    nth0(Index, Moves, Move),
    separate(Move, Row, Col, RowRes, ColRes).
%# then ducks eats
choose_best_move(_GameState, _Player, Row, Col, RowRes, ColRes, _ListMoves, BetterMoves):-
    length(BetterMoves, LengthBetter),
    \+ (LengthBetter is 0), !,
    random(0, LengthBetter, Index),
    nth0(Index, BetterMoves, Move),
    separate(Move, Row, Col, RowRes, ColRes).
%# case that bot has ducks that can be swans
choose_best_move([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, ListMoves, _BetterMoves):-
    achieve_swan(GameBoard, ListMoves, [], Moves),
    length(Moves, LengthMoves),
    \+ (LengthMoves is 0), !,
    choose_random([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, Moves, LengthMoves).
%# move swans before of ducks
choose_best_move([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, ListMoves, _BetterMoves):-
    move_swans(GameBoard, ListMoves, [], Moves),
    length(Moves, LengthMoves),
    \+ (LengthMoves is 0), !,
    choose_random([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, Moves, LengthMoves).
%# random move
choose_best_move(GameState, Player, Row, Col, RowRes, ColRes, ListMoves, _BetterMoves):-
    length(ListMoves, Size), 
    choose_random(GameState, Player, Row, Col, RowRes, ColRes, ListMoves, Size).
    
%# choose a random move in the ListMoves    
choose_random([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, ListMoves, Size):-  
    random(0, Size, Index),
    nth0(Index, ListMoves, Move),
    separate(Move, _TempRow, TempCol, TempRowRes, TempColRes),
    check_for_colisions(GameBoard, 0, TempRowRes, TempCol, TempColRes, Turn, Player, not),
    separate(Move, Row, Col, RowRes, ColRes).     
choose_random(GameState, Player, Row, Col, RowRes, ColRes, ListMoves, Size):- choose_random(GameState, Player, Row, Col, RowRes, ColRes, ListMoves, Size).                                                         
%#####################################


%# moves that a piece can eats another piece from the adversary
better_moves(_, [], CurrentBetterMoves, BetterMoves):- append([], CurrentBetterMoves, BetterMoves).
better_moves([GameBoard|Turn], [CurrentMove|Rest], CurrentBetterMoves, BetterMoves):-
    check_current_move(GameBoard, Turn, CurrentMove, 0), !,
    append(CurrentBetterMoves, [CurrentMove], PseudoBetterMoves),
    better_moves([GameBoard|Turn], Rest, PseudoBetterMoves, BetterMoves).
better_moves(GameState, [_CurrentMove|Rest], CurrentBetterMoves, BetterMoves):- better_moves(GameState, Rest, CurrentBetterMoves, BetterMoves).

%# go through rows
check_current_move([Current|_Rest], Turn, [_Row, Col, NextRow, NextCol], CurrentRow):-
    NextRow is CurrentRow, !,
    check_current_move_aux(Current, Turn, Col, NextCol, 0).
check_current_move([_Current|Rest], Turn, CurrentMove, CurrentRow):- ProxRow is CurrentRow + 1,
                                                                     check_current_move(Rest, Turn, CurrentMove, ProxRow).

%# go through columns
check_current_move_aux([CurrentPiece|_Rest], Turn, Col, NextCol, CurrentCol):- 
    NextCol is CurrentCol, !,
    check_piece(CurrentPiece, Turn, Col, NextCol).
check_current_move_aux([_CurrentPiece|Rest], Turn, Col, NextCol, CurrentCol):- ProxCol is CurrentCol+1,
                                                                               check_current_move_aux(Rest, Turn, Col, NextCol, ProxCol).

%# check if there is a piece of adversary
check_piece(duck_green, blue, Col, NextCol):- (NextCol is Col + 1; NextCol is Col - 1).
check_piece(swan_green, blue, Col, NextCol):- (NextCol is Col + 1; NextCol is Col - 1).
check_piece(duck_blue, green, Col, NextCol):- (NextCol is Col + 1; NextCol is Col - 1).
check_piece(swan_blue, green, Col, NextCol):- (NextCol is Col + 1; NextCol is Col - 1).
check_piece(_, _, _, _):- !, fail.
%#####################################


%# check if bot has pieces that can achieve the goal of the game
move_achieve_goal(GameBoard, [[Row, Col, NewRow, NewCol]|_Rest], Move):- 
    get_piece(GameBoard, [Row|Col], 0, Piece),
    calculate_distance(Piece, NewRow), !,
    append([], [Row, Col, NewRow, NewCol], Move).
move_achieve_goal(GameBoard, [_CurrentMove|Rest], Move):- move_achieve_goal(GameBoard, Rest, Move).

%# check if bot has ducks that can turn into swans
achieve_swan(_GameBoard, [], CurrentMoves, Moves):- append([], CurrentMoves, Moves).
achieve_swan(GameBoard, [[Row, Col, NewRow, NewCol]|Rest], CurrentMoves, Moves):-
    get_piece(GameBoard, [Row|Col], 0, Piece),
    calculate_distance_to_swan(Piece, NewRow), !,
    append(CurrentMoves, [[Row, Col, NewRow, NewCol]], NewCurrentMoves),
    achieve_swan(GameBoard, Rest, NewCurrentMoves, Moves).
achieve_swan(GameBoard, [_CurrentMove|Rest], CurrentMoves, Moves):- achieve_swan(GameBoard, Rest, CurrentMoves, Moves).   

%# move swans before ducks
move_swans(_GameBoard, [], CurrentMoves, Moves):- append([], CurrentMoves, Moves).
move_swans(GameBoard, [[Row, Col, NewRow, NewCol]|Rest], CurrentMoves, Moves):-
    get_piece(GameBoard, [Row|Col], 0, Piece),
    (Piece == swan_blue; Piece == swan_green), !,
    append(CurrentMoves, [[Row, Col, NewRow, NewCol]], NewCurrentMoves),
    move_swans(GameBoard, Rest, NewCurrentMoves, Moves).
move_swans(GameBoard, [_CurrentMove|Rest], CurrentMoves, Moves):- move_swans(GameBoard, Rest, CurrentMoves, Moves).

%# calculate the distance of that piece to achieve the goal
calculate_distance(swan_green, 0).
calculate_distance(swan_blue, 4).
calculate_distance(_, _):- !, fail.

calculate_distance_to_swan(duck_green, 4).
calculate_distance_to_swan(duck_blue, 0).
calculate_distance_to_swan(_, _):- !, fail.

%# function to separate information about the list after random choose
separate([Row1, Col1, RowRes1, ColRes1], Row, Col, RowRes, ColRes):- Row is Row1,
                                                                     Col is Col1,
                                                                     RowRes is RowRes1,
                                                                     ColRes is ColRes1.
                                                                     
go_through_row([], _, _, CurrentListMoves, ListMoves):- append([], CurrentListMoves, ListMoves).
go_through_row([Current|Rest], Turn, CurrentRow, CurrentListMoves, ListMoves):- go_through_column(Current, Turn, CurrentRow, 0, CurrentListMoves, NewListMoves),
                                                                                NextRow is CurrentRow + 1,
                                                                                go_through_row(Rest, Turn, NextRow, NewListMoves, ListMoves).

go_through_column([], _, _, _, CurrentListMoves, ListMoves):- append([], CurrentListMoves, ListMoves).
go_through_column([Type|Rest], Turn, Row, Col, CurrentListMoves, ListMoves):- add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, NewListMoves), !,
                                                                              NextCol is Col + 1,
                                                                              go_through_column(Rest, Turn, Row, NextCol, NewListMoves, ListMoves).
go_through_column([_|Rest], Turn, Row, Col, CurrentListMoves, ListMoves):- NextCol is Col + 1, go_through_column(Rest, Turn, Row, NextCol, CurrentListMoves, ListMoves).

%# [Row, Col, RowRes, ColRes]
%# [Row, Col, Row+1, Col], [Row, Col, Row+1, Col-1], [Row, Col, Row+1, Col+1]

%# Row + 1
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == duck_green , Turn == green); (Type == swan_blue , Turn == blue)),
                                                                        Col is 0,
                                                                        Row1 is Row+1, Col1 is Col+1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves).
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == duck_green , Turn == green); (Type == swan_blue , Turn == blue)),
                                                                        length_board(L),
                                                                        Col is L,
                                                                        Row1 is Row+1, Col1 is Col-1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves).
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == duck_green , Turn == green); (Type == swan_blue , Turn == blue)),
                                                                        Row1 is Row+1, Col1 is Col-1, Col2 is Col+1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves2),
                                                                        append(ListMoves2, [[Row, Col, Row1, Col2]], ListMoves).                                                              

%# Row - 1
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == swan_green , Turn == green); (Type == duck_blue , Turn == blue)),
                                                                        Col is 0,
                                                                        Row1 is Row-1, Col1 is Col+1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves).
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == swan_green , Turn == green); (Type == duck_blue , Turn == blue)),
                                                                        length_board(L),
                                                                        Col is L,
                                                                        Row1 is Row-1, Col1 is Col-1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves).
add_possible_moves(Type, Turn, Row, Col, CurrentListMoves, ListMoves):- ((Type == swan_green , Turn == green); (Type == duck_blue , Turn == blue)),
                                                                        Row1 is Row-1, Col1 is Col-1, Col2 is Col+1,
                                                                        append(CurrentListMoves, [[Row, Col, Row1, Col]], ListMoves1),
                                                                        append(ListMoves1, [[Row, Col, Row1, Col1]], ListMoves2),
                                                                        append(ListMoves2, [[Row, Col, Row1, Col2]], ListMoves).
