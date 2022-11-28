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
read_number(Res):- read_number_aux(0, Res).

read_number_aux(Res, Res):- peek_code(10), !, skip_line.
read_number_aux(Current, Res):- get_code(Input),
                                Aux is Current*10 + Input - 48,
                                read_number_aux(Aux, Res).

%# e)
read_until_between(Min, Max, Value) :- repeat,
                                       read_number(Value),
                                       Value >= Min,
                                       Value =< Max,
                                       !.

%# f)
read_string("") :- peek_code(10), !, skip_line.
read_string([Char | T]) :- get_code(Char),
                           read_string(T).

%# g)
get_banner:- print_string("Text = "),
             read_string(Text), nl,
             print_string("Symbol = "),
             get_char(Symbol), get_char(_), nl,
             print_string("Padding = "),
             read_number(Padding), nl,
             print_banner(Text, Symbol, Padding).

%# h)
print_multi_banner(Texts, Symbol, Padding):- biggest_length(Texts, MaxLen),
                                             N is MaxLen + 2*Padding + 2,
                                             print_n(Symbol, N), nl,
                                             write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                             print_Texts(Texts, Symbol, Padding, MaxLen),
                                             write(Symbol), print_n(' ', N-2), write(Symbol), nl,
                                             print_n(Symbol, N), nl.

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

biggest_length([], 0).
biggest_length([H|T], Res):- length(H, L),
                             biggest_length(T, Res1),
                             Res1 < L,
                             !,
                             Res is L.
biggest_length([_ | T], Res):- biggest_length(T, Res).

%# i)
oh_christmas_tree(N):- christmas(N, 0).

christmas(N, N):- Space is N-1,
                  print_n(' ', Space),
                  write('*'),
                  print_n(' ', Space), nl.

christmas(N, I):- Nivel is 2*I+1,
                  Space is N-I-1, 
                  print_n(' ', Space),
                  print_n('*', Nivel), 
                  print_n(' ', Space),
                  nl,
                  I1 is I+1,
                  christmas(N, I1).

%# 5.
female(grace).
female(merle).
female(cameron).
female(pameron).
female(haley).
female(poppy).
female(dede).
female(claire).
female(gloria).
female(lily).

male(frank).
male(phil).
male(dylan).
male(george).
male(mitchell).
male(alex).
male(luke).
male(jay).
male(joe).
male(manny).
male(rexford).
male(javier).
male(barb).
male(bo).
male(calhoun).

parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(dede,mitchell).
parent(jay,claire).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).
parent(phil,haley).
parent(claire,haley).
parent(phil,alex).
parent(phil,luke).
parent(claire,alex).
parent(claire,luke).
parent(mitchell,lily).
parent(mitchell,rexford).
parent(cameron,lily).
parent(cameron,rexford).
parent(pameron,calhoun).
parent(bo,calhoun).
parent(dylan,george).
parent(dylan,poppy).
parent(haley,george).
parent(haley,poppy).

%# a)
children(Person, Children):- findall(Child, parent(Person, Child), Children).

%# b)
children_of([], []).
children_of([Person | People], [Person-Children | Pairs]):- children(Person, Children),
                                                            children_of(People, Pairs).

%# c)
family(F):- setof(Person, Relative^connected(Relative, Person), F).

connected(P1, P2):- parent(P1, P2); parent(P2, P1).

%# d)
couple(P1-P2):- parent(P1, C), parent(P2, C), P1 \= P2.

%# e)
couples(Couples):- setof(Couple, couple(Couple), Couples).

%# f) engloba relações de stepmom-stepson e.g.
spouse_children(Person, Spouse/Children) :- couple(Person-Spouse),
                                            children(Person, Children).

%# 6.

%# 7.

