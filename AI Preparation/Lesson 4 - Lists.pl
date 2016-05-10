% Operations with lists.

% Merge one list to another list
% X = element of list | L, L1, L2 = list
concatenare([],L,L).
concatenare([X|L1],L,[X|L2]) :- concatenare(L1,L,L2).

% Reverse a list.
% X = element | L1, L2, LR = lists.
inversare([],[]).
inversare([X|L1],L2) :- inversare(L1,LR), concatenare(LR,[X],L2).
