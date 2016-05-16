%%% algoritmul alpha-beta %%%

alphabeta(Poz,Alpha,Beta,PozBuna,Val) :-
    mutari(Poz,ListaPoz),!,
    limitarebuna(ListaPoz,Alpha,Beta,PozBuna,Val);
    staticval(Poz,Val).

limitarebuna([Poz|ListaPoz],Alpha,Beta,PozBuna,ValBuna) :-
    alphabeta(Poz,Alpha,Beta,_,Val),
    destuldebun(ListaPoz,Alpha,Beta,Poz,Val,PozBuna,ValBuna).

destuldebun([],_,_,Poz,Val,Poz,Val) :- !.
destuldebun(_,Alpha,Beta,Poz,Val,Poz,Val) :-
    mutare_min(Poz),Val>Beta,!;
    mutare_max(Poz),Val<Alpha,!.
destuldebun(ListaPoz,Alpha,Beta,Poz,Val,PozBuna,ValBuna) :-
    limitenoi(Alpha,Beta,Poz,Val,AlphaNou,BetaNou),
    limitarebuna(ListaPoz,AlphaNou,BetaNou,Poz1,Val1),
    maibine(Poz,Val,Poz1,Val1,PozBuna,ValBuna).

limitenoi(Alpha,Beta,Poz,Val,Val,Beta) :-
    mutare_min(Poz),Val>Alpha,!.
limitenoi(Alpha,Beta,Poz,Val,Alpha,Val) :-
    mutare_max(Poz),Val<Beta,!.
limitenoi(Alpha,Beta,_,_,Alpha,Beta).

maibine(Poz0,Val0,Poz1,Val1,Poz0,Val0) :-
    mutare_min(Poz0),Val0>Val1,!;
    mutare_max(Poz0),Val0<Val1,!.
maibine(Poz0,Val0,Poz1,Val1,Poz1,Val1).

membru(A,[A|_]) :- !.
membru(A,[_|T]) :- membru(A,T).


%%% X si 0 %%%

% predicate specifice pentru jocul X si 0

juc_opus(x,0).
juc_opus(0,x).

tablou_initial([gol,gol,gol,gol,gol,gol,gol,gol,gol]).

tablou_final([C,C,C,_,_,_,_,_,_],C) :- C\==gol,!.
tablou_final([_,_,_,C,C,C,_,_,_],C) :- C\==gol,!.
tablou_final([_,_,_,_,_,_,C,C,C],C) :- C\==gol,!.
tablou_final([C,_,_,_,C,_,_,_,C],C) :- C\==gol,!.
tablou_final([_,_,C,_,C,_,C,_,_],C) :- C\==gol,!.
tablou_final([C,_,_,C,_,_,C,_,_],C) :- C\==gol,!.
tablou_final([_,C,_,_,C,_,_,C,_],C) :- C\==gol,!.
tablou_final([_,_,C,_,_,C,_,_,C],C) :- C\==gol,!.
tablou_final(D,gol) :- \+membru(gol,D),!.

mutari(Poz,ListaPoz) :- bagof(Poz1,s(Poz,Poz1),ListaPoz).

s(st(Jucator,T,N,M),st(Jucator_opus,Tablou1,N1,M)) :-
	\+ tablou_final(T,_), N>0,
	juc_opus(Jucator,Jucator_opus),
	N1 is N-1, pune(Jucator,T,Tablou1).

pune(J,[gol|T],[J|T]).
pune(J,[A|T],[A|T1]) :- pune(J,T,T1).

staticval(st(_,Tablou,_,MAX),Val) :-
	tablou_final(Tablou,C), !,
	(C=MAX, Val=99;
	juc_opus(C,MAX), Val= -99;
	C==gol, Val=0).
staticval(st(_,Tablou,_,MAX),Val) :-
	juc_opus(MIN,MAX),
	linii_deschise(MAX,Tablou,D1),
	linii_deschise(MIN,Tablou,D2),
	Val is D1-D2.
linii_deschise(J,T,D) :-
  	linia1(J,T,L1), linia2(J,T,L2), linia3(J,T,L3),
  	coloana1(J,T,C1), coloana2(J,T,C2), coloana3(J,T,C3),
  	diagonala1(J,T,D1), diagonala2(J,T,D2),
  	D is L1+L2+L3+C1+C2+C3+D1+D2.

linia1(J,[A,B,C,_,_,_,_,_,_],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
linia1(_,_,0).
linia2(J,[_,_,_,A,B,C,_,_,_],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
linia2(_,_,0).
linia3(J,[_,_,_,_,_,_,A,B,C],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
linia3(_,_,0).
coloana1(J,[A,_,_,B,_,_,C,_,_],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
coloana1(_,_,0).
coloana2(J,[_,A,_,_,B,_,_,C,_],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
coloana2(_,_,0).
coloana3(J,[_,_,A,_,_,B,_,_,C],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
coloana3(_,_,0).
diagonala1(J,[A,_,_,_,B,_,_,_,C],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
diagonala1(_,_,0).
diagonala2(J,[_,_,A,_,B,_,C,_,_],1) :- juc_opus(J,J1), \+ membru(J1,[A,B,C]), !.
diagonala2(_,_,0).

mutare_max(st(MAX,_,_,MAX)).
mutare_min(st(MIN,_,_,MAX)) :- juc_opus(MAX,MIN).

x_si_0_alphabeta:-
    initializari(MAX,N),
    tablou_initial(Tablou),
    afis_tablou(Tablou),
    joc_alphabeta(st(x,Tablou,N,MAX)).

% jucatorul care marcheaza cu X incepe jocul
jucator_MAX(M):-
  	write('Incepe jocul ... '), nl,
  	repeat,
  	write('Vrei sa fii cu X ? (da/nu)'), nl,
  	read(T),
  	(T=da,M=0 ;T=nu, M=x;T=d,M=0;T=n,M=x), !.

initializari(M,N) :-
  	jucator_MAX(M), nl,
  	repeat,
  	write('Adancimea: '),
  	read(N), integer(N), !, nl.

joc_alphabeta(st(_,T,_,MAX)):-
        tablou_final(T,C), !, anunt_castigator(C,MAX).
    joc_alphabeta(st(MAX,T,N,MAX)):-
        juc_opus(MIN,MAX),
        alphabeta(st(MAX,T,N,MAX), -100, 100, st(MIN,T1,N1,MAX), _),
        write('Am mutat'), nl, afis_tablou(T1), nl,
        joc_alphabeta(st(MIN,T1,N,MAX)).
    joc_alphabeta(st(MIN,T,N,MAX)):-
        juc_opus(MIN,MAX),
        repeat,
        write('linie: '), read(L),
        write('coloana: '), read(C),
        P is 3*(L-1)+C, marcheaza(MIN,T,P,T1), !,
        afis_tablou(T1),
        joc_alphabeta(st(MAX,T1,N,MAX)).

marcheaza(MIN,[gol|T],1,[MIN|T]).
marcheaza(MIN,[A|T],P,[A|T1]) :-
    	P>1, P1 is P-1,
    	marcheaza(MIN,T,P1,T1).

anunt_castigator(J,MAX) :-
      J==MAX, write('Ai pierdut!'), nl;
      juc_opus(J,MAX), write('Ai castigat!'), nl, write('Bravo !!');
      J==gol, write('Jocul s-a incheiat cu remiza '), nl.

afis_tablou([C1,C2,C3,C4,C5,C6,C7,C8,C9]) :-
    	write('  1 2 3 '), nl,
    	write('1 '), scrie_elem(C1),
    	write(' '), scrie_elem(C2),
    	write(' '), scrie_elem(C3), nl,
    	write('2 '), scrie_elem(C4),
    	write(' '), scrie_elem(C5),
    	write(' '), scrie_elem(C6), nl,
    	write('3 '), scrie_elem(C7),
    	write(' '), scrie_elem(C8),
    	write(' '), scrie_elem(C9), nl,nl.

scrie_elem(X) :-
    	X==gol, !, write('.');
    	X==x, !, write('X');
    	write('0').
