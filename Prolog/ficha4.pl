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