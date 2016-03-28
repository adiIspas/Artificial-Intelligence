%inserare_elem(E,Arb,ArbRez).
inserare_elem(E,nil,t(nil,E,nil)).
inserare_elem(E,t(S,E,D),t(S,E,D)).
inserare_elem(E,t(S,R,D),t(SS,R,D)):- E < R, inserare_elem(E,S,SS).
inserare_elem(E,t(S,R,D),t(S,R,DD)):- E > R, inserare_elem(E,D,DD).

%creare_arb_sortat(ListElem,Arb).
creare_arb_sortat([],nil).
creare_arb_sortat([H],t(nil,H,nil)).
creare_arb_sortat([H|L],A):-creare_arb_sortat(L,A1), inserare_elem(H,A1,A).

%inordine(Arb). | SRD
%inordine(t(nil,R,nil)):-write(R).
inordine(nil).
inordine(t(S,R,D)):-inordine(S),write(R),write(' '),inordine(D).

%preordine(Arb). | RSD
preordine(nil).
preordine(t(S,R,D)):-write(R),write(' '),preordine(S),preordine(D).

%postordine(Arb). | SDR
postordine(nil).
postordine(t(S,R,D)):-postordine(S),postordine(D),write(R),write(' ').

%inaltime(Arb,H).
inaltime(nil,0).
inaltime(t(S,_,D),H):- inaltime(S,H1), inaltime(D,H2), H is max(H1,H2) + 1.

%lista_frunze(Arb,L).
concat([],L,L).
concat([H|T],L,[H|L1]):-concat(T,L,L1).

lista_frunze(nil,[]).
lista_frunze(t(nil,R,nil),[R]).
lista_frunze(t(S,_,D),L):-lista_frunze(S,L1),lista_frunze(D,L2),concat(L2,L1,L).

%lista_noduri_interne(Arb,L).
lista_noduri_interne(nil,[]).
lista_noduri_interne(t(nil,_,nil),[]).
lista_noduri_interne(t(S,R,D),[R|L]):-lista_noduri_interne(S,L1),lista_noduri_interne(D,L2),concat(L2,L1,L).

%lista_muchii(Arb,L).
lista_muchii(nil,[]).
lista_muchii(t(nil,_,nil),[]).
lista_muchii(t(t(S1,S,S2),R,nil),[R - S|L]):-lista_muchii(t(S1,S,S2),L).
lista_muchii(t(nil,R,t(D1,D,D2)),[R - D|L]):-lista_muchii(t(D1,D,D2),L).
lista_muchii(t(t(S1,S,S2),R,t(D1,D,D2)),[R-S, R-D|L]):-lista_muchii(t(S1,S,S2),L1),lista_muchii(t(D1,D,D2),L2),concat(L1,L2,L).
