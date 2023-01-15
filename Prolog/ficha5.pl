%# 1. Predicados de ordem superior
%# a)
double(X, Y):- Y is X*2.

map(_P, [], []).
map(P, [H|T], [R|L]):- G =.. [P, H, R],
                       G,
                       map(P, T, L).

%# b)
sum(A, B, S):- S is A+B.

fold(_P, SV, [], SV).
fold(P, SV, [H|T], Res):- G =.. [P, SV, H, Res1],
                          G,
                          fold(P, Res1, T, Res).

%# c)
even(X):- 0 =:= X mod 2.

separate([], _, [], []).
seperate([H|T], P, [H|Yes], No):- G =.. [P, H], 
                                  G,
                                  seperate(T, P, Yes, No).
seperate([H|T], P, Yes, [H|No]):- G =.. [P, H], 
                                  \+ G,
                                  seperate(T, P, Yes, No).
                
%# d)
ask_execute:- write('Insira o que deseja executar'),nl,
              read(C),
              C.


%# 2. Functor, Arg e Univ
