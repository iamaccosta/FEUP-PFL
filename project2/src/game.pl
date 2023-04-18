:- consult('menu.pl').
:- consult('board.pl').
:- consult('moves.pl').
:- consult('bot.pl').
:- consult('view.pl').
:- consult('utilities.pl').

%# 2 players (inicialmente com 5 vidas)
%player(Number, Color)
player(1, green).
player(2, blue).
player(_, invalid).

%# peça e tipo
piece_type(duck_green, green).
piece_type(swan_green, green).
piece_type(duck_blue, blue).
piece_type(swan_blue, blue).

get_piece(Type, Type).

%# display menu
play:- nl, logo, nl, menu.

%# starting game functions
%# player_vs_player
game_start(1):- inital_state(GameState), !,
                p_vs_p_gameloop(GameState).
%# player_vs_computer
game_start(2, BotLevel):- choose_player(Player),
                          inital_state(GameState), !,
                          computer_vs_p_gameloop(GameState, Player, BotLevel).
%# computer_vs_computer
game_start(3, LevelBot1, LevelBot2):- inital_state(GameState), !,
                                      computer_vs_computer(GameState, LevelBot1, LevelBot2).

%# Inital State of our game (primeira jogada é do jogador green)
inital_state([GameBoard|PlayerTurn]):- create_board(GameBoard),
                                       PlayerTurn = green.

%# player vs player game loop
p_vs_p_gameloop([GameBoard|Turn]):- game_over(GameBoard), !,
                                    nl,
                                    logo, nl,
                                    display_board(GameBoard, 0),
                                    print_string("Winner is "),
                                    print_winner(Turn),
                                    display_exit.

p_vs_p_gameloop([GameBoard|Turn]):- display_game([GameBoard|Turn]),
                                    get_move(Row, Col, RowRes, ColRes),
                                    move([GameBoard|Turn], Turn, Row, Col, RowRes, ColRes, GameStateRes), !,
                                    p_vs_p_gameloop(GameStateRes).

p_vs_p_gameloop(GameState):- p_vs_p_gameloop(GameState).
%################################

%# computer vs player game loop
computer_vs_p_gameloop([GameBoard|Turn], Player, _Level):- game_over(GameBoard), !,
                                                           nl,
                                                           logo, nl,
                                                           display_board(GameBoard, 0),
                                                           print_end_msg(Turn, Player),
                                                           display_exit.
                                            
%# player's turn
computer_vs_p_gameloop([GameBoard|Player], Player, Level):- display_game([GameBoard|Player]),
                                                            get_move(Row, Col, RowRes, ColRes),
                                                            move([GameBoard|Player], Player, Row, Col, RowRes, ColRes, GameStateRes), !,
                                                            computer_vs_p_gameloop(GameStateRes, Player, Level).  
%# computer's turn 
computer_vs_p_gameloop([GameBoard|Turn], Player, Level):- Player \= Turn, 
                                                          display_game([GameBoard|Turn]),
                                                          choose_move([GameBoard|Turn], Player, Level, Row, Col, RowRes, ColRes),
                                                          move([GameBoard|Turn], Player, Row, Col, RowRes, ColRes, GameStateRes), !,
                                                          computer_vs_p_gameloop(GameStateRes, Player, Level).

computer_vs_p_gameloop(GameState, Player, Level):- computer_vs_p_gameloop(GameState, Player, Level).                                  
%################################

%# computer_vs_computer mode 
computer_vs_computer([GameBoard|Turn], _LevelBot1, _LevelBot2):- game_over(GameBoard), !,
                                                                 nl,
                                                                 logo, nl,
                                                                 display_board(GameBoard, 0),
                                                                 print_string("Winner is "),
                                                                 print_winner(Turn),
                                                                 display_exit.
%# green computer's turn
computer_vs_computer([GameBoard|Turn], LevelBot1, LevelBot2):- Turn == green,
                                                               display_game([GameBoard|Turn]),
                                                               choose_move([GameBoard|Turn], blue, LevelBot1, Row, Col, RowRes, ColRes),
                                                               move([GameBoard|Turn], blue, Row, Col, RowRes, ColRes, GameStateRes), !,
                                                               computer_vs_computer(GameStateRes, LevelBot1, LevelBot2).
%# blue computer's turn                                                        
computer_vs_computer([GameBoard|Turn], LevelBot1, LevelBot2):- Turn == blue,
                                                               display_game([GameBoard|Turn]),
                                                               choose_move([GameBoard|Turn], green, LevelBot2, Row, Col, RowRes, ColRes),
                                                               move([GameBoard|Turn], green, Row, Col, RowRes, ColRes, GameStateRes), !,
                                                               computer_vs_computer(GameStateRes, LevelBot1, LevelBot2).

computer_vs_computer(GameState, LevelBot1, LevelBot2):- computer_vs_computer(GameState, LevelBot1, LevelBot2).
%################################


%# check if game is over 
game_over(GameBoard):- (\+ (check_player_alive(GameBoard, duck_green); check_player_alive(GameBoard, swan_green))); goal(GameBoard, 0, green).
game_over(GameBoard):- (\+ (check_player_alive(GameBoard, duck_blue); check_player_alive(GameBoard, swan_blue))); goal(GameBoard, 0, blue).

check_player_alive([Current|_Rest], Type):- check_player_alive_aux(Current, Type).
check_player_alive([_Current|Rest], Type):- check_player_alive(Rest, Type).

check_player_alive_aux([], _):- fail.
check_player_alive_aux([Current|_Rest], Type):- Current == Type.
check_player_alive_aux([_Current|Rest], Type):- check_player_alive_aux(Rest, Type).

goal([Current|_Rest], CurrentRow, green):- CurrentRow is 0, !,
                                           check_if_goal(Current, swan_green).
goal([Current|_Rest], CurrentRow, blue):- CurrentRow is 4, !,
                                          check_if_goal(Current, swan_blue).
goal([_Current|Rest], CurrentRow, blue):- Next is CurrentRow + 1, !,
                                          goal(Rest, Next, blue).

check_if_goal([], _):- fail.
check_if_goal([Current|_Rest], Piece):- Current == Piece.
check_if_goal([_Current|Rest], Piece):- check_if_goal(Rest, Piece).                                    
%################################

choose_player(Player):- print_string("Which player you want to be? [1|2] "),
                        read_number(P),
                        player(P, Turn),
                        Turn \= invalid, !,
                        Player = Turn.
choose_player(Player):- choose_player(Player).

%########## EXAMPLES OF THE BOARD ##########
%# Inital State
gameBoard_Initial([[duck_green, duck_green, duck_green, duck_green, duck_green],
[empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty],
[duck_blue, duck_blue, duck_blue, duck_blue, duck_blue]]).

%# Intermediate State
gameBoard_Intermediate([[empty, duck_green, empty, duck_green, duck_green],
[empty, duck_blue, empty, empty, empty],
[empty, duck_green, empty, empty, empty],
[empty, empty, empty, duck_blue, empty],
[duck_blue, empty, swan_green, duck_blue, duck_blue]]).

%# Final State
gameBoard_Final([[empty, empty, empty, swan_green, empty],
[empty, duck_blue, empty, empty, empty],
[empty, duck_green, empty, swan_blue, empty],
[empty, empty, empty, empty, empty],
[empty, empty, empty, duck_blue, empty]]).