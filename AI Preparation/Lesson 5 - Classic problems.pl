% Check if the element is a member in set.
% X = element of list | L = list
membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

% Count number of elemtents from a list.
% X = number | L = list | R = result | R1 = auxiliar term
numar([],0).
numar([_|L],R) :- numar(L,R1), R is R1 + 1.

% Eight queens puzzle
conflict_dame(A/B,T) :- membru(C/D,T), (A == C; B == D; abs(A - C) =:= abs(B - D)).
dame([]).
dame([A/B|T]) :- dame(T), membru(B,[1,2,3,4,5,6,7,8]), \+conflict_dame(A/B,T).

numar_solutii_dame(X):- L = [1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_], setof(L,dame(L),LRez), numar(LRez,X).

% Four color map problem.
vecini(ro,[mneagra, mold, ucr, ung, bulg, serb]).
vecini(mneagra,[ro,bulg,ucr]).
vecini(mold,[ro,ucr]).
vecini(ucr,[ro,mneagra,ung,mold]).
vecini(ung,[ro,serb,ucr]).
vecini(bulg,[ro,mneagra,serb]).
vecini(serb,[ro,bulg,ung]).

conflict2(A/B,T):-membru(C/D,T), B == D, vecini(A,L), membru(C,L).
colorare([]).
colorare([A/B|T]):-colorare(T),membru(B,[rosu,albastru,galben,verde]),\+conflict2(A/B,T).

numarr_solutii_colorare(X):- L = [ro/_,mneagra/_,mold/_,ucr/_,ung/_,bulg/_,serb/_], setof(L,colorare(L),LRez), numar(LRez,X).

% Hanoi towers problem.
hanoi(1,A,B,_):-write(' de pe '), write(A), write(' pe '), write(B), write('; \n').
hanoi(N,A,B,C):-N1 is N - 1, hanoi(N1,A,C,B),hanoi(1,A,B,C),hanoi(N1,C,B,A).
