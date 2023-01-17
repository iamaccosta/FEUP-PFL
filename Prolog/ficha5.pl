:- use_module(library(lists)).

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
%# a)
my_arg(Index, Term, Arg):-
    Term=.. [_Name | Args],
    nth1(Index, Args, Arg).

%# b)
get_args(N, _, Arity, []):- N is Arity+1.
get_args(N, Term, Arity, [H|Rest]):-
    arg(N, Term, H),
    NewN is N+1,
    get_args(NewN, Term, Arity, Rest).

my_univ(Term, [Name|Args]):-
    functor(Term, Name, Arity),
    get_args(1, Term, Arity, Args).

%# c)
:-op(500, xfx, univ).

%# 3.
:-op(500, xfx, na).
:-op(500, yfx, la).
:-op(500, xfy, ra).

%# (na) - não pode ter filhos com mesma precedência
%# (la) - pode ter filhos com mesma precedencia à esquerda
%# (ra) - pode ter filhos com mesma precedencia à direita

%# a) a ra b na c
% a xfy b xfx c
% a xfy (b xfx c)
% OK
/*
    ra
   /  \
  a   na
     /  \
    b     c
*/

%# b) a la b na c
% a yfx b xfx c
% [LA wants:] (a yfx b) xfx c // [NA wants:] a yfx (b xfx c)
% CONFLICT

%# c) a na b la c
% a xfx b yfx c
% (a xfx b) yfx c
% OK
/*
    la
   /  \
  na   c
 /  \
a    b
*/

%# d) a na b ra c
% a xfx b xfy c
% [NA wants:] (a xfx b) xfy c // [RA wants:] a xfx (b xfy y)
% CONFLICT

%# e) a na b na c
% a xfx b xfx c
% [NA1 wants:] (a xfx b) xfx c
% [NA2 wants:] a xfx (b xfx c)
% CONFLICT

%# f) a la b la c
% a yfx b yfx c
% (a yfx b) yfx c
% OK
/*
    la
   /  \
  la   c
 /  \
a    b
*/

%# h) a ra b ra c
% a xfy b xfy c
% a xfy (b xfy c)
% OK
/*
    ra
   /  \
  a   ra
     /  \
    b    c
*/

%# 4.
:-op(550, xfx, de).
:-op(500, fx, aula).
:-op(550, xfy, pelas).
:-op(550, xfx, e).
:-op(600, xfx, as).

%# a) aula t de pfl as segundas pelas 11
% fx t xfx pfl xfx segundas xfy 11
% ((fx t) xfx pfl) xfx (segundas xfy 11)
% OK
/*
              as
        /            \
       de           pelas 
     /    \       /       \
   aula   pfl segundas    11
       \
        t  
*/

%# b) aula tp de pfl as tercas pelas 10 e 30
% fx tp xfx pfl xfx tercas xfy 10 xfx 30
% ((fx t) xfx pfl) xfx (tercas xfy (10 xfx 30))
% OK
/*
              as
        /           \
       de          pelas 
     /    \       /     \
   aula   pfl   tercas   e
       \               /   \
        t             10   30
*/

%# c) aula 11 e aula 12 as 4 pelas cinco pelas 6 pelas sete
% fx 11 xfx fx 12 xfx 4 xfy cinco xfy 6 xfy sete
% ((fx 11) xfx (fx 12)) xfx (4 xfy (cinco xfy (6 xfy sete)))
% OK
/*
                 as
        /                  \
       e                  pelas
   /       \            /       \
 aula      aula        4       pelas 
     \         \             /       \
     11        12         cinco     pelas
                                   /     \
                                  6      sete   
*/

%# 5.
%# a) flight tp1949 from porto to lisbon at 16:15
% flight fx tp1949 xfx porto xfy lisbon xfy 16:15
:-op(500, fx, flight).
:-op(600, xfx, from).
:-op(550, xfy, to).
:-op(550, xfy, at).
:-op(500, xfx, :).
flight tp1949 from porto to lisbon at 16:15.

%# b) if X then Y else Z
:-op(550, fx, if).
:-op(600, xfx, then).
:-op(550, xfy, else).
if X then Y else _Z :- X, Y.
if X then _Y else Z :- \+ X, Z.
