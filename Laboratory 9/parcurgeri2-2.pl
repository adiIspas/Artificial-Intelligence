%Avand la dispozitie doua vase negradate, unul de 3L si altul de 5L, sa se obtina 4L stiind ca
%putem umple vasele, le putem goli sau putem turna dintr-unul intr-altul fie pana cand vasul din care
%turnam se goleste, fie pana cand vasul in care turnam se umple.

%Cautare de tip breadth-first

membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

concat([],L,L).
concat([H|T],L,[H|L1]):-concat(T,L,L1).

rezolva_b(NodInitial,Solutie) :- breadthfirst([[NodInitial]],Solutie).

breadthfirst([[Nod|Drum]|_],[Nod|Drum]):-scop(Nod).
breadthfirst([Drum|Drumuri],Solutie) :- extinde(Drum,DrumNoi), concat(Drumuri,DrumNoi,Drumuri1), breadthfirst(Drumuri1,Solutie).

extinde([Nod|Drum],DrumNoi) :- bagof([NodNou,Nod|Drum], (s(Nod,NodNou), \+ (membru(NodNou,[Nod|Drum]))), DrumNoi), !.
extinde(_,[]).

initial(st(0,0)).
scop(st(4,_)).

s(st(A,B),st(A1,B1)) :-
     A > 0, A1 is 0, B1 = B ;
     B > 0, B1 is 0, A1 = A ;
     A < 5, A1 is 5, B1 = B ;
     B < 3, B1 is 3, A1 = A ;
     B1 is min(A+B,3), A1 is A+B-B1 ;
     A1 is min(A+B,5), B1 is A+B-A1.

afisare([]).
afisare([H|T]) :- afisare(T),nl,afis(H).

afis(stare(B,NMB,NCB,NMis,NCan,M)) :-
   write('Barca se afla pe malul de '),write(B),nl,
   write('Pe acest mal sunt '),write(NMB),write(' misionari si '),write(NCB),write(' canibali'), nl,
   write('Pe malul opus se afla'),write(NMis), write(' misionari si '),write(NCan),write(' canibali'),nl.

vase(Sol) :- initial(X), rezolva_b(X,Sol).
