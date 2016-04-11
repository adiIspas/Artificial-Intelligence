concat([],L,L).
concat([H|T],L,[H|L1]):-concat(T,L,L1).

membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

sterg(X,[X|L],L).
sterg(X,[Y,Z|L3],[Y|L4]):- sterg(X,[Z|L3],L4).

%Cautare de tip breadth-first
rezolva_b(NodInitial,Solutie) :- breadthfirst([[NodInitial]],Solutie).
breadthfirst([[Nod|Drum]|_],[Nod|Drum]):-scop(Nod).
breadthfirst([Drum|Drumuri],Solutie) :- extinde(Drum,DrumNoi), concat(Drumuri,DrumNoi,Drumuri1), breadthfirst(Drumuri1,Solutie).
extinde([Nod|Drum],DrumNoi) :- bagof([NodNou,Nod|Drum], (s(Nod,NodNou), \+ (membru(NodNou,[Nod|Drum]))), DrumNoi), !.
extinde(_,[]).

%Cautare de tip depth-first cu mecanism de detectare ciclurilor
rezolva(Nod,Solutie) :- depthfirst([],Nod,Solutie).
depthfirst(Drum, Nod,[Nod|Drum]) :- scop(Nod).
depthfirst(Drum,Nod,Solution) :- s(Nod,Nod1), \+ (membru(Nod1,Drum)), depthfirst([Nod|Drum],Nod1,Solution).

initial([[d],[a,b],[c]]).
scop([[],[a,b,c,d],[]]).

det_poz_el([X|_],1,X):-!.
det_poz_el([_|L],N,X):- det_poz_el(L,N1,X),!,N is N1 + 1.

s(Lista_stive,Lista_stive_rezultat):-membru(X,Lista_stive), X = [varf|_],det_poz_el(Lista_stive,N,X),sterg_la_n(Lista_stive,Lista_stive_intermediare,N),
									membru(Y,Lista_stive),det_poz_el(Lista_stive,N1,Y),N \== N1, adaug_la_n(Varf,Lista_stive,intermediare,Lista_stive_rezultat,N1),
									\+ permutation(Lista_stive,Lista_stive_rezultat).
									
%sterg_la_n(LL, LLRez, Pozitie).
sterg_la_n([[H|T]|LL],[T|LL],1).
sterg_la_n(LL,LLRez,Pozitie):- sterg_la_n(LL,LLRez,Poz1), Poz2 is Poz1 + 1.

afisare([]).
afisare([H|T]) :- afisare(T), arata(H), nl.

arata(L) :- nl, max_lung(L,N), afis(L,N,N).

afis(L1,_,0) :- af(L1).
afis(L1,N,K) :- K>0, afis2(L1,N,K), nl, K1 is K-1, afis(L1,N,K1).

af([]) :- write('==').
af([_|T]) :- write('==='), af(T).

afis2([],_,_).
afis2([H|T],N,K) :- lung(H,L), 
                    (L >= K, L1 is L-K+1, det_el_n(H,L1,R), write(R) ;
                     L < K, write(' ')),
                     write('  '), afis2(T,N,K).

det_el_n([H|_],1,H).
det_el_n([_|T],K,H) :- K>1, K1 is K-1, det_el_n(T,K1,H).


%lung(Lista,Lungime_lista)
lung([],0).
lung([A|L],N) :- lung(L,N1), N is N1+1.

%max_lung(Lista_stive,Lungime_maxima_stiva)
max_lung([],0).
max_lung([H|T],N) :- lung(H,N1), max_lung(T,N2), N is max(N1,N2).

sterg(X,[X|L],L).
sterg(X,[Y|L],[Y|L1]) :- sterg(X,L,L1).

permutare([],[]).
permutare([H|T],L) :- permutare(T,T1), sterg(H,L,T1).
