% EX 1 - 1
lista([],[]).
lista([X,Y],[Z]) :- Z is X + Y.
lista([X,Y|L],[Z|L1]) :- Z is X + Y, lista([Y|L],L1).

% EX 2 - 1
permutari(L,M) :- permutation(M,P), P == L.

% EX 3 - 1

%----------------------%

% EX 1 - 2
ponderi([],0).
ponderi([E/P],1) :- P > 0.
ponderi([E/P|L],N) :- P > 0, ponderi(L,N1), N is N1 + 1.
ponderi([E/P|L],N) :- ponderi(L,N).

% EX 2 - 2
suma_ponderi([],0).
suma_ponderi([E/P],P).
suma_ponderi([E/P|L],N) :- suma_ponderi(L,N1), N is N1 + P.

s_p(L,S) :- suma_ponderi(L,S1), S is (S1/2).

%ponderi_egale(L,L1,L2) :- s_p(L,S), ponderi_egale1(L,L1,L2,S).
ponderi_egale1([],[],[],_).
ponderi_egale1([E/P|L],[E/P|L1],L2,SM) :-  ponderi_egale1(L,L1,L2,SM), suma_ponderi(L1,S1), S1 + P < SM.
ponderi_egale1([E/P|L],L1,L2,SM) :-  ponderi_egale1(L,L1,L2,SM).
ponderi_egale1([E/P|L],L1,[E/P|L2],SM) :-  ponderi_egale1(L,L1,L2,SM), suma_ponderi(L2,S2), S2 + P < SM.
ponderi_egale1([E/P|L],L1,L2,SM) :-  ponderi_egale1(L,L1,L2,SM).

ponderi_egale(L,L1,L2) :- s_p(L,S), ponderi_egale2(L,L1,L2,S).
ponderi_egale2([],[],[],_).
ponderi_egale2([E1/P1,E2/P2|L],[E1/P1|L1],[E2/P2|L2],SM) :- ponderi_egale2(L,L1,L2,SM), suma_ponderi(L1,S1), suma_ponderi(L2,S2), S1 + P1 =< SM, S2 + P2 =< SM.
ponderi_egale2([E1/P1,E2/P2|L],[E2/P2|L1],[E1/P1|L2],SM) :- ponderi_egale2(L,L1,L2,SM), suma_ponderi(L1,S1), suma_ponderi(L2,S2), S2 + P1 =< SM, S1 + P2 =< SM.
ponderi_egale2([E1/P1|L],[E1/P1|L1],L2,SM) :- ponderi_egale2(L,L1,L2,SM), suma_ponderi(L1,S1), S1 + P1 =< SM.
ponderi_egale2([E1/P1|L],L1,[E1/P1|L2],SM) :- ponderi_egale2(L,L1,L2,SM), suma_ponderi(L2,S2), S2 + P1 =< SM.

% EX 3 - 2
