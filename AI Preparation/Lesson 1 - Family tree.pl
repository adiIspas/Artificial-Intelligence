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
