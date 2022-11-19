% 1.
% a)
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

%# auxiliar
parents(X,Y,Z):-parent(X,Z),parent(Y,Z),X\=Y.

%# c)
father(F,S):-parent(F,S),male(F). 
grandparent(G,_S):-parent(G,_X),parent(_X,_S).
grandmother(M,N):-grandparent(M,N),female(M).
sibling(_X,_Y):-parents(A,B,_X),parents(A,B,_Y), _X\=_Y.
halfsibling(_X,_Y):-father(F,_X),father(F,_Y), \+(sibling(_X,_Y)), _X\=_Y.
cousins(_X,_Y):-parent(A,_X),parent(B,_Y),sibling(A,B).
cousins(_X,_Y):-parent(A,_X),parent(B,_Y),halfsibling(A,B).
uncle(_U,_X):-parent(Y,_X),sibling(_U,Y), male(_U).
uncle(_U,_X):-parent(Y,_X),halfsibling(_U,Y), male(_U).

%# e) 
%# marriage('Jay', 'Dede', 1968) 
%# divorce('Jay', 'Dede', 2003)

%# 2.
%# a)

leciona(adalberto,algoritmos).
leciona(bernardete,'bases de dados').
leciona(capitolino,compiladores).
leciona(diogenes,estatistica).
leciona(ermelinda,redes).

frequenta(alberto,algoritmos).
frequenta(bruna,algoritmos).
frequenta(cristina,algoritmos).
frequenta(diogo,algoritmos).
frequenta(eduarda,algoritmos).
frequenta(antonio,'bases de dados').
frequenta(bruno,'bases de dados').
frequenta(cristina,'bases de dados').
frequenta(duarte,'bases de dados').
frequenta(eduardo,'bases de dados').
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

%# c)
alunoProf(X,Y):-frequenta(X,Z), leciona(Y,Z).
alunos(Y,_X):-frequenta(_X,Z), leciona(Y,Z).
profs(X,_Y):-frequenta(X,_Z), leciona(_Y,_Z).
iv(X,Y,_Z):-alunoProf(_Z,X), alunoProf(_Z,Y), X\=Y.
colega(X,Y):-leciona(X,A), leciona(Y,B), A\=B.
colega(X,Y):-frequenta(X,_Z), frequenta(Y,_Z), X\=Y.
empenhados(X):-frequenta(X,A), frequenta(X,B), A\=B.

%# 3.

pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(macLean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb,breitling).
team(besenyei,'Red Bull').
team(chambliss,'Red Bull').
team(macLean,'Mediterranean Racing Team').
team(mangold,cobra).
team(jones,matador).
team(bonhomme,matador).

aviao(lamb,'MX2').
aviao(besenyei,'Edge540').
aviao(chambliss,'Edge540').
aviao(macLean,'Edge540').
aviao(mangold,'Edge540').
aviao(jones,'Edge540').
aviao(bonhomme,'Edge540').

circuit(istanbul).
circuit(budapest).
circuit(porto).

victory(jones,porto).
victory(mangold,budapest).
victory(mangold,istanbul).

gates(istanbul,9).
gates(budapest,6).
gates(porto,5).

teamVictory(X,_Z) :- team(Y,X),victory(Y,_Z).

%# b)
% i. victory(X,porto).
% ii. teamVictory(X,porto).
% iii. circuit(X), gates(X,Y), Y>8.
% iv. aviao(X,Y), Y\='Edge540'.
% v. victory(V, C1), victory(V, C2), C1 @< C2.
% vi. aviao(P, X), victory(P, porto).

%# 4.
traduz(1, 'Integer Overflow').
traduz(2, 'Divisao por zero').
traduz(3, 'ID Desconhecido').

%#######################################################################################
%# prolog index by the name and by the first argument.
%# it is a good practice to use this as a way to make it faster (first argument as index)
%# prolog works top down, left to right, with backtracking.
%# order of predicate is important in terms of correctness and efficiency.
%# for example if we have:
%# father(x,y):- parent(x,y), male(x).
%# first we try to solve for parent then for male.%# 
%# top down searching for a match.
%# in a function left to right trying to solve each predicate.%# 
%# Functioning of a call diagram:
%# 
%#                +----------------------------+
%#    call        |                            |  exit [yes]
%#   ---------->  | -----> D ----------+-------+ --------------> +
%#                |        |           |       |                 |
%#     fail       |        |           |       |   redo          |
%#   <----------- +--------+---------- D ------+ <------------ <-+
%#     [no]       |                            |
%#                +-----------+-----------------
%#                            |
%#                <-----------+
%#                   exception
%# 
%#      N    S    Call |    Depth |   Port                 |   goal
%#      ?          ID  |     1    |   one of those on top  |   father(X,'Luke').
%#                                                         |   parent(X,'Luke').
%# OBS: D is possible paths to take.%# 
%# use trace to view these calls, it helps understand with recursion (normal vs tail).
%# btw, tail is more efficient.
%# basically, user trace for debbuging.%# 
%# underscore and a number means the memory position of it.
%#######################################################################################

%# 5.
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

%# a)
%# i. Cargo do sisnando que chefia um analista
%# ii. Cargo que chefia o cargo que chefia tecnico.
%# iii. Cargos e pessoas que têm como chefe um supervisor
%# iv. Cargo chefiado por um diretor sem ser o da felismina.

%# b)
%# i. supervisor
%# ii. engenheiro,
%#     supervsor ?
%# iii. analista,
%#      leonilde ?
%# iv. supervisor_chefe ?

%# c)
%# i.
chefe_de(X,Y) :- cargo(C, X), cargo(B, Y), chefiado_por(C,B), B \= C.  %# C - cargo, B - cargo boss

%# 6. Backtracking e Árvore de Pesquisa
pairs(X, Y):- d(X), q(Y).
pairs(X, X):- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).

%# the trace of calling: pairs(X, Y).
%# pairs(X, Y).
%#   d(X) -> d(2) X = 2
%#       q(Y) -> q(4) Y = 4 --> X = 2, Y = 4 ? ;
%#       q(y) ->  q(16) Y = 16 --> x = 2, Y = 16 ? ;
%#   d(X) - > d(4) X = $
%#       q(Y) -> q(4) Y = 4 --> X = 4, Y = 4 ? ;
%#       q(y) ->  q(16) Y = 16 --> x = 4, Y = 16 ? ;
%# pairs(X,X).
%#   u(X) --> X = 1 , y = 1 ? ;
%# no

%# the trace of calling: pairs(X, X).
%# pairs(X, Y).
%#   d(X) -> d(4) X = 4
%#       q(X) -> q(4) Y = 4 --> X = 4, Y = 4 ? ;
%# pairs(X,X).
%#   u(X) --> X = 1 , y = 1 ? ;
%# no 

%# 7. Funcionamento do Backtracking
% a(a1, 1).
% a(A2, 2).
% a(a3, N).
% b(1, b1).
% b(2, B2).
% b(N, b3).
% c(X, Y):- a(X, Z), b(Z, Y).
% d(X, Y):- a(X, Z), b(Y, Z).
% d(X, Y):- a(Z, X), b(Z, Y).

%# a)
%# i. a(A, 2).        
%#     respostas: A = a3, N = 2
%# ii. b(A, foobar).  
%#     respostas: A = 2 B2=foobar
%# iii. c(A, b3).     
%#     respostas: Y=b3, Z=1, X=a1 =A (N=1)
%# iv. c(A, B).      
%#     respostas: Z=1, X= a1, Y=b1
%#                z=2, X= a1, Y=b3
%#                z=N, X=a3 , Y=b3
%# v. d(A, B).       
%#     respostas: X=a1, Y=2
%#                X=a3, Y=1
%#                X=a3, Y=2
%#                X=1, Y=b3 
%#                X=2, Y=b1
%#                X=2, Y=b3


%# for example if a(X,2) is called then it doesn't matter what the first argument is
%# as long as 2 exists then it is true. This is because we have a(A2,2).
%# This is also valid for the other ones.
