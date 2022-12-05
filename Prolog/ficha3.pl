:-use_module(library(ordsets)).

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
children(Person, Children):- setof(Child, parent(Person, Child), Children).

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
spouse_children(Person, Spouse/Children):- couple(Person-Spouse),
                                           children(Person, Children).

%# g)
immediate_family(Person, Parents-SC):- setof(Parent, parent(Parent, Person), Parents),
                                       setof(X, spouse_children(Person, X), SC).

%# h)
parents_of_two(Parents):- setof(Person, (Children)^(children(Person, Children), (length(Children, L), L @>= 2)), Parents).

%# 6.
leciona(adalberto,algoritmos).
leciona(bernardete,'bases de dados').
leciona(bernardete,'bases de muitos dados').
leciona(capitolino,compiladores).
leciona(diogenes,estatistica).
leciona(ermelinda,redes).

frequenta(alberto,algoritmos).
frequenta(bruna,algoritmos).
frequenta(cristina,algoritmos).
frequenta(diogo,algoritmos).
frequenta(eduarda,algoritmos).
frequenta(eduardo,algoritmos).
frequenta(antonio,'bases de dados').
frequenta(bruno,'bases de dados').
frequenta(cristina,'bases de dados').
frequenta(duarte,'bases de dados').
frequenta(eduardo,'bases de dados').
frequenta(alberto,'bases de dados').
frequenta(alberto,compiladores).
frequenta(bernardo,compiladores).
frequenta(clara,compiladores).
frequenta(diana,compiladores).
frequenta(eurico,compiladores).
frequenta(antonio,estatistica).
frequenta(bruna,estatistica).
frequenta(claudio,estatistica).
frequenta(duarte,estatistica).
frequenta(eva,estatistica).
frequenta(alvaro,redes).
frequenta(beatriz,redes).
frequenta(claudio,redes).
frequenta(diana,redes).
frequenta(eduardo,redes).

%# a)
teachers(Teachers):- setof(Teacher, (Teacher, UC)^leciona(Teacher, UC), Teachers).

%# b) usar setof (evita duplicados)

%# c)
students_of(T, S):- setof(Student, (UC)^(leciona(T, UC), frequenta(Student, UC)), S).

%# d)
teachers_of(S, T):- setof(Teacher, (UC)^(leciona(Teacher, UC), frequenta(S, UC)), T).

%# e)
common_courses(S1, S2, UC):- setof(Course, (frequenta(S1, Course), frequenta(S2, Course)), UC).

%# f)
more_than_one_course(S):- setof(Student, (UC1, UC2)^(frequenta(Student, UC1), frequenta(Student, UC2), UC1 \= UC2), S).

%# g)
colega(X,Y):-frequenta(X,_Z), frequenta(Y,_Z), X\=Y.

strangers(L):- setof(S1-S2, (UC1, UC2)^(frequenta(S1, UC1), frequenta(S2, UC2), S1 \= S2), StudentPairs),
               setof(S1-S2, colega(S1, S2), MatePairs),
               ord_subtract(StudentPairs, MatePairs, L).

%# h) 
good_groups(L):- setof(S1-S2, (UC1, UC2)^(frequenta(S1, UC1), frequenta(S1, UC2), UC1 \= UC2, frequenta(S2, UC1), frequenta(S2, UC2), S1 \= S2), L).

%# 7.
%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

%# a)
same_day(UC1, UC2):- class(UC1, _, Day1, _, _), class(UC2, _, Day1, _, _).

%# b)
daily_courses(Day, Courses):- setof(Course, (ClassType, Time, Duration)^class(Course, ClassType, Day, Time, Duration), Courses).

%# c)
short_classes(L):- setof(Course, (ClassType, Day, Time, Duration)^(class(Course, ClassType, Day, Time, Duration), Duration @< 2), L).

%# d)
course_classes(Course, L):- setof(Day/Time-Type, Duration^class(Course, Type, Day, Time, Duration), L).

%# e)
courses(Courses):- setof(Course, (ClassType, Day, Time, Duration)^class(Course, ClassType, Day, Time, Duration), Courses).

%# f)
schedule:- setof(Day/Time/Duration-Course-Type, class(Course, Type, Day, Time, Duration), Classes),
           print_list(Classes).

print_list([]).
print_list([H|T]):- write(H), nl, print_list(T).

%# g)
convert_day('1 Seg', seg).
convert_day('2 Ter', ter).
convert_day('3 Qua', qua).
convert_day('4 Qui', qui).
convert_day('5 Sex', sex).

better_schedule:- setof(Day/Time/Duration-Course-Type, class(Course, Type, Day, Time, Duration), Classes),
                  print_schedule(Classes).

print_schedule([]).
print_schedule([H|T]):- convert(H, New),
                        write(New), nl,
                        print_schedule(T).

convert(Day/Time/Duration-Course-Type, BetterDay/Time/Duration-Course-Type):- convert_day(Day, BetterDay).

%# h)


