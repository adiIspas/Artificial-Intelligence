% Sets of natural numbers 2.

% Delete a element from a list.
% X, Y, Z = elements | L, L1, L2 = lists
sterge(X,[X|L],L).
sterge(X,[Y,Z|L1],[Y|L2]) :- sterge(X,[Z|L1],L2).

% N factorial
% N = factorial number | R = result of N! | N1, R1 = auxiliar terms
factorial(0,1).
factorial(N,R) :- N1 is N - 1, factorial(N1,R1), R is R1 * N.

% N Fibonacci number.
% N = number | R = N Fibonacci number
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,R) :- X1 is N - 1, X2 is N - 2, fibonacci(X1,R1), fibonacci(X2,R2), R is R1 + R2.

% Greatest common divisor
% X, Y = numbers | R = result | X1, Y1 = auxiliar terms
cmmdc(X,Y,R) :- X =:= Y, R is X.
cmmdc(X,Y,R) :- X > Y, X1 is X - Y, cmmdc(X1,Y,R).
cmmdc(X,Y,R) :- X < Y, Y1 is Y - X, cmmdc(X,Y1,R).

% Least common multiple
% X, Y = numbers | R = result | R1 = auxiliar term
cmmmc(X,Y,R) :- cmmdc(X,Y,R1), R is (X * Y) / R1.

% Sum elements from a list.
% X = number | L = list | R = result
suma([],0).
suma([X|L],R) :- suma(L,R1), R is X + R1.

% Count number of elemtents from a list.
% X = number | L = list | R = result | R1 = auxiliar term
numar([],0).
numar([X|L],R) :- numar(L,R1), R is R1 + 1.

% Replace an element with another element.
% X, Y, Z = elements | L1, L2 = lists
inlocuire(_,_,[],[]).
inlocuire(X,Y,[X|L1],[Y|L2]) :- inlocuire(X,Y,L1,L2).
inlocuire(X,Y,[Z|L1],[Z|L2]) :- inlocuire(X,Y,L1,L2).
