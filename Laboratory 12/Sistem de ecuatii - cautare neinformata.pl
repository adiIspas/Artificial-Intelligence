/*
3*x + 4*y = 18
x - 2*y = -4
*/

% Cautare de tip breadth-first
rezolva_b(NodInitial,Solutie) :- breadthfirst([[NodInitial]],Solutie).

breadthfirst([[Nod|Drum]|_],[Nod|Drum]):-scop(Nod).
breadthfirst([Drum|Drumuri],Solutie) :- extinde(Drum,DrumNoi), concat(Drumuri,DrumNoi,Drumuri1), breadthfirst(Drumuri1,Solutie).

extinde([Nod|Drum],DrumNoi) :- bagof([NodNou,Nod|Drum], (s(Nod,NodNou), \+ (membru(NodNou,[Nod|Drum]))), DrumNoi), !.
extinde(_,[]).

membru(A, [A|_]) .
membru(A, [_|T]) :- membru(A,T).

concat([],X,X).
concat([A|B],C,[A|D]) :- concat(B,C,D).

s(st(X,Y), st(X,Y1)) :- Y1 is Y-1.
s(st(X,Y), st(X,Y1)) :- Y1 is Y+1.
s(st(X,Y), st(X1,Y)) :- X1 is X-1.
s(st(X,Y), st(X1,Y)) :- X1 is X+1.

scop(st(X,Y)) :- (3 * X + 4 * Y) =:= 18, (X - 2 * Y) =:= -4.

sistem(X,Y) :- rezolva_b(st(0,0),[st(X,Y)|_]).
sistem_lista(X,Y,L) :- rezolva_b(st(0,0),[st(X,Y)|L]).
