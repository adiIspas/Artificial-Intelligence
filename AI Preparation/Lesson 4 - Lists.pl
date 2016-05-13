% Operations with lists.

% Merge one list to another list
% X = element of list | L, L1, L2 = list
concatenare([],L,L).
concatenare([X|L1],L,[X|L2]) :- concatenare(L1,L,L2).

% Reverse a list.
% X = element | L1, L2, LR = lists
inversare([],[]).
inversare([X|L1],L2) :- inversare(L1,LR), concatenare(LR,[X],L2).

% Find the minimum element.
% X,Y = elements | L = list | M = minimum element
minimum([X|L],M) :- min(X,L,M).
min(X,[Y|L],M) :- X < Y, min(X,L,M).
min(X,[Y|L],M) :- X > Y, min(Y,L,M).
min(X,[],X).

% Get element at position.
% X = element at position P | P = position | L = list | P1 = current position
element_pozitie([X|_],1,X).
element_pozitie([_|L],P,X) :- P1 is P - 1, element_pozitie(L,P1,X).

% Insert element at position.
% E = element to insert | L, L1 = lists | P = position | P1 = current position
inserare_pozitie(L,1,E,[E|L]).
inserare_pozitie([X|L],P,E,[X|L1]) :- P1 is P - 1, inserare_pozitie(L,P1,E,L1).

% Split a list in two another lists.
% A, S, D = elements | L1, L2, L = lists
imparte([],[],[]).
imparte([A],[A],[]).
imparte([S,D|L],[S|L1],[D|L2]) :- imparte(L,L1,L2).

% Merge two ordered lists in one list.
% X, Y = elements | L,R,LR = lists
interclaseaza(L,[],L).
interclaseaza([],L,L).
interclaseaza([X|L],[Y|R],[X|LR]) :- X =< Y, interclaseaza(L,[Y|R],LR).
interclaseaza([X|L],[Y|R],[Y|LR]) :- X > Y, interclaseaza([X|L],R,LR).

% Mergesort
% X = element | L, L1, L2, LS, LR = lists | SL = ordered list
mergesort([],[]).
mergesort([X],[X]).
mergesort(L,SL) :- imparte(L,L1,L2), mergesort(L1,LS), mergesort(L2,LR), interclaseaza(LS,LR,SL).
