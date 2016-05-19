% Check if the element is a member in set.
% X = element of list | L = list
membru(X,[X|_]).
membru(X,[_|L]) :- membru(X,L).

graf([1-2,1-3,2-7,3-4,3-5,4-8,5-8,6-7,6-9,7-8,8-9,10-11]).

% Check if two nodes is adjacent.
% X, Y = nodes | G = graph
adiacent(X,Y) :- graf(G), (membru(X-Y,G);membru(Y-X,G)).

% Check degree a node from graph.
% X, V = nodes | G = graph | D = degree
grad(X,D) :- graf(G), setof(V,adiacent(X,V),L), length(L,D).

% Get list of nodes from a graph.
% L = list | G = graph | X, Y = nodes | L1 = temporarily list
lista_noduri(L) :- graf(G), findall(X,(membru(X-Y,G);membru(Y-X,G)),L1),setof(X,membru(X,L1),L).
