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
 
 %inversare lista
 inversare([],[]).
 inversare([X|L1],L2):-inversare(L1,LRez),concat(LRez,[X],L2).
 
 %elementul minim
 min([H|T],M):- minim(H,T,M).
 minim(H,[H1|T],M):- H < H1, minim(H,T,M).
 minim(H,[H1|T],M):- H1 < H, minim(H1,T,M).
 minim(H,[],H).

 %elementul de pe pozitia
 el_poz(1,[X|_],X).
 el_poz(Poz,[_|L],E):- Poz2 is Poz - 1, el_poz(Poz2,L,E).
 
 %inserare pe pozitia
 inserare(E,1,L,[E|L]).
 inserare(E,Poz,[H|L],[H|LRez]):- Poz2 is Poz - 1, inserare(E,Poz2,L,LRez).
 
 %impartire lista in 2 subliste
 split([],[],[]).
 split([X],[X],[]).
 split([S,D|L],[S|SL],[D|DL]):- split(L,SL,DL).
  
 %interclaseaza 2 liste ordonate
 interclasare([],RS,RS ).
 interclasare(LS,[],LS ).
 interclasare([L|LS],[R|RS],[L|T]):- L =< R,interclasare(LS,[R|RS],T).
 interclasare([L|LS],[R|RS],[R|T]):- L > R,interclasare([L|LS],RS,T).
 
 %merg sort
 merge_sort([],[]).
 merge_sort([X],[X]).
 merge_sort(U,S):-split(U,L,R), merge_sort(L,SL),merge_sort(R,SR),interclasare(SL,SR,S).
 
 %imparte L in 2 liste cu elemente mai mici decat E si mai mari decat E
 divide([],_,[],[]).
 divide([X],E,[X],[]):- X < E.
 divide([X],E,[],[X]):- X > E.
 divide([X|L],E,[X|LMici],LMari):- X =< E, divide(L,E,LMici,LMari).
 divide([X|L],E,LMici,[X|LMari]):- X > E, divide(L,E,LMici,LMari).
 
 %insereaza un element in lista sortata 
 ins(X,[],[X]).
 ins(X,[Y|L],[X,Y|L]):- X =< Y.
 ins(X,[Y|L],[Y|LRez]):- ins(X,L,LRez).
 
 %sortarea prin insertie
 sort_insertie(L1,L2):- sort_insertie_intern(L1,[],L2).
 sort_insertie_intern([],L,L).
 sort_insertie_intern([H|T],L1,L) :- ins(H,L1,L2), sort_insertie_intern(T,L2,L).

 %sortare prin selectia minimului
 %sortare_selectie_min(L,LRez).
 
 %sortare quicksort
 %quick_sort(L,LRez).
 