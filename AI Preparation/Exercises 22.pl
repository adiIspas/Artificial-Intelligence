factorial(0,1).
factorial(N,X) :- N1 is N - 1, factorial(N1,Y), X is Y * N.

fibonacci(1,1).
fibonacci(2,1).
fibonacci(N,X) :- N1 is N - 1, N2 is N - 2, fibonacci(N1,X1), fibonacci(N2,X2), X is X1 + X2.

cmmdc(X,X,X).
cmmdc(X,Y,Z) :- X < Y, X1 is Y - X, cmmdc(X,X1,Z).
cmmdc(X,Y,Z) :- X > Y, Y1 is X - Y, cmmdc(Y1,Y,Z).

cmmmc(X,Y,Z) :- R is (X * Y), cmmdc(X,Y,Z1), Z is (R/Z1).

membru(A,[A|_]).
membru(A,[_|L]) :- membru(A,L).

adauga(E,[],[E]).
adauga(E,L,[E|L]).

concat([],L,L).
concat([H|L1],L,[H|L2]) :- concat(L1,L,L2).

addpoz(E,_,[],[E]).
addpoz(E,1,L,[E|L]).
addpoz(E,P,[H|L],[H|LR]) :- X is P - 1, addpoz(E,X,L,LR).

nrelem([],0).
nrelem([_|L],N) :- nrelem(L,N1), N is N1 + 1.

adaugasf(E,L,R) :- nrelem(L,N), addpoz(E,N + 1,L,R).

elpoz(1,[E|_]) :- write(E).
elpoz(X,[_|T]) :- Y is X - 1, elpoz(Y,T).

adauga_nou(E,L,LR) :- \+membru(E,L), adaugasf(E,L,LR).

min(X,Y,X) :- X =< Y.
min(X,Y,Y) :- X > Y.

minim([X],X).
minim([A|L],X) :- minim(L,X1), min(A,X1,X).

sterg(_,[],[]).
sterg(E,[E|L],L1) :- sterg(E,L,L1).
sterg(E,[X|L],[X|L1]) :- sterg(E,L,L1).

inlocuire(_,_,[],[]).
inlocuire(E,X,[E|L],[X|L1]) :- inlocuire(E,X,L,L1).
inlocuire(E,X,[A|L],[A|L1]) :- inlocuire(E,X,L,L1).

inversare_lista([],[]).
inversare_lista([A|L],T1) :- inversare_lista(L,T2), concat(T2,[A],T1).

interclasare(L,[],L).
interclasare([],L,L).
interclasare([A|L1],[B|L2],[A|L]) :- A =< B, interclasare(L1,[B|L2],L).
interclasare([A|L1],[B|L2],[B|L]) :- A > B, interclasare([A|L1],L2,L).

delete(E,[E|T],T).
delete(E,[H|T],[H|T1]) :- E \== H, delete(E,T,T1).

permutare([],[]).
permutare([H|T],P) :- permutare(T,Q), delete(H,P,Q).

permlist(L, LP) :- bagof(P, permutare(L, P), LP).

inserare_sort(E,[],[E]).
inserare_sort(E,[H|T],[E,H|T]) :- E =< H.
inserare_sort(E,[H|T],[H|T1]) :- E > H, inserare_sort(E,T,T1).

sort_ins([],[]).
sort_ins([E|L],LR) :- sort_ins(L,L1), inserare_sort(E,L1,LR).

imparte([],[],[]).
imparte([A],[A],[]).
imparte([A,B|L],[A|L1],[B|L2]) :- imparte(L,L1,L2).

merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(L,LR) :- imparte(L,L1,L2), merge_sort(L1,LR1), merge_sort(L2,LR2), interclasare(LR1,LR2,LR).

multime([]).
multime([H|L]) :- \+membru(H,L), multime(L).

intersectie([],[],[]).
intersectie(A,B,C) :- setof(X,(membru(X,A),membru(X,B)),C).

reuniune([],[],[]).
reuniune(A,B,C) :- setof(X,(membru(X,A);membru(X,B)),C).

diferenta([],[],[]).
diferenta(A,B,C) :- setof(X,(membru(X,A),\+membru(X,B)),C).

functia_find(L,LR) :- findall(X,membru(X,L),LR).
functia_bag(L,LR) :- bagof(X,membru(X,L),LR).
functia_set(L,LR) :- setof(X,membru(X,L),LR).
