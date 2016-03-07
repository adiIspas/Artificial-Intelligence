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
 
 %inserare la inceputul listei daca nu este membru
 inse(X,R,[X|R]):- \+membru(X,R).
 
 %inserare la inceputul listei daca este membru
 inse(X,R,[X|R]).
 
 %stergerea
 sterg(X,[X|L],L).
 sterg(X,[Y,Z|L3],[Y|L4]):- sterg(X,[Z|L3],L4).
 
 %operatii de baza
 suma(X,Y,Rez):- Rez is X + Y.
 diferenta(X,Y,Rez):- Rez is X - Y.
 inmultire(X,Y,Rez):- Rez is X * Y.
 impartire(X,Y,Rez):- Y =\= 0, Rez is X / Y.
 
 %factorial
 factorial(0,1).
 factorial(N,Rez):- X is N - 1, factorial(X,Rez1), Rez is Rez1 * N.
 
 %fibonacci
 fibonacci(0,0).
 fibonacci(1,1).
 fibonacci(N,Rez):- X is N - 1, Y is N - 2, fibonacci(X,Rez1), fibonacci(Y,Rez2), Rez is Rez1 + Rez2.
 
 %cmmdc
 cmmdc(X,Y,Rez):- X =:= Y, Rez is X.
 cmmdc(X,Y,Rez):- X > Y, X1 is X - Y, cmmdc(X1, Y, Rez).
 cmmdc(X,Y,Rez):- Y > X, Y1 is Y - X, cmmdc(X,Y1,Rez).
 
 %cmmmc
 cmmmc(X,Y,Rez):- cmmdc(X,Y,Rez1), Rez is (X * Y)/Rez1.
 
 %suma elementelor din lista
 suma_elem_lista([],0).
 suma_elem_lista([X|L],S):- suma_elem_lista(L,S1), S is X + S1.
 
 %numarul elementelor din lista
 nr_elem_lista([],0).
 nr_elem_lista([_|L],N):- nr_elem_lista(L,N1), N is N1 + 1.
 
 %inlocuirea unui element cu alt element
 inlocuire(_,_,[],[]).
 inlocuire(X,Y,[X|L1],[Y|L2]):- inlocuire(X,Y,L1,L2).
 inlocuire(X,Y,[Z|L1],[Z|L2]):- inlocuire(X,Y,L1,L2).