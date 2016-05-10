% Multimi

%
membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

%
concatenare([],L,L).
concatenare([X|L1],L,[X|L2]) :- concatenare(L1,L,L2).

%
multime([]).
multime([X|L]) :- \+membru(X,L), multime(L).

%
transformare([],[]).
transformare([X|L1],[X|L2]) :- \+membru(X,L1), transformare(L1,L2).
transformare([X|L1],L2) :- membru(X,L1), transformare(L1,L2).
