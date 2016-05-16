/*
          ------------------------------------
          | 11   12   13 | 14   15 | 16   17 |
          |              |         |         |
          | 21 | 22 | 23 | 24 | 25 | 26 | 27 |
          |    |    |    |    |    |    |    |
          | 31 | 32 | 33 | 34 | 35 | 36 | 37 |
          \====/    |    |    |    |    |    |
Start -->   41   42 | 43 | 44 | 45 | 46 | 47  --> Finish
          |    /====          |         |    |
          | 51 | 52   53   54 | 55   56 | 57 |
          |    \========================/    |
          | 61   62   63   64   65   66   67 |
          ------------------------------------
*/

membru(A, [A|_]) .
membru(A, [_|T]) :- membru(A,T).

concat([],X,X).
concat([A|B],C,[A|D]) :- concat(B,C,D).

% Predicatul bestfirst(Nod_initial,Solutie) este adevarat daca
% Solutie este un drum (obtinut folosind strategia best-first) de
% la nodul Nod_initial la o stare scop

bestfirst(Nod_initial,Solutie):-expandeaza([],l(Nod_initial,0/0),9999999,_,da,Solutie).
expandeaza(Drum,l(N,_),_,_, da,[N|Drum]):-scop(N).

% Caz 1: daca N este nod scop, atunci construim o cale solutie

expandeaza(Drum,l(N,F/G),Limita,Arb1,Rez,Sol):-F=<Limita,(bagof(M/C,(s(N,M,C), \+ (membru(M,Drum))),Succ),!,listasucc(G,Succ,As),cea_mai_buna_f(As,F1),expandeaza(Drum,t(N,F1/G,As),Limita,Arb1, Rez,Sol);Rez=imposibil).

% Caz 2: Daca N este nod frunza a carui f-valoare este mai mica
% decat Limita,atunci ii generez succesorii si ii expandez in
% limita Limita

expandeaza(Drum,t(N,F/G,[A|As]),Limita,Arb1,Rez,Sol):-F=<Limita,cea_mai_buna_f(As,BF),min(Limita,BF,Limita1),expandeaza([N|Drum],A,Limita1,A1,Rez1,Sol),continua(Drum,t(N,F/G,[A1|As]),Limita,Arb1,Rez1,Rez,Sol).

% Caz 3 Daca arborele de radacina N are subarbori nevizi si
% f-valoarea este mai mica decat Limita, atunci expandam cel mai
% promitator subarbore al sau; in functie de rezultatul obtinut
% Rez vom decide cum anume vom continua cautarea prin intermediul
% procedurii (predicatului) continua

expandeaza(_,t(_,_,[]),_,_,imposibil,_):-!.

% Caz 4: pe aceasta varianta nu o sa obtinem niciodata o solutie

expandeaza(_,Arb,Limita,Arb,nu,_):-f(Arb,F),F>Limita.

% Caz 5: In cazul unor f-valori mai mari decat Bound, arborele nu
% mai poate fi extins

continua(_,_,_,_,da,da,_).
continua(P,t(N,_/G,[A1|As]),Limita,Arb1,nu,Rez, Sol):-insereaza(A1,As,NAs),cea_mai_buna_f(NAs,F1),expandeaza(P,t(N,F1/G,NAs),Limita,Arb1,Rez,Sol).
continua(P,t(N,_/G,[_|As]),Limita,Arb1,imposibil,Rez,Sol):-cea_mai_buna_f(As,F1),expandeaza(P,t(N,F1/G,As),Limita,Arb1,Rez,Sol).

listasucc(_,[],[]).
listasucc(G0,[N/C|NCs],Ts):-G is G0+C,h(N,H),F is G+H,listasucc(G0,NCs,Ts1),insereaza(l(N,F/G),Ts1,Ts).

% Predicatul insereaza(A,As,As1) este utilizat pentru inserarea
% unui arbore A intr-o lista de arbori As, mentinand ordinea
% impusa de f -valorile lor

insereaza(A,As,[A|As]):-f(A,F),cea_mai_buna_f(As,F1),F=<F1,!.
insereaza(A,[A1|As],[A1|As1]):-insereaza(A,As,As1).

min(X,Y,X):-X=<Y,!.
min(_,Y,Y).

f(l(_,F/_),F). % f-val unei frunze
f(t(_,F/_,_),F). % f-val unui arbore

% Predicatul cea_mai_buna_f(As,F) este utilizat pentru a
% determina cea mai buna f -valoare a unui arbore din lista de
% arbori As, daca aceasta lista este nevida; lista As este
% ordonata dupa f -valorile subarborilor constituenti

cea_mai_buna_f([A|_],F):-f(A,F).
cea_mai_buna_f([],999999).

% In cazul unei liste de arbori vide, f -valoarea determinata este
% foarte mare

initial(pct(4,1)).
scop(pct(4,7)).

% drumuri libere pe orizontala
drum_drept(pct(1,1),pct(1,3)).
drum_drept(pct(1,4),pct(1,5)).
drum_drept(pct(1,6),pct(1,7)).
drum_drept(pct(4,1),pct(4,2)).
drum_drept(pct(5,2),pct(5,4)).
drum_drept(pct(5,5),pct(5,6)).
drum_drept(pct(6,1),pct(6,7)).

% drumuri libere pe verticala
drum_drept(pct(1,1),pct(3,1)).
drum_drept(pct(1,2),pct(4,2)).
drum_drept(pct(1,3),pct(5,3)).
drum_drept(pct(1,4),pct(5,4)).
drum_drept(pct(1,5),pct(5,5)).
drum_drept(pct(1,6),pct(5,6)).
drum_drept(pct(1,7),pct(6,7)).
drum_drept(pct(4,1),pct(6,1)).

not_zid(pct(L1,C),pct(L2,C)) :-
	drum_drept(pct(X,C),pct(Y,C)),
	X < Y,
	Y1 is Y-1, for(X,Y1,L1), L2 is L1+1.

not_zid(pct(L,C1),pct(L,C2)) :-
	drum_drept(pct(L,X),pct(L,Y)),
	X < Y,
	Y1 is Y-1, for(X,Y1,C1), C2 is C1+1.

s(pct(L,C),pct(L1,C1),1) :-
          not_zid(pct(L,C),pct(L1,C1)) ;
          not_zid(pct(L1,C1),pct(L,C)).

for(A,B,A) :- A=<B.
for(A,B,X) :- A1 is A+1, A1=<B, for(A1,B,X).

h(pct(L,C),H) :-
   scop(pct(Lscop,Cscop)),
   H is abs(Lscop-L)+abs(Cscop-C).

labirint(S) :- initial(Nod), bestfirst(Nod, S).
