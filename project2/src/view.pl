%########################## DISPLAYS ##########################
%barra(vertical, 9552).
%barra(horizontal, ).

%# peça
%piece(Type, Symbol)
piece(duck_green, 9660).
piece(swan_green, 9824).
piece(duck_blue, 9650).
piece(swan_blue, 9829).

%# displays the state of the game
display_game([GameBoard|Turn]):- nl, display_board(GameBoard, 0),
                                 display_turn(Turn), nl, !.

%# display the players' turn
display_turn(green):- print_string("Turn of Player 1!").
display_turn(blue):- print_string("Turn of Player 2!").

%# display of the board
display_board([], _):- display_row, nl.
display_board([CurrentRow|Rest], 0):- display_row,
                                      display_between_rows(CurrentRow, 0, 2, 0, 0),
                                      write('#'), nl,
                                      display_between_rows(CurrentRow, 3, 2, 0, 0),
                                      display_board([CurrentRow|Rest], 1).
display_board([CurrentRow|Rest], Row):- display_row,
                                        display_between_rows(CurrentRow, 0, 2, Row, 0),
                                        write('#'), nl,
                                        display_between_rows(CurrentRow, 3, 2, Row, 0),
                                        NextRow is Row + 1,
                                        display_board(Rest, NextRow).

%# display of an row
display_row:- print_string_n("##########", 6), write('#'), nl.

display_between_rows([], _, _, _, _).
display_between_rows(_, 5, _, _, _).
display_between_rows([Current|Rest], CurrentN, N, Row, 0):- CurrentN is N,
                                                            print_string("#    "),
                                                            display_elem(Current, Row, 0),
                                                            print_string("    "),
                                                            display_between_rows([Current|Rest], CurrentN, N, Row, 1).
display_between_rows([Current|Rest], CurrentN, N, Row, Col):- CurrentN is N,
                                                              print_string("#    "),
                                                              display_elem(Current, Row, Col),
                                                              print_string("    "),
                                                              NextCol is Col + 1,
                                                              display_between_rows(Rest, CurrentN, N, Row, NextCol).
display_between_rows(CurrentRow, CurrentN, N, Row, Col):- print_string_n("#         ", 6), 
                                                          write('#'), nl,
                                                          Next is CurrentN + 1,
                                                          display_between_rows(CurrentRow, Next, N, Row, Col).
                                  
%# display a cell (our game is a Matrix 5x5)
display_elem(_Elem, 0, 0):- write(' ').
display_elem(_Elem, 0, 1):- write('1').
display_elem(_Elem, 0, 2):- write('2').
display_elem(_Elem, 0, 3):- write('3').
display_elem(_Elem, 0, 4):- write('4').
display_elem(_Elem, 0, 5):- write('5').
display_elem(_Elem, 1, 0):- write('A').
display_elem(_Elem, 2, 0):- write('B').
display_elem(_Elem, 3, 0):- write('C').
display_elem(_Elem, 4, 0):- write('D').
display_elem(_Elem, 5, 0):- write('E').
display_elem(empty, _, _):- write(' ').
display_elem(Elem, _Row, _Col):- piece(Elem, Symbol), put_code(Symbol).
