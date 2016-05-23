% Subiect A2, B2, C1

% S1 A2
% Scrieti un predicat lista_multiplii(N,P,L) care primeste doua numere naturale N si P si returneaza o lista L cu primii P multiplii nenuli ai lui N.
% lista_multiplii(Numar,NumarMultiplii,ListaRezultata).

lista_multiplii(_,0,[]).
lista_multiplii(N,P,[A|L]) :- A is N * P, P1 is P - 1, lista_multiplii(N,P1,L).

% S2 B2
% Scrieti un predicat elemente_impare_nu9(L,R) care primeste o lista L de numere intregi si returneaza o lista R cu elemente din L care sunt numere impare, dar nu divizibile cu 9.
% Apel: elemente_impare_nu9(Lista,ListaRezultata).

impar(E) :- Y = E // 2, Y * 2 =\= E.
divizibil9(E) :- Y = E // 9, Y * 9 =:= E.

elemente_impare_nu9([],[]).
elemente_impare_nu9([E],[E]) :- impar(E), \+divizibil9(E).
elemente_impare_nu9([E],[]) :- \+impar(E); divizibil9(E).
elemente_impare_nu9([E|L],[E|L1]) :- elemente_impare_nu9(L,L1), impar(E), \+divizibil9(E).
elemente_impare_nu9([E|L],L1) :- elemente_impare_nu9(L,L1), (\+impar(E); divizibil9(E)).

% S3
% Scrieti un predicat egal_numar_descendenti(A,L) care primeste un arbore binar A de numere intregi si returneaza o lista L cu elementele din A care sunt egale in modul cu nr. tuturor descendentilor nodului respectiv.
% Apel: egal_numar_descendenti(Arbore,ListaRezultata).

concat([],L,L).
concat([H|L1],L,[H|L2]) :- concat(L1,L,L2).

egal_numar_descendenti(nil,[]).
egal_numar_descendenti(t(nil,R,D),[R|L]) :- egal_numar_descendenti(D,L), numar_descendenti(D,N2), N is N2, egal_modul(R,N).
egal_numar_descendenti(t(S,R,nil),[R|L]) :- egal_numar_descendenti(S,L), numar_descendenti(S,N1), N is N1, egal_modul(R,N).
egal_numar_descendenti(t(S,R,D),[R|L]) :- egal_numar_descendenti(S,L1), egal_numar_descendenti(D,L2), concat(L1,L2,L),
                                          numar_descendenti(S,N1), numar_descendenti(D,N2), N is N1 + N2, egal_modul(R,N).

egal_numar_descendenti(t(nil,R,D),L) :- egal_numar_descendenti(D,L), numar_descendenti(D,N2), N is N2, \+egal_modul(R,N).
egal_numar_descendenti(t(S,R,nil),L) :- egal_numar_descendenti(S,L), numar_descendenti(S,N1), N is N1, \+egal_modul(R,N).
egal_numar_descendenti(t(S,R,D),L) :- egal_numar_descendenti(S,L1), egal_numar_descendenti(D,L2), concat(L1,L2,L),
                                      numar_descendenti(S,N1), numar_descendenti(D,N2), N is N1 + N2, \+egal_modul(R,N).

numar_descendenti(nil,0).
numar_descendenti(t(S,_,D),N) :- numar_descendenti(S,N1), numar_descendenti(D,N2), N is N1 + N2 + 1.

egal_modul(R,N) :- R < 0, R1 is R * -1, R1 =:= N.
egal_modul(R,N) :- R > 0, R1 is R, R1 =:= N.
