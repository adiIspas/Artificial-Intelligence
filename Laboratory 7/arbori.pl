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

%caut(E, Arb, ArbRez) - caut cel mai din stanga (cel mai mic) nod din arbore si il sterg
caut(R,t(nil,R,D),D):-!.
caut(E,t(S,R,D),t(S1,R,D)):-caut(E,S,S1).

%sterg(E,Arb,ArbRez) - stergerea unui nod dintr-un arbore
sterg(R,t(nil,R,nil),nil).
sterg(R,t(nil,R,D),D):-!.
sterg(R,t(S,R,nil),S):-!.
sterg(R,t(S,R,D),t(S,R1,DD)):-caut(R1,D,DD).
sterg(E,t(S,R,D),t(S,R,DD)):- E > R, sterg(E,D,DD).
sterg(E,t(S,R,D),t(SS,R,D)):- E < R, sterg(E,S,SS).

%grafuri%
%adiacent(A,B)
membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).
graf([1-2,1-3,2-7,3-4,3-5,4-8,5-8,6-7,6-9,7-8,8-9,10-11]).
adiacent(A,B):-graf(G), (membru(A-B,G); membru(B-A,G)).

%drum_aciclic(A,B,G,D)
drum_aciclic(A,B,G,D):-drum1(A,[B],G,D).
drum1(A,[A|T],_,[A|T]):-!.
drum1(A,[H|T],G,D):- adiacent(E,H), not(membru(E,[H|T])), drum1(A,[E,H|T],G,D).

%grad_nod(N,G,Grad).
grad(N,_,X):- setof(V,adiacent(N,V),L), length(L,X).

%lista_noduri(G,L).
lista_noduri(G,L):- findall(X,(membru(X-Y,G);membru(Y-X,G)),L1), setof(X,membru(X,L1),L).

%conex(G).
%conex(G):-\+ neconex(G).
%neconex(G,X1,X2):- (findall(X,adiacent(X,E),L1), setof(X,membru(X,L1),L), lista_noduri(G,LL)), length(L,X1), length(LL,X2), X1 =< X2.
%neconex(G):- lista_noduri(G,L), (membru(X,L), membru(Y,L), drum_aciclic(X,Y,G,D)).

%aciclic(G).
%aciclic(G):-\+ciclic(G).

%este_arbore(G).

%transformare_graf_arbore(G,A).

























