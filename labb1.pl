% U1 bindningen misslyckas dA vi fOrsOker deklarera A till y och B till x och X til Y vilket Ar som att sAga a = b

% U2 negation as failiure Ar att vi bevisar negationen av ett pAstAende igeno misslyckandet av exekvering
%lite som bevis igenom motbevis av motsats

%Upg3
findlast([T],[],T).    %rekursivt anrop har som basfall i en lista med enbart 1 element
findlast([H|T],[H|R],S):-  %rasslar tillbaka med kapade heads
  findlast(T,R,S).        %ropar tillbaka med listan från Avansteget utan huvuden

%Upg4
partstring([],[]).
partstring([_|T], Res):-  %kapar head till basfallet
  partstring(T,Res).      %ropar tillbaka till huvudkap
partstring([H|T], [H|Res]):- %kapar huvudet på bade listan OCH res
  prifix(T,Res).

prifix(_,[]).
prifix([H|T], [H|Res]):-   %lagger tillbaka head och tar bort bakifran
  prifix(T,Res).

% Upg5
permute([],[]).
permute(In,[X|R]):-
  select(X,In,Rest),
  permute(Rest,R).
