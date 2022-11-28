%# 1.
%s(1).
%s(2):- !.
%s(3).

%# a)
%X = 1 ? ;
%X = 2 ? ;
%no

%# b)
%X = 1, %Y = 1 ? ;
%X = 1, %Y = 2 ? ;
%X = 2, %Y = 1 ? ;
%X = 2, %Y = 2 ? ;
%no

%# c)
%X = 1, %Y = 1 ? ;
%X = 1, %Y = 2 ? ;
%no


%# 2.
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

%# a)
%X=one?; X=two?; X=three?; X=`five`?; no
%# b)
%X=one?; no
%# c)
%X=one, Y= one?; X=one, Y= two?; X=one, Y= three?


%# 3.
immature(X):- adult(X), !, fail. 
immature(_X).
%# red cut

adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.
%# green cut (good example for a switch case)


%# 4.

%# a)
print_n(_, 0):- !.
print_n(S, N):- write(S), N1 is N-1,
                print_n(S, N1).

%# b)
print_text(Text, Symbol, Padding):- write(Symbol),
                                    print_n(' ', Padding),
                                    print_string(Text),
                                    print_n(' ', Padding),
                                    write(Symbol).
                                    
print_string([]).
print_string([H | T]):- put_code(H),
                        print_string(T).

%# c)
print_banner(Text, Symbol, Padding):- length(Text, Len),
                                      N is Len + 2*Padding + 2,
                                      print_n(Symbol, N), nl,
                                      write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                      print_text(Text, Symbol, Padding), nl,
                                      write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                      print_n(Symbol, N).

%# d)
read_number_aux(Res, Res):- peek_code(10), !, skip_line.
read_number_aux(Current, Res):- get_code(Input),
                                Aux is Current*10 + Input - 48,
                                read_number_aux(Aux, Res).

read_number(Res):- read_number_aux(0, Res).

