%########################## MENU FUNCTIONS ##########################

%# displays logo of our game
logo:- write('*******************************************************************************************'),nl,
       write('*                                                                                         *'),nl,
       write('*  @@     @@ @@@@@@@@@  @@       @@      @@     @@@@@@@@   @@     @@  @@@@@@@@@ @@    @@  *'),nl,
       write('*  @@     @@ @@         @@        @@    @@      @@     @@  @@     @@  @@        @@   @@   *'),nl,
       write('*  @@     @@ @@         @@         @@  @@       @@      @@ @@     @@  @@        @@  @@    *'),nl,
       write('*  @@     @@ @@  @@@@@  @@           @@         @@      @@ @@     @@  @@        @@@@      *'),nl,
       write('*  @@     @@ @@     @@  @@           @@         @@      @@ @@     @@  @@        @@  @@    *'),nl,
       write('*  @@     @@ @@     @@  @@           @@         @@     @@  @@     @@  @@        @@   @@   *'),nl,
       write('*  @@@@@@@@@ @@@@@@@@@  @@@@@@@@     @@         @@@@@@@@   @@@@@@@@@  @@@@@@@@@ @@    @@  *'),nl,
       write('*                                                                                         *'),nl,
       write('*******************************************************************************************'),nl.

%# displays the menu options
menu:- display_banner(["MENU", "", "1 - PLAY       ", "2 - INSTRUCTIONS", "3 - EXIT       "], '*', 2),
       print_string("Choose an option! "),
       read_number(Option),
       menu_option(Option).

%# deals with the option chosen
menu_option(1):- choose_mode.
menu_option(2):- display_instructions.
menu_option(3):- display_exit.
menu_option(_):- display_error, menu.

%# displays the instructions
display_instructions:- 
    nl, display_banner(["INSTRUCTIONS", 
                        "",
                        "DUCK > A duck moves one cell orthogonal and diagonal forward     ",
                        "   - Ducks capture diagonal forward. Captures are not mandatory. ",
                        "   - A duck reaching last row is promoted to a swan.             ",
                        "SWAN > A swan moves one cell orthogonal and diagonal backward    ",
                        "   - Swans capture diagonal backward. Captures are not mandatory.",
                        "GOAL > Wins the player who first moves a swan into his first row.",
                        "",
                        "To choose a spot on the board use the following convention:      ",
                        "   \"X0\" -> where X is the row and 0 represents the column.        "],
                        '*', 2), 
    nl, menu.

%# exits the game
display_exit:- nl, display_banner(["Good Bye!"], '*', 2), nl.

%# displays error msg
display_error:- display_banner(["YOU MUST CHOOSE ONE", "OF THE OPTIONS"], '*', 2).

%# display mode options
choose_mode:- nl, display_banner(["MODE", "", "1 - Human vs Human      ", "2 - Human vs Computer   ", "3 - Computer vs Computer"], '*', 2),
              print_string("Choose an option! "),
              read_number(Mode), !,
              mode_option(Mode).

%# deals with the mode chosen, the difficulty chosen and calls the function that starts the game
mode_option(1):- !, game_start(1).
mode_option(2):- choose_difficulty(Difficulty), !,
                 game_start(2, Difficulty).
mode_option(3):- nl, print_string("Computer 1:"),
                 choose_difficulty(Difficulty1),
                 nl, print_string("Computer 2:"),
                 choose_difficulty(Difficulty2), !,
                 game_start(3, Difficulty1, Difficulty2).
mode_option(_):- display_error, choose_mode.

%# display difficuties options
choose_difficulty(Difficulty):- nl, display_banner(["DIFFICULTY", "", "1 - Easy Mode     ", "2 - Difficult Mode"], '*', 2),
                                print_string("Choose an option! "),
                                read_number(Difficulty), !,
                                (Difficulty @=< 2, Difficulty @> 0).