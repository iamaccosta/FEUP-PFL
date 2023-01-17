%# 1.
%# a)
:- dynamic male/1, female/1.

add_person:- write('male or female?'), nl,
             read(Gender),
             write('name?'), nl,
             read(Name),
             save_person(Gender, Name).

save_person(male, Name):- assert(male(Name)).
save_person(female, Name):- assert(female(Name)).

%# b)
:- dynamic parent/2.

add_parents:- write('Father?'), nl,
              read(Father),
              write('Mother?'), nl,
              read(Mother),
              write('Child?'), nl,
              read(Child),
              save_parent(Father, Child),
              save_parent(Mother, Child).

save_parent(Parent, Child):- assert(parent(Parent, Child)).  

%# c)
remove_person:- write('Person to remove?'), nl,
                read(Name),
                retract_person(Name),
                retract_all(parent(Name, _)),
                retract_all(parent(_, Name)).

retract_person(Name):- male(Name),
                       retract(male(Name)).
retract_person(Name):- female(Name),
                       retract(female(Name)).

%# 2.
%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

%# a)
get_all_nodes(ListOfAllNodes):- setof(Airport, (Orig, Dest, Comp, Code, Hour, Dura)^(flight(Orig, Dest, Comp, Code, Hour, Dura), (Orig=Airport; Dest= Airport)), ListOfAllNodes).

%# b)
most_diversified(Company):- 
    get_all_companies(ListOfCompanies),
    get_most_diversified(ListOfCompanies, 0, [], [Best|_Rest]),
    Company = Best.

get_all_companies(ListOfCompanies):-
    setof(Company, (Orig, Dest, Company, Code, Hour, Dura)^flight(Orig, Dest, Company, Code, Hour, Dura), ListOfCompanies).

get_most_diversified([],_,CurrentCompanies, Companies):- append([], [CurrentCompanies], Companies).
get_most_diversified([Current|Rest], CurrentLength, CurrentCompanies, Companies):-
    setof(Dest, (Orig,Dest,Current,Code,Hour,Dura)^flight(Orig,Dest,Current,Code,Hour,Dura), ListofDests),
    length(ListofDests, L),
    L > CurrentLength, !,
    append(CurrentCompanies, Current, New),
    get_most_diversified(Rest, L, New, Companies).
get_most_diversified([_|Rest], CurrentLength, CurrentCompanies, Companies):- get_most_diversified(Rest, CurrentLength, CurrentCompanies, Companies).

%# c)
connects_dfs(S, F, C) :- connects_dfs(S, F, [S], C).

connects_dfs(F, F, _Path, []).        
connects_dfs(S, F, T, [C | R]):- flight(S, N, _, C, _, _),
                           \+ member(N, T),
                           connects_dfs(N, F, [N|T], R).

find_flights(Or, Dest, Flights) :- connects_dfs(Or, Dest, Flights).


