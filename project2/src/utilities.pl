%########################## AUXILIAR FUNCTIONS ##########################

%# reads an integer number
read_number(Res):- read_number_aux(0, Res).

read_number_aux(Res, Res):- peek_code(10), !, skip_line.
read_number_aux(Current, Res):- get_code(Input),
                                Aux is Current*10 + Input - 48,
                                read_number_aux(Aux, Res).

%# reads a string
read_string(Res):- read_number_aux(0, Res).

read_string_aux(Res, Res):- peek_code(10), !, skip_line.
read_string_aux(Current, Res):- get_char(Input),
                                Aux is Current*10 + Input - 48,
                                read_number_aux(Aux, Res).

%########################## PRINTS ##########################

%# prints S N times
print_n(_, 0):- !.
print_n(S, N):- write(S), N1 is N-1,
                print_n(S, N1).
    
print_n2(_, 0):- !.
print_n2(S, N):- put_code(S), N1 is N-1,
                 print_n(S, N1).

%# prints a string
print_string([]).
print_string([H | T]):- put_code(H),
                        print_string(T).

%# prints a string N times
print_string_n(_, 0).
print_string_n(List, N):- print_string(List),
                          N1 is N - 1,
                          print_string_n(List, N1).

%# prints a line N times
print_n_lines(_, 0).
print_n_lines(Line, N):- print_string(Line), nl,
                         N1 is N - 1,
                         print_n_lines(Line, N1).

%# prints a banner
display_banner(Texts, Symbol, Padding):- biggest_length(Texts, MaxLen),
                                         N is MaxLen + 2*Padding + 2,
                                         print_n(Symbol, N), nl,
                                         write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                         print_Texts(Texts, Symbol, Padding, MaxLen),
                                         write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                         print_n(Symbol, N), nl.


%# prints a list of strings inside a banner
print_Texts([], _Symbol, _Padding, _MaxLen):- !.
print_Texts([H|T], Symbol, Padding, MaxLen):- length(H, L),
                                              Mod is mod(MaxLen-L, 2),
                                              Mod is 0,
                                              write(Symbol),
                                              print_n(' ', Padding + div((MaxLen - L), 2)),
                                              print_string(H),
                                              print_n(' ', Padding + div((MaxLen - L), 2)),
                                              write(Symbol), nl,
                                              print_Texts(T, Symbol, Padding, MaxLen).
print_Texts([H|T], Symbol, Padding, MaxLen):- length(H, L),
                                              write(Symbol),
                                              print_n(' ', Padding + div((MaxLen - L), 2)),
                                              print_string(H),
                                              print_n(' ', Padding + div((MaxLen - L), 2)+1),
                                              write(Symbol), nl,
                                              print_Texts(T, Symbol, Padding, MaxLen).

%# gets the biggest length of a list of strings
biggest_length([], 0).
biggest_length([H|T], Res):- length(H, L),
                             biggest_length(T, Res1),
                             Res1 < L,
                             !,
                             Res is L.
biggest_length([_ | T], Res):- biggest_length(T, Res).

print_winner(green):- print_string("Player 2!"), nl.
print_winner(blue):- print_string("Player 1!"), nl.

print_end_msg(Turn, Player):- Turn \= Player,
                              print_string("YOU WON THE GAME!"), nl.
print_end_msg(_, _):- print_string("YOU LOST AGAINST COMPUTER!"), nl.

%########################## Game Fuctions ##########################

get_piece([Current|_Rest], [Row|Col], CurrentRow, Piece):- Row is CurrentRow, !,
                                                           get_piece_aux(Current, Col, 0, Piece).
get_piece([_Current|Rest], [Row|Col], CurrentRow, Piece):- NextRow is CurrentRow + 1, 
                                                           get_piece(Rest, [Row|Col], NextRow, Piece).

get_piece_aux([Current|_Rest], Col, CurrentCol, Piece):- Col is CurrentCol, !,
                                                         Piece = Current.
get_piece_aux([_Current|Rest], Col, CurrentCol, Piece):- NextCol is CurrentCol + 1,
                                                         get_piece_aux(Rest, Col, NextCol, Piece).