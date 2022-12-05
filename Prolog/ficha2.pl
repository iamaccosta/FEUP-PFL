%# SECOND SHEET

%# Recursion

%# we have fact(N,F).
%# lets say we have fact(1,1).
%#
%# base case: fact(1,1).
%# general case: fact(N,F):- N > 1,
%#                           N1 is N-1,
%#                           fact(N1,F1),
%#                           F is F1*N.
%#
%#   N>1 is a guard -> it means we only enter the rule if this is true.
%#       So if we call fact with a negataive numebr it does not enter this rule.
%#   Guards is a good way oso safe programming because we make sure we only enter the rule
%#   if this is correct.
%#   
%#   when we have "is" then we are going to evaluate N-1 as math function.
%#       but we have to make sure everything after "is" has been instaciated.

%# Prolog operators
%#
%# Prolog has differen operator for doing things:
%#   =    Unification operator, "two things CAN be the same, it doesn't mean it have to be instaciated"
%#   ==   Equal, "two things is the same type and variable"
%#   =:=  Expression on two sames, evalueate and see if results are the same
%#   is   Take an expression on right side and assigns to variable on the left. also to verify expressions.
%#           10 is 5*2 yes.  OBS: both sides have beeninstaciated
%#           A is 5*2  A = 10?
%#   \=   Two things are not the same, never.  
%#   \==  Negation of ==
%#   =\=  Negation of =:=, two results are not the same.
%#   <
%#   >
%#   >=
%#   =<   OBS: Prolog weridness, just memorize it.(equals no the left when less of equal).
%#   @>   @ is used for ordering!!!!
%#   @<
%#   @>=
%#   @=<

%# "bad" operators
%#   ";"    means "or"
%#       parents(A,B):- mother(A,B);father(A,B).   
%#           a better way to define this would be:
%#       parents(A,B):- mother(A,B).
%#       parents(A,B):- father(A,B).
%#       
%#       if using ";" use parenthesis to make sure we know what is being divided.
%#       only use it with very large rules, CAUTION.
%#
%#   ->     can be used to make and "if"
%#       A-> B;C
%#           if A is true execute B...
%#       AVOID TRYING TO USE IF!

%#   + is is an input -> value has to be instaciated
%#   - it is not an input and will be calculated
%#   ? can be both, depends on the situation


%# 1 - Recurcivity
%# a)
fact(1,1).
fact(N,F):- N > 1, N1 is N-1, fact(N1,F1), F is F1*N.

%# b)
somaRec(1,1).
somaRec(N, Sum):- N > 1,
                   N1 is N-1,
                   somaRec(N1,Sum1),
                   Sum is Sum1+N.

%# c)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):- N > 1,
                   N1 is N-1,
                   N2 is N-2,
                   fibonacci(N1,F1),
                   fibonacci(N2,F2),
                   F is F1+F2.

%# d)
divisible(X,Y) :- 0 is X mod Y.
divisible(X,Y) :- Y < X - 1,
                  Y1 is Y+1,
                  divisible(X, Y1).

isPrime(2).
isPrime(X) :- X > 1, 
              \+divisible(X, 2).

%# Tail recursion
%# 
%# fact(N, F):- fact(N, 1, F).
%#
%# fact(1, Acc, Acc).
%# base case: fact(N,Acc,F):- N > 1,
%#                            NAcc is Acc * N,
%#                            N1 is N - 1,
%#                            fact(N1, NAcc, F).


%# 2.
%# a)
ancestor(X, Y):- parent(X, Y). 
ancestor(X, Y):- parent(X, Z), 
                  ancestor(Z, Y). 

%# b)
descendant(X, Y):- ancestor(Y, X).

%# 3.
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

superior(X, Y) :- cargo(C1, X), cargo(C2, Y), chefiado_por(C2, C1).
superior(X, Y) :- cargo(C, Y), chefiado_por(C, W), cargo(W, P), superior(X, P).


%# 4.
%# a) True
%# b) False, tail must be a list
%# c) True, [a | [b, c, d]] = [a | [b | [c, d]]] = [a | [b | [c | d]]]
%# d) True
%# e) True, [H|T] both can be just one element
%# f) True, Tail can be []
%# g) False, [H|T] H needs to be a element
%# h) True, T can be a list inside a list
%# i) True, T can be a variable
%# j) True, if Inst = gram && LEIC = feup
%# k) True, Head can be more than one element
%# l) True, if One = leic && (Two | Tail) = Rest

%# 5.
%# a)
list_size([], 0).
list_size([_|T], Size):- list_size(T, Aux),
                         Size is Aux+1.

%# b)
list_sum([H], H).
list_sum([H|T], Sum):- list_sum(T, Aux),
                       Sum is H + Aux.

%# c)
list_prod([H], H).
list_prod([H | T], P):- list_prod(T, P1),
                        P is H*P1.

%# d) 
inner_prod([], [], 0).
inner_prod([H1|T1], [H2|T2], Res):- inner_prod(T1, T2, R),
                                    Res is H1*H2 + R.

%# e)
count(_, [], 0).
count(X, [X|T], N):- count(X, T, N1),
                     N is N1+1.
count(X, [_|T], N):- count(X, T, N).

%# 6.
%# a)
invert(List, Res):- invert(List, [], Res).
invert([H|T], Aux, Res):- invert(T, [H|Aux], Res).
invert([], Res, Res).

%# b)
del_one(_, [], []).
del_one(H, [H|T], T).
del_one(X, [H|T], Res):- X\=H, del_one(X, T, Res1),
                         Res = [H|Res1].

%# c)
del_all(_, [], []).
del_all(X, [X|T], Res):- del_all(X, T, Res).
del_all(X, [H|T], Res):- X\=H, del_all(X, T, Res1),
                         Res = [H|Res1].

%# d)
del_all_list(_, [], []).
del_all_list([H|[]], L2, Res):- del_all(H, L2, Res).
del_all_list([H|T], L2, Res):- del_all(H, L2, Res1), 
                               del_all_list(T, Res1, Res).

%# g)
replicate(0, _, []).
replicate(N, Elem, Res):- N1 is N-1, 
                          replicate(N1, Elem, Res1),
                          Res = [Elem|Res1].

%# h)
intersperse(_, [H|[]], [H]).
intersperse(Elem, [H|T], Res):- intersperse(Elem, T, Res1),
                                Res = [H,Elem|Res1].

%# i)
insert_elem(0, [H|T], Elem, [Elem, H |T]).
insert_elem(Pos, [H|T], Elem, Res):- Pos1 is Pos-1,
                                     insert_elem(Pos1, T, Elem, Res1),
                                     Res = [H|Res1].

%# j)
delet_elem(0, [H|T], H, T).
delet_elem(Pos, [H|T], Elem, Res):- Pos1 is Pos - 1,
                                    delet_elem(Pos1, T, Elem, Res1),
                                    Res = [H|Res1].

%# 7.
%# a)
list_append([], L2, L2). 
list_append([H|T1], L2, [H|T3]):- list_append(T1, L2, T3).

%# b)
list_member(Elem, List):- list_append(_Part1, [Elem | _Part2], List).

%# c)
list_last(List, Last):- list_append(_ExceptLast, [Last | []], List).

%# d)
list_nth(N, List, Elem):- list_append(Part1, [Elem | _Part2], List),
                          length(Part1, N).

%# e)
list_concat([L1|[]], Res):- L1 = Res.
list_concat([L1|Rest], Res):- list_append(L1, LRem, Res),
                              list_concat(Rest, LRem).

%# f)
list_del(List, Elem, Res):- list_append(Part1, [Elem | Part2], List),
                            list_append(Part1, Part2, Res).

%# g)
list_before(First, Second, List):- list_append(_Part1, [First|Rest1], List),
                                   list_append(_Part2, [Second|_Rest2], Rest1).

%# h)
list_replace_one(X, Y, List1, List2):- list_append(Part1, [X|Rest1], List1),
                                       list_append(Part1, [Y|Rest1], List2).

%# i)
list_repeated(X, List):- list_append(_Part1, [X|Rest1], List),
                         list_append(_Part2, [X|_Rest2], Rest1).

%# j)
list_slice(List, Index, Size, List2):-  

%# k)

%# 8.

%# 9.

%# 10.

%# 11.
