%# gets the piece to move and to which position
get_move(Row, Col, RowRes, ColRes):- 
    nl,
    print_string("Choose the piece to move: (e.g. a1 or A1)"), nl, 
    print_string("Cell - "), 
    get_char(RowChar),
    get_char(ColChar),
    read_number(Dump),
    Dump == 0,
    convert_to_row(RowChar, Row),
    convert_to_col(ColChar, Col),
    print_string("(If you chose a wrong Cell, you can type \"wrong\" to choose again)"), nl,
    print_string("To Which Cell - "), 
    get_char(NewRowChar),
    get_char(NewColChar),
    read_number(Dump2),
    Dump2 == 0,
    convert_to_row(NewRowChar, RowRes),
    convert_to_col(NewColChar, ColRes).
    
get_move(Row, Col, RowRes, ColRes):- print_string("Cell invalid!"), nl,
                                     get_move(Row, Col, RowRes, ColRes).

%# conversion the input to a valid row
convert_to_row('A', 0).
convert_to_row('B', 1).
convert_to_row('C', 2).
convert_to_row('D', 3).
convert_to_row('E', 4).
convert_to_row(a, 0).
convert_to_row(b, 1).
convert_to_row(c, 2).
convert_to_row(d, 3).
convert_to_row(e, 4).
convert_to_row(_RowChar, _Row):- fail.  

%# conversion the input to a valid column
convert_to_col('1', 0).
convert_to_col('2', 1).
convert_to_col('3', 2).
convert_to_col('4', 3).
convert_to_col('5', 4).
convert_to_col(_ColChar, _Col):- fail.

%# moves the piece
move([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, GameStateRes):-
    !, check_valid_piece(GameBoard, Turn, Row, Col, 0, Piece),
    check_valid_position(GameBoard, Row, Col, RowRes, ColRes, Piece, Turn, Player, yes),
    length(GameBoard, BoardLength),
    duck_to_swan(Piece, RowRes, BoardLength, NewPiece),
    update_position(GameBoard, Row, Col, empty, 0, [], GameBoardTemp),
    update_position(GameBoardTemp, RowRes, ColRes, NewPiece, 0, [], GameBoardFinal),
    update_turn(Turn, NewTurn),
    GameStateRes = [GameBoardFinal|NewTurn].


%# check if piece chosen is valid
check_valid_piece([], _, _, _, _, _):- print_string("Position invalid! Try another position!"), nl, fail.
check_valid_piece([Current|_Rest], Turn, Row, Col, CurrentRow, Piece):- CurrentRow is Row, !,
                                                                        percorre_linha(Current, Turn, Col, 0, Piece).
check_valid_piece([_Current|Rest], Turn, Row, Col, CurrentRow, Piece):- Next is CurrentRow + 1,
                                                                        check_valid_piece(Rest, Turn, Row, Col, Next, Piece).                                             

percorre_linha([], _, _, _, _):- print_string("Position out of bounds! Try another position!"), nl, fail.
percorre_linha([Current|_Rest], Turn, Col, CurrentCol, Piece):- CurrentCol is Col, !,
                                                                check_cell(Current, Turn),
                                                                get_piece(Current, Piece). 
percorre_linha([_Current|Rest], Turn, Col, CurrentCol, Piece):- Next is CurrentCol + 1,
                                                                percorre_linha(Rest, Turn, Col, Next, Piece).

check_cell(duck_green, green):- !.
check_cell(swan_green, green):- !.
check_cell(duck_blue, blue):- !.
check_cell(swan_blue, blue):- !.
check_cell(_, _):- nl, print_string("Choose a position with a piece of your own!!"), nl, !, fail.
%###################################


%# check if position chosen is valid
check_valid_position(GameBoard, Row, Col, NewRow, NewCol, Piece, Turn, Player, Flag):- length(GameBoard, N),
                                                                                       NewRow @=< N,
                                                                                       NewCol @=< N, !,
                                                                                       check_valid_move(Row, Col, NewRow, NewCol, Piece), !,
                                                                                       check_for_colisions(GameBoard, 0, NewRow, Col, NewCol, Turn, Player, Flag).
check_valid_position(_, _, _, _, _, _, _):- print_string("Position out of bounds!"), nl,
                                            print_string("You must move your piece to a position inside the limits of the board!"), nl, fail.

check_valid_move(Row, Col, NewRow, NewCol, duck_green):- NewRow is Row + 1,
                                                         (NewCol is Col + 1; NewCol is Col - 1; NewCol is Col).
check_valid_move(Row, Col, NewRow, NewCol, swan_green):- NewRow is Row - 1,
                                                         (NewCol is Col + 1; NewCol is Col - 1; NewCol is Col).                                                         
check_valid_move(Row, Col, NewRow, NewCol, duck_blue):- NewRow is Row - 1,
                                                        (NewCol is Col + 1; NewCol is Col - 1; NewCol is Col).
check_valid_move(Row, Col, NewRow, NewCol, swan_blue):- NewRow is Row + 1,
                                                        (NewCol is Col + 1; NewCol is Col - 1; NewCol is Col).                                                        
check_valid_move(_, _, _, _, _):- print_string("Invalid move! Check valid moves at the Instructions of the game!"), nl, fail.

%# check for possible colisions, it can determine if position is valid or not
check_for_colisions([Current|_Rest], CurrentRow, NewRow, Col, NewCol, Turn, Player, Flag):- CurrentRow is NewRow, !,
                                                                                            check_for_colisions_aux(Current, 0, Col, NewCol, Turn, Player, Flag).
check_for_colisions([_Current|Rest], CurrentRow, NewRow, Col, NewCol, Turn, Player, Flag):- Next is CurrentRow + 1,
                                                                                            check_for_colisions(Rest, Next, NewRow, Col, NewCol, Turn, Player, Flag).

check_for_colisions_aux([Current|_Rest], CurrentCol, Col, NewCol, Turn, Player, Flag):- CurrentCol is NewCol, !,
                                                                                        check_colision(Current, Col, NewCol, Turn, Player, Flag).
check_for_colisions_aux([_Current|Rest], CurrentCol, Col, NewCol, Turn, Player, Flag):- Next is CurrentCol + 1,
                                                                                        check_for_colisions_aux(Rest, Next, Col, NewCol, Turn, Player, Flag). 

%# possible colisions check_colision(Piece, NewCol, Col, Turn, Player)
check_colision(empty, _, _, _, _, _):- !.
%# computer functions block
check_colision(duck_green, _, _, green, blue, _):- !, fail.
check_colision(swan_green, _, _, green, blue, _):- !, fail.
check_colision(duck_blue, _, _, blue, green, _):- !, fail.
check_colision(swan_blue, _, _, blue, green, _):- !, fail.
check_colision(_, NewCol, Col, green, blue, yes):- (NewCol is Col + 1; NewCol is Col - 1), print_string("Computer ate a piece of the adversary's board!"), nl.
check_colision(_, NewCol, Col, blue, green, yes):- (NewCol is Col + 1; NewCol is Col - 1), print_string("Computer ate a piece of the adversary's board!"), nl.
check_colision(_, _, _, green, blue, not).
check_colision(_, _, _, blue, green, not).
%# player's functions block
check_colision(duck_green, _, _, green, _, _):- !, print_string("You already have a piece in that position! You cant go there!"), nl, fail.
check_colision(swan_green, _, _, green, _, _):- !, print_string("You already have a piece in that position! You cant go there!"), nl, fail. 
check_colision(duck_blue, _, _, blue, _, _):- !, print_string("You already have a piece in that position! You cant go there!"), nl, fail.
check_colision(swan_blue, _, _, blue, _, _):- !, print_string("You already have a piece in that position! You cant go there!"), nl, fail.
check_colision(_, NewCol, Col, green, green, _):- (NewCol is Col + 1; NewCol is Col - 1), print_string("You ate a piece of the adversary!"), nl.
check_colision(_, NewCol, Col, blue, blue, _):- (NewCol is Col + 1; NewCol is Col - 1), print_string("You ate a piece of the adversary!"), nl.
%###################################


%# update cell funtions
update_position([], _, _, _, _, CurrentBoard, NewGameBoard):- append([], CurrentBoard, NewGameBoard).
update_position([Current|Rest], Row, Col, Type, CurrentRow, CurrentBoard, NewGameBoard):- CurrentRow is Row, !,
                                                                                          update_position_aux(Current, Col, Type, 0, [], NewRow),
                                                                                          append(CurrentBoard, [NewRow], NewCurrentBoard),
                                                                                          Next is CurrentRow + 1,
                                                                                          update_position(Rest, Row, Col, Type, Next, NewCurrentBoard, NewGameBoard).
update_position([Current|Rest], Row, Col, Type, CurrentRow, CurrentBoard, NewGameBoard):- append(CurrentBoard, [Current], NewCurrentBoard),
                                                                                          Next is CurrentRow + 1,
                                                                                          update_position(Rest, Row, Col, Type, Next, NewCurrentBoard, NewGameBoard).

update_position_aux([], _, _, _, CurrentRow, NewRow):- append([], CurrentRow, NewRow).
update_position_aux([_Current|Rest], Col, Type, CurrentCol, CurrentRow, NewRow):- CurrentCol is Col, !,
                                                                                  append(CurrentRow, [Type], NewCurrentRow),
                                                                                  Next is CurrentCol + 1,
                                                                                  update_position_aux(Rest, Col, Type, Next, NewCurrentRow, NewRow).
update_position_aux([Current|Rest], Col, Type, CurrentCol, CurrentRow, NewRow):- Next is CurrentCol + 1,
                                                                                 append(CurrentRow, [Current], NewCurrentRow),
                                                                                 update_position_aux(Rest, Col, Type, Next, NewCurrentRow, NewRow).
%###################################


%# change duck to a swan
duck_to_swan(duck_green, RowRes, BoardLength, NewPiece):- RowRes is BoardLength - 1, !,
                                                          NewPiece = swan_green.
duck_to_swan(duck_blue, RowRes, _, NewPiece):- RowRes is 0, !,
                                               NewPiece = swan_blue.
duck_to_swan(Piece, _, _, Piece).
%###################################


%# update the turn of the player
update_turn(green, blue).
update_turn(blue, green).
