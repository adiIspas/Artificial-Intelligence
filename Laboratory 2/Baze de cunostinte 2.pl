% IA - ADRIAN ISPAS, 243

/*
		   anca + vlad
			   /\
			  /  \ 
			 /    \
			/      \
		   /        \
cristi + ioana   george + alexandra
	   /\               /\
      /  \             /  \
     /    \           /    \
	/      \         /      \
   /        \       /        \
 ana       bogdan  dan       elena
 
*/
 
 femeie(anca).
 femeie(ioana).
 femeie(alexandra).
 femeie(elena).
 femeie(ana).
 
 barbat(vlad).
 barbat(cristi).
 barbat(george).
 barbat(bogdan).
 barbat(dan).

 membru(X,[X|_]).
 membru(X,[_|L]) :- membru(X,L).
 
 concat([],L,L).
 concat([H|T],L,[H|L1]):-concat(T,L,L1).
 
 %sa se verifice daca o lista e multime
 multime([]).
 multime([H|T]):-(\+membru(H,T)),multime(T).
 
 %sa se transforme o lista in multime
 transf([],[]).
 transf([H|T],[H|L]):- \+membru(H,T),transf(T,L).
 transf([H|T],L):- membru(H,T),transf(T,L).
 
 %intersectie
 inter([],[],[]).
 inter(L1,L2,R):-setof(X,(membru(X,L1),membru(X,L2)),R).
 
  %reuniune
 reun([],[],[]).
 reun(L1,L2,R):-setof(X,(membru(X,L1);membru(X,L2)),R).
 
  %diferenta
 dif([],[],[]).
 dif(L1,L2,R):-setof(X,(membru(X,L1),\+membru(X,L2)),R).
 
 %inserare la inceputul listei
 inse(X,R,[X|R]):- \+membru(X,R).