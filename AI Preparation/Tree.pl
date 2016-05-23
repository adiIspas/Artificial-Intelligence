nivele(_,nil,nil).
nivele(E,t(S,_,D),t(S1,E,D1)) :- inaltime(S,H1), inaltime(D,H2), H is max(H1,H2) + 1, divizibil(H), nivele(E,S,S1), nivele(E,D,D1).
nivele(E,t(S,R,D),t(S1,R,D1)) :-  nivele(E,S,S1), nivele(E,D,D1).

inaltime(nil,0).
inaltime(t(S,_,D),H) :- inaltime(S,H1), inaltime(D,H2), H is max(H1,H2) + 1.

divizibil(E) :- Y =  E // 2, Y * 2 =:= E.
