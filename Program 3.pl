%resources https://stackoverflow.com/questions/13484407/prolog-negation
%https://github.com/DonaldKellett/Einsteins-Riddle-Prolog
%https://swish.swi-prolog.org/example/houses_puzzle.pl
%https://www.swi-prolog.org/pldoc/man?section=lists
%Tayler Singleton
%Program 3
%October 28,2019

:- use_rendering(table,
		 [header(h('Nationality', 'Pet', 'Beverage', 'Team', 'Color'))]).

red_owner(Owner) :-
	houses(Hs),
	member(h(Owner,_,_,_,red), Hs).

pet_owner(Pet):-
    houses(Hs),
    member(h(_,Pet,_,chiefs,_),Hs).

adjacent(A, B, List) :- nextto(A, B, List); nextto(B, A, List).

houses(Hs):-
    length(Hs,5),
    member(h(_,dog,_,raiders,_),Hs),                        %1 The Raiders fan owns a dog.
    adjacent(h(vietnamese,_,_,_,_), h(_,_,_,_,red),Hs),     %2 The resident of the red house has a Vietnamese neighbor.
    member(h(english,cat,_,_,_),Hs),                        %3 The cat owner is English.
    nextto(h(_,dog,_,_,_), h(_,_,juice,_,_),Hs),            %4 The juice drinker lives next to the dog owner.
    member(h(canadian,_,milk,_,_),Hs),                      %5 The milk drinker is Canadian.
    nth1(1,Hs,h(_,_,_,_,blue)),                             %6 The blue house is on the near (left) end.
    member(h(vietnamese,horse,_,_,_),Hs),                   %7 The horse owner is Vietnamese.
    member(h(_,_,juice,_,yellow),Hs),                       %8 The juice drinker lives in the yellow house.
    nextto(h(_,_,_,_,blue), h(_,dog,_,_,_),Hs),             %9 The dog owner lives next to the blue house.
    member(h(_,hamster,_,ravens,_),Hs),                     %10 The Ravens fan owns a hamster.
    member(h(southAfrican,_,tea,_,_),Hs),                   %11 The South African drinks tea.
    nth1(4,Hs,h(_,_,_,_,red)),                              %12 The red house is adjacent to the far end.
    adjacent(h(_,_,_,raiders,_), h(_,horse,_,_,_),Hs),      %14 The neighbor of the Raiders fan keeps a horse.
    member(h(_,_,_,ravens,red),Hs),                         %15 The red house is the home of the Ravens fan.
    member(h(canadian,_,_,_,green),Hs),                     %16 The Canadian lives in the green house.
    member(h(_,_,_,chargers,blue),Hs),                      %17 The Chargers fan lives in the blue house.
    member(h(southAfrican,_,_,_,white),Hs),                 %18 The resident of the white house is South African.
    member(h(_,cat,coffee,_,_),Hs),                         %19 The coffee drinker owns a cat.
    nth1(5,Hs,h(_,_,milk,_,_)),                             %20 The milk drinker lives at the far end of the street.
    member(h(_,_,_,broncos,yellow),Hs),                     %21 The Broncos fan lives in the yellow house.
    member(h(colombian,_,_,_,_), Hs),
    member(h(_,lizard,_,_,_), Hs),
    member(h(_,_,_,chiefs,_),Hs),
    member(h(_,_,water,_,_),Hs),
    \+(adjacent(h(_,cat,_,_,_), h(_,_,juice,_,_),Hs)).      %13 The cat owner and the juice drinker are NOT neighbors.
    

/** <examples>

?- pet_owner(Pet).

?- red_owner(Owner).

?- houses(Hs).

*/