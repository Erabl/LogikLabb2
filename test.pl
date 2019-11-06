test(a,a).

findlast([T],[],T).    %rekursivt anrop har som basfall i en lista med enbart 1 element
findlast([H|T],[H|R],S):-  %rasslar tillbaka med kapade heads
  findlast(T,R,S).        %ropar tillbaka med listan från åvansteget utan huvuden


partstirng([],[]).
partstring([H|T],[H|L]):-
  partstirng(T,L).
