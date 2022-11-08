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

% auxiliar
parents(X,Y,Z):-parent(X,Z),parent(Y,Z),X\=Y.

% c)
father(F,S):-parent(F,S),male(F). 
grandparent(G,_S):-parent(G,_X),parent(_X,_S).
grandmother(M,N):-grandparent(M,N),female(M).
sibling(_X,_Y):-parents(A,B,_X),parents(A,B,_Y), _X\=_Y.
halfsibling(_X,_Y):-father(F,_X),father(F,_Y), \+(sibling(_X,_Y)), _X\=_Y.
cousins(_X,_Y):-parent(A,_X),parent(B,_Y),sibling(A,B).
cousins(_X,_Y):-parent(A,_X),parent(B,_Y),halfsibling(A,B).
uncle(_U,_X):-parent(Y,_X),sibling(_U,Y), male(_U).
uncle(_U,_X):-parent(Y,_X),halfsibling(_U,Y), male(_U).

% e não sei resolver

% 2.
% a)

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

% c)
alunoProf(X,Y):-frequenta(X,Z), leciona(Y,Z).
alunos(Y,_X):-frequenta(_X,Z), leciona(Y,Z).
profs(X,_Y):-frequenta(X,_Z), leciona(_Y,_Z).
iv(X,Y,_Z):-alunoProf(_Z,X), alunoProf(_Z,Y), X\=Y.
colega(X,Y):-leciona(X,A), leciona(Y,B), A\=B.
colega(X,Y):-frequenta(X,_Z), frequenta(Y,_Z), X\=Y.
empenhados(X):-frequenta(X,A), frequenta(X,B), A\=B.

% 3.

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

% b)
% i. victory(X,porto).
% ii. teamVictory(X,porto).
% iii. circuit(X), gates(X,Y), Y>8.
% iv. aviao(X,Y), Y\='Edge540'.
% v.
% vi. 

% 4.