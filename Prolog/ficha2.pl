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

%# a

fact(1,1).
fact(N,F):- N > 1, N1 is N-1, fact(N1,F1), F is F1*N.

%# b

somaRec(1,1).
somaRec(N, Sum):- N > 1,
                   N1 is N-1,
                   somaRec(N1,Sum1),
                   Sum is Sum1+N.

%# c

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):- N > 1,
                   N1 is N-1,
                   N2 is N-2,
                   fibonacci(N1,F1),
                   fibonacci(N2,F2),
                   F is F1+F2.

%# d

isPrime(1,1).
isPrime(X):- N>1,
             N1 is N-1,
             isPrime()

%# Tail recursion
%# 
%# fact(N, F):- fact(N, 1, F).
%#
%# fact(1, Acc, Acc).
%# base case: fact(N,Acc,F):- N > 1,
%#                            NAcc is Acc * N,
%#                            N1 is N - 1,
%#                            fact(N1, NAcc, F).