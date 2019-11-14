verify(InputFileName) :-
  see(InputFileName),
  read(Prems), read(Goal), read(Proof),
  seen,
  valid_proof(Prems, Goal, Proof).

valid_proof(Prems, Goal, Proof) :-
  controllGoal(Goal, Proof),
  controllProof(Prems, Proof).

%From lab 1, helps with checking goal
findlast([X], X).
findlast([_|T], L) :- findlast(T, L).

%Check that the goal is reached in the proof
controllGoal(Goal, Proof) :-
  findlast(Proof, LastLine),
  result(LastLine, Goal).

result([_, Result, _], Result).

%Checks all the lines
controllProof(_, []).
controllProof(ControlledProof, [Row1|Rest]) :-
  controllRow(Row1, ControlledProof),
  controllProof([Row1|ControlledProof], Rest).

%Used when there is a new box, to check if it is valid
controllProof(ControlledProof, [[Row1|RestOfBox]|RestOfProof]) :-
  assumption(Row1),
  controllBox([Row1|ControlledProof], RestOfBox),
  findlast([Row1|RestOfBox], Last),
  controllProof([[Row1|[Last]]|ControlledProof], RestOfProof).


%Checks that the box is valid
controllBox(_, []).
controllBox(ControlledProof, [Row|RestOfBox]):-
  controllProof(ControlledProof, [Row|RestOfBox]).

%Assumption
assumption([_, _, assumption]).

%Premise
controllRow([_, P, premise], ControlledProof) :-
  member(P, ControlledProof).

%Copy
controllRow([_, P, copy(L)], ControlledProof) :-
  member([L, P, _], ControlledProof).

%Andint
controllRow([_, and(P, Q), andint(L1, L2)], ControlledProof):-
  member([L1, P, _], ControlledProof),
  member([L2, Q, _], ControlledProof).

%Andel1
controllRow([_, P, andel1(L)], ControlledProof) :-
  member([L, and(P, _), _], ControlledProof).

%Aandel2
controllRow([_, P, andel2(L)], ControlledProof) :-
  member([L, and(_, P), _], ControlledProof).

%Orint1
controllRow([_, or(P, _), orint1(L)], ControlledProof):-
  member([L, P, _], ControlledProof).

%Orint2
controllRow([_, or(_, Q), orint2(L)], ControlledProof):-
  member([L, Q, _], ControlledProof).

%Orel
controllRow([_, U, orel(L1, L2, L3, L4, L5)], ControlledProof):-
  member([L1, or(P, Q), _], ControlledProof),
  member([[L2, P, assumption], [L3, U, _]], ControlledProof),
  member([[L4, Q, assumption], [L5, U, _]], ControlledProof).

%Impint
controllRow([_, imp(P, Q), impint(L1, L2)], ControlledProof):-
  member([[L1, P, assumption], [L2, Q, _]], ControlledProof).

%Impel
controllRow([_, P, impel(L1, L2)], ControlledProof) :-
  member([L1, Origin, _], ControlledProof),
  member([L2, imp(Origin, P), _], ControlledProof).

%Negint
controllRow([_, neg(P), negint(L1 ,L2)], ControlledProof):-
  member([[L1, P, assumption], [L2, cont, _]], ControlledProof).

%Negel
controllRow([_, cont, negel(L1, L2)], ControlledProof):-
  member([L1, P, _], ControlledProof),
  member([L2, neg(P), _], ControlledProof).

%Contel
controllRow([_, _, contel(L)], ControlledProof) :-
  member([L, cont, _], ControlledProof).

%Negnegint
controllRow([_, neg(neg(P)), negnegint(L)], ControlledProof):-
  member([L, P, _], ControlledProof).

%Negnegel
controllRow([_, P, negnegel(L)], ControlledProof) :-
  member([L, neg(neg(P)), _], ControlledProof).

%MT
controllRow([_, neg(P), mt(L1, L2)], ControlledProof) :-
  member([L1, imp(P, Q), _], ControlledProof),
  member([L2, neg(Q), _], ControlledProof).

%PBC
controllRow([_, P, pbc(L1, L2)], ControlledProof):-
  member([[L1, neg(P), assumption], [L2, cont, _]], ControlledProof).

%LEM
controllRow([_, or(P, neg(P)), lem], _).
