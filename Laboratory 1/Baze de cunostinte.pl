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
 
 parinte(anca,ioana).
 parinte(vlad,ioana).
 parinte(anca,george).
 parinte(vlad,george).
 parinte(cristi,ana).
 parinte(ioana,ana).
 parinte(cristi,bogdan).
 parinte(ioana,bogdan).
 parinte(george,dan).
 parinte(george,elena).
 parinte(alexandra,dan).
 parinte(alexandra,elena).

 mama(M,C):-parinte(M,C),femeie(M).
 tata(T,C):-parinte(T,C),barbat(T).

 sot(S,F) :- mama(F,X),tata(S,X).
 sotie(S,B) :- mama(S,X),tata(B,X).

 bunic(B,C):-tata(B,X),parinte(X,C).
 bunica(B,C):-mama(B,X),parinte(X,C).
 
 frate(F,C) :- tata(X,C),tata(X,F),barbat(F),F \== C.
 sora(S,C) :- tata(X,C),tata(X,S),femeie(S),S \== C.
 
 unchi(U,N) :-  parinte(X,N),(frate(U,X);(sora(Y,X),sot(U,Y))).
 matusa(M,N) :- parinte(X,N),(sora(M,X);(frate(Y,X),sotie(M,Y))).
 
 verisor(V,N) :- (unchi(X,N);matusa(X,N)),parinte(X,V),barbat(V).
 verisoara(V,N) :- (unchi(X,N);matusa(X,N)),parinte(X,V),femeie(V).
 
 cumnat(C,N) :- (sora(Y,N),sot(C,Y));(sot(Y,N),sora(Z,Y),sot(C,Z));(sotie(Y,N),frate(C,Y)).
 cumnata(C,N) :- (frate(Y,N),sotie(C,Y));(sotie(Y,N),frate(Z,Y),sotie(C,Z));(sot(Y,N),sora(C,Y)).