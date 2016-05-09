membru(A,[A|_]) :- !.
membru(A,[_|T]) :- membru(A,T).

test(Sol) :- Sol = [t(1,N1,B1,F1,A1,C1), 
				    t(2,N2,B2,F2,A2,C2),
				    t(3,N3,B3,F3,A3,C3),
				    t(4,N4,B4,F4,A4,C4),
				    t(5,N5,B5,F5,A5,C5)],

membru(t(_,englez,_,_,_,rosie), Sol),
membru(t(_,spaniol,_,_,caine,_), Sol),
membru(t(_,_,cafea,_,_,verde), Sol),
membru(t(_,ucrainean,ceai,_,_,_), Sol),
membru(t(U,_,_,_,_,green), Sol), U =:= O + 1, membru(t(O,_,_,_,_,alba), Sol),
membru(t(_,_,_,old,sarpe,_), Sol),
membru(t(_,_,_,kools,_,galben), Sol),
membru(t(3,_,lapte,_,_,_), Sol),
membru(t(1,norvegian,_,_,_,_), Sol),
membru(t(Z,_,_,chesterfields,_,_), Sol), Z is N + 1, membru(t(N,_,_,_,vulpe,_), Sol),
membru(t(Y,_,_,kools,_,_), Sol), Y is M + 1, membru(t(M,_,_,_,cal,_), Sol),
membru(t(_,_,suc,lucky,_,_), Sol),
membru(t(_,japonez,_,parlaments,_,_), Sol),
membru(t(X,norvegian,_,_,_,_), Sol), X is P + 1, membru(t(P,_,_,_,_,albastra), Sol),


permutation([N1,N2,N3,N4,N5], [englez,spaniol,ucrainean,norvegian,japonez]),
permutation([B1,B2,B3,B4,B5], [ceai,cafea,lapte,suc,apa]),
permutation([F1,F2,F3,F4,F5], [parlaments,old,kools,chesterfields,lucky]),
permutation([A1,A2,A3,A4,A5], [zebra,vulpe,sarpe,cal,pesti]),
permutation([C1,C2,C3,C4,C5], [rosie,verde,alba,galbena,albastra]).