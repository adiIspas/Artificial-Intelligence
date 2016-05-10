% Sets of natural numbers

% Check if the element is a member in set.
% X = element of list | L = list
membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

% Merge one list to another list
% X = element of list | L, L1, L2 = list
concatenare([],L,L).
concatenare([X|L1],L,[X|L2]) :- concatenare(L1,L,L2).

% Check the set.
% X = element of list | L = list
multime([]).
multime([X|L]) :- \+membru(X,L), multime(L).

% Transform list into set.
% X = element of list | L, L1, L2 = list
transformare([],[]).
transformare([X|L1],[X|L2]) :- \+membru(X,L1), transformare(L1,L2).
transformare([X|L1],L2) :- membru(X,L1), transformare(L1,L2).

% Intersection of sets.
% X = element of list | L, L1, L2 = list
intersectie([],[],[]).
intersectie(L1,L2,L) :- setof(X,(membru(X,L1),membru(X,L2)),L).

% Reunion of sets.
% X = element of list | L, L1, L2 = list
reuniune([],[],[]).
reuniune(L1,L2,L) :- setof(X,(membru(X,L1);membru(X,L2)),L).

% Difference of sets.
% X = element of list | L, L1, L2 = list
diferenta([],[],[]).
diferenta(L1,L2,L) :- setof(X,(membru(X,L1),\+membru(X,L2)),L).

% Insert at 0 position.
% X = element of list | L = list
inserare(X,L,[X|L]) :- \+membru(X,L).
