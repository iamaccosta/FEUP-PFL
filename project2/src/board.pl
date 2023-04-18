%########################## BOARD CREATION ##########################
length_board(L):- L is 4.

%# creates the board
create_board(GameBoard):- create_row(5, duck_green, GreenPieces),
                          create_row(5, duck_blue, BluePieces),
                          create_empty_rows(3, 5, empty, EmptyRows),
                          append([GreenPieces], EmptyRows, CurrentRows),
                          append(CurrentRows, [BluePieces], GameBoard).

%# creates a row with a especific type
create_row(Size, Type, Res):- create_row_aux(Size, Type, [], Res).

create_row_aux(0, _, CurrentRow, Res):- append([], CurrentRow, Res).
create_row_aux(Size, Type, CurrentRow, Res):- Size1 is Size-1,
                                              append(CurrentRow, [Type], NewCurrentRow),
                                              create_row_aux(Size1, Type, NewCurrentRow, Res).


%# list of empty rows
create_empty_rows(N, Size, empty, EmptyRows):- create_row(Size, empty, EmptyRow),
                                               create_empty_rows_aux(N, EmptyRow, [], EmptyRows).

%# auxiliar funtion to the above function, so we do not create repetitively an empty row
create_empty_rows_aux(0, _, CurrentRows, EmptyRows):- append([], CurrentRows, EmptyRows).
create_empty_rows_aux(N, EmptyRow, CurrentRows, EmptyRows):- append(CurrentRows, [EmptyRow], NewCurrentRows),
                                                             N1 is N-1,
                                                             create_empty_rows_aux(N1, EmptyRow, NewCurrentRows, EmptyRows).