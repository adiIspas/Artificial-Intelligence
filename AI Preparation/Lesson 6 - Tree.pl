% Insert an element into a tree.
% E = element | t(S,R,D) = tree | R = root of tree | S = left tree | D = right tree
inserare_element(E,nil,t(nil,E,nil)).
inserare_element(E,t(S,E,D),t(S,E,D)).
inserare_element(E,t(S,R,D),t(SS,R,D)) :- E < R, inserare_element(E,S,SS).
inserare_element(E,t(S,R,D),t(S,R,DD)) :- E > R, inserare_element(E,D,DD).

% Create a sorted tree from a list.
% E = element | L = list | T = tree | A1 = temporarily tree
creare_arbore([],nil).
creare_arbore([E],t(nil,E,nil)).
creare_arbore([E|L],T) :- creare_arbore(L,A1), inserare_element(E,A1,T).

% Inorder traversal tree. (SRD)
% R = root | S = left tree | R = right tree
inordine(nil).
inordine(t(S,R,D)) :- inordine(S), write(R), write(' '), inordine(D).

% Preorder traversal tree. (RSD)
% R = root | S = left tree | R = right tree
preordine(nil).
preordine(t(S,R,D)) :- write(R), write(' '), preordine(S), preordine(D).

% Postorder traversal tree. (SDR)
% R = root | S = left tree | R = right tree
postordine(nil).
postordine(t(S,R,D)) :- postordine(S), postordine(D), write(R), write(' ').

% Tree height.
% H = height | S = left tree | D = right tree | H1, H2 = temporarily height.
inaltime(nil,0).
inaltime(t(S,_,D),H) :- inaltime(S,H1), inaltime(D,H2), H is max(H1,H2) + 1.

% Merge one list to another list
% X = element of list | L, L1, L2 = list
concatenare([],L,L).
concatenare([X|L1],L,[X|L2]) :- concatenare(L1,L,L2).

% Get list of leaves from a tree.
% R = root | S = left tree | D = right tree | L = list of leaves | L1, L2 = temporarily lists.
lista_frunze(nil,[]).
lista_frunze(t(nil,R,nil),[R]).
lista_frunze(t(S,_,D),L) :- lista_frunze(S,L1), lista_frunze(D,L2), concatenare(L1,L2,L).

% Get list of internal nodes from a tree.
% R = root | S = left tree | D = right tree | L = list of internal nodes | L1, L2 = temporarily lists.
lista_noduri_interne(nil,[]).
lista_noduri_interne(t(nil,_,nil),[]).
lista_noduri_interne(t(S,R,D),[R|L]) :- lista_noduri_interne(S,L1), lista_noduri_interne(D,L2), concatenare(L1,L2,L).

% Get list of edges from a tree.
% R = root | S = left tree | D = right tree | L = list of edges | L1, L2 = temporarily lists.
lista_muchii(nil,[]).
lista_muchii(t(nil,_,nil),[]).
lista_muchii(t(t(S1,S,D1),R,nil),[R-S|L]) :- lista_muchii(t(S1,S,D1),L).
lista_muchii(t(t(nil,R,t(S2,D,D2))),[R-D|L]) :- lista_muchii(t(S2,D,D2),L).
lista_muchii(t(t(S1,S,D1),R,t(S2,D,D2)),[R-S,R-D|L]) :- lista_muchii(t(S1,S,D1),L1),  lista_muchii(t(S2,D,D2),L2), concatenare(L1,L2,L).

% Looking for the lowest element from a tree and delete.
% E = element | R = root | S = left tree | D = right tree | S1 = temporarily tree
cauta(E,t(nil,E,D),D).
cauta(E,t(S,R,D),t(S1,R,D)) :- cauta(E,S,S1).

% Delete a node from a tree.
% E = element | R = root | S = left tree | D = right tree | S1,D1 = temporarily tree
sterge(_,nil,nil).
sterge(E,t(nil,E,nil),nil).
sterge(E,t(nil,E,D),D).
sterge(E,t(S,E,nil),S).
sterge(R,t(S,R,D),t(S,R1,DD)) :- cauta(R1,D,DD).
sterge(E,t(S,R,D),t(S1,R,D)) :- E < R, sterge(E,S,S1).
sterge(E,t(S,R,D),t(S,R,D1)) :- E > R, sterge(E,D,D1).
