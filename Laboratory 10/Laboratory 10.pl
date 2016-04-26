%Predicatul bestfirst(Nod_initial,Solutie) este adevarat daca
%Solutie este un drum (obtinut folosind strategia best-first) de
%la nodul Nod_initial la o stare scop

bestfirst(Nod_initial,Solutie):-expandeaza([],l(Nod_initial,0/0),9999999,_,da,Solutie).
expandeaza(Drum,l(N,_),_,_, da,[N|Drum]):-scop(N).

%Caz 1: daca N este nod scop, atunci construim o cale solutie

expandeaza(Drum,l(N,F/G),Limita,Arb1,Rez,Sol):-F=<Limita,(bagof(M/C,(s(N,M,C), \+ (membru(M,Drum))),Succ),!,listasucc(G,Succ,As),cea_mai_buna_f(As,F1),expandeaza(Drum,t(N,F1/G,As),Limita,Arb1, Rez,Sol);Rez=imposibil).

% Caz 2: Daca N este nod frunza a carui f? -valoare este mai mica
%decat Limita,atunci ii generez succesorii si ii expandez in
%limita Limita

expandeaza(Drum,t(N,F/G,[A|As]),Limita,Arb1,Rez,Sol):-F=<Limita,cea_mai_buna_f(As,BF),min(Limita,BF,Limita1),expandeaza([N|Drum],A,Limita1,A1,Rez1,Sol),continua(Drum,t(N,F/G,[A1|As]),Limita,Arb1,Rez1,Rez,Sol).

% Caz 3 Daca arborele de radacina N are subarbori nevizi si
% f? -valoarea este mai mica decat Limita, atunci expandam cel mai
%""promitator"" subarbore al sau; in functie de rezultatul obtinut
%Rez vom decide cum anume vom continua cautarea prin intermediul
%procedurii (predicatului) continua

expandeaza(_,t(_,_,[]),_,_,imposibil,_):-!.

%Caz 4: pe aceasta varianta nu o sa obtinem niciodata o solutie

expandeaza(_,Arb,Limita,Arb,nu,_):-f(Arb,F),F>Limita.

%Caz 5: In cazul unor f? -valori mai mari decat Bound, arborele nu
%mai poate fi extins

continua(_,_,_,_,da,da,_).
continua(P,t(N,_/G,[A1|As]),Limita,Arb1,nu,Rez, Sol):-insereaza(A1,As,NAs),cea_mai_buna_f(NAs,F1),expandeaza(P,t(N,F1/G,NAs),Limita,Arb1,Rez,Sol).
continua(P,t(N,_/G,[_|As]),Limita,Arb1,imposibil,Rez,Sol):-cea_mai_buna_f(As,F1),expandeaza(P,t(N,F1/G,As),Limita,Arb1,Rez,Sol).

listasucc(_,[],[]).
listasucc(G0,[N/C|NCs],Ts):-G is G0+C,h(N,H),F is G+H,listasucc(G0,NCs,Ts1),insereaza(l(N,F/G),Ts1,Ts).

%Predicatul insereaza(A,As,As1) este utilizat pentru inserarea
%unui arbore A intr-o lista de arbori As, mentinand ordinea
%impusa de f? -valorile lor

insereaza(A,As,[A|As]):-f(A,F),cea_mai_buna_f(As,F1),F=<F1,!.
insereaza(A,[A1|As],[A1|As1]):-insereaza(A,As,As1).

min(X,Y,X):-X=<Y,!.
min(_,Y,Y).

f(l(_,F/_),F). % f-val unei frunze
f(t(_,F/_,_),F). % f-val unui arbore

% Predicatul cea_mai_buna_f(As,F) este utilizat pentru a
%determina cea mai buna f? -valoare a unui arbore din lista de
%arbori As, daca aceasta lista este nevida; lista As este
%ordonata dupa f? -valorile subarborilor constituenti

cea_mai_buna_f([A|_],F):-f(A,F).
cea_mai_buna_f([],999999).

% In cazul unei liste de arbori vide, f? -valoarea determinata este
%foarte mare

membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

s([G|P],[G1|P1],1) :- interschimba(G,G1,P,P1).

interschimba(G,G1,[G1|T],[G|T]) :- distman(G,G1,1).
interschimba(G,G1,[A|T],[A|T1]) :- interschimba(G,G1,T,T1).

distman(X/Y,X1/Y1,D) :- D is abs(X - X1) + abs(Y - Y1).

initial([2/1,1/2,1/3, 3/3,3/2,3/1, 2/2,1/1,2/3]).
scop([2/2,1/3,2/3, 3/3,3/2,3/1, 2/1,1/1,1/2]).

scor(2/2,_,1) :- !.
scor(1/3,2/3,0):-!.
scor(2/3,3/3,0):-!.
scor(3/3,3/2,0):-!.
scor(3/2,3/1,0):-!.
scor(3/1,2/1,0):-!.
scor(2/1,1/1,0):-!.
scor(1/1,1/2,0):-!.
scor(1/2,1/3,0):-!.
scor(_,_,2).

% h1 = nr. casute care nu sunt la locul lor in starea curenta fata de starea finala
h(L,H) :- scop(L1), h1(L,L1,H).


h1([],[],0).
h1([A| L1],[B|L2], N):- h1(L1,L2,N1), A\==B, N is N1+1.
h1([A| L1],[A|L2], N):-h1(L1,L2,N).

afis([P0,P1,P2,P3,P4,P5,P6,P7,P8]) :-
     membru(Y,[3,2,1]), nl, membru(X,[1,2,3]),
     membru(Z-X/Y,[' '-P0,1-P1,2-P2,3-P3,4-P4,5-P5,6-P6,7-P7,8-P8]),
        write(Z),write('  '),fail;true.

arata_solutie([]).
arata_solutie([A|B]) :- afis(A), nl, arata_solutie(B).

puzzle :- tell('C:\\Users\\NOI25\\Desktop\\10.txt'),
    initial(Poz),bestfirst(Poz,Sol),arata_solutie(Sol),told.
