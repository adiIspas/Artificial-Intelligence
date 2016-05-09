% Family tree when we will work.
/*
                            Anca + Vlad
                                /\
                               /  \
                              /    \
                 Cristi + Ioana   George + Alexandra
                       /\               /\
                      /  \             /  \
                     /    \           /    \
                   Ana  Bogdan      Dan   Elena
*/

% The women.
femeie(anca).
femeie(ioana).
femeie(alexandra).
femeie(ana).
femeie(elena).

% The men.
barbat(vlad).
barbat(cristi).
barbat(george).
barbat(bogdan).
barbat(dan).

% The parents.
parinte(anca,ioana).
parinte(anca,george).
parinte(vlad,ioana).
parinte(vlad,george).
parinte(cristi,ana).
parinte(cristi,bogdan).
parinte(ioana,ana).
parinte(ioana,bogdan).
parinte(george,dan).
parinte(george,elena).
parinte(alexandra,dan).
parinte(alexandra,elena).

% Mother and father.
% M = mother | T = father | C = child
mama(M,C) :- parinte(M,C), femeie(M).
tata(T,C) :- parinte(T,C), barbat(T).

% Husband and wife.
% Find just family which has a child.
% H = husband | W = wife | F = woman | B = man | C = child
sot(H,F) :- parinte(F,C), tata(H,C).
sotie(W,B) :- parinte(B,C), mama(W,C).

% Brother and sister.
% F = brother | S = sister | C = child
frate(F,C) :- mama(M,C), mama(M,F), F \== C, barbat(F).
sora(S,C) :- mama(M,C), mama(M,S), S \== C, femeie(S).

% Grandmother and grandfather.
% B = grandmother / grandfather | C = child | P = parent
bunic(B,C) :- parinte(P,C), tata(B,P).
bunica(B,C) :- parinte(P,C), mama(B,P).

% Uncle and aunt
% U = uncle | M = aunt | C = child | P = parent | S = sister | F = brother
unchi(U,C) :- parinte(P,C), (frate(U,P); sora(S,P), sot(U,S)).
matusa(M,C) :- parinte(P,C), (sora(M,P); frate(F,P), sotie(U,F)).

% Cousins
% V = cousin | C = child | U = uncle / aunt
var(V,C) :- (unchi(U,C); matusa(U,C)), parinte(U,V), barbat(V).
verisoara(V,C) :- (unchi(U,C); matusa(U,C)), parinte(U,V), femeie(V).

% Brother in law and sister in law
% B = brother / brother in law | S = sister / sister in law | C = child | P = parent | H = husband | W = wife
cumnat(B,C) :- (sora(S,C),sot(B,S)); (sot(H,C),frate(B,H)); (sot(H,C),sora(S,H),sot(B,S)); (sotie(W,C),frate(B,W)), \+frate(B,C).
cumnata(S,C) :- (frate(B,C), sotie(S,B)); (sotie(W,C),sora(S,W)); (sotie(W,C),frate(B,W),sotie(S,B)); (sot(H,C),sora(S,H)), \+sora(S,C).
