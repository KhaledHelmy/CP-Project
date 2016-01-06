:- use_module(library(clpfd)).

run(Meals, Build, Weight, FatsPercentage, Activity):-
	schedule([Meals, Build, Weight, FatsPercentage, Activity, Schedule]),
	write(Schedule).

schedule([Meals, Build, Weight, FatsPercentage, Activity, Res]):- 
	getLBM(Weight, FatsPercentage, LBM), getBMR(LBM, BMR),
	getTEE(BMR, Activity, TEE),
	calculateTarget(Build, TEE, TDE), label([TDE]),
	muliplyFactor(Factor), assert(build(Build)),
	getReqFats(LBM, Fat), Fats is integer(Fat * Factor),
	getReqProtein(Build, LBM, Protein), Proteins is integer(Protein * Factor),
	Schedule = [Week1, Week2, Week3, Week4],
	%% trace,
	genWeek(Fats, Proteins, TDE, Week1, Meals),
	genWeek(Fats, Proteins, TDE, Week2, Meals),
	different(Week1, Week2),
	genWeek(Fats, Proteins, TDE, Week3, Meals),
	different(Week1, Week3), different(Week2, Week3),
	genWeek(Fats, Proteins, TDE, Week4, Meals),
	different(Week1, Week4), different(Week2, Week4), different(Week3, Week4),
	%% writef('Finished Constrainting and now Searching for Solution\n',[]),
	lbl(Schedule), filter(Schedule, Res).

genWeek(Fats, Protein, TDE, Week, Meals):- 
	Week = [Day1, Day2, Day3, Day4, Day5, Day6, Day7],
	genDay(Meals, Fats, Protein, TDE, Day1), %writef('Day 1:\t%w\n', [Day1]),
	genDay(Meals, Fats, Protein, TDE, Day2), %writef('Day 2:\t%w\n', [Day2]),
	genDay(Meals, Fats, Protein, TDE, Day3), %writef('Day 3:\t%w\n', [Day3]),
	genDay(Meals, Fats, Protein, TDE, Day4), %writef('Day 4:\t%w\n', [Day4]),
	genDay(Meals, Fats, Protein, TDE, Day5), %writef('Day 5:\t%w\n', [Day5]),
	genDay(Meals, Fats, Protein, TDE, Day6), %writef('Day 6:\t%w\n', [Day6]),
	genDay(Meals, Fats, Protein, TDE, Day7), %writef('Day 7:\t%w\n', [Day7]),
	Middle is Meals // 2, nth0(Middle, Day1, MD1), nth0(Middle, Day2, MD2),
	nth0(Middle, Day3, MD3), nth0(Middle, Day4, MD4), nth0(Middle, Day5, MD5), 
	nth0(Middle, Day6, MD6), nth0(Middle, Day7, MD7),
	Middles = [MD1, MD2, MD3, MD4, MD5, MD6, MD7], checkMiddles(Middles).

checkMiddles1(_).

checkMiddles(L):- checkMiddle(L); differentiateAll(L).
checkMiddle([]).
checkMiddle([_]).
checkMiddle([X, Y|T]):-
		(same(X, Y), differentiateAll(X, T), checkMiddle(T))
		;
		(different(X, Y), 
			(checkMiddle([X|T]), differentiateAll(Y, T))
			;
			(checkMiddle([Y|T]), differentiateAll(X, T))
		).

differentiateAll(_,[]).
differentiateAll(X, [H|T]):- different(X, H), differentiateAll(X, T).
differentiateAll([]).
differentiateAll([H|T]):- differentiateAll(H, T), differentiateAll(T).

filter([], []).
filter([H|Rem], [L|T]):- filterWeek(H, L), filter(Rem, T).
filterWeek([], []).
filterWeek([H|Rem], [L|T]):- filterDay(H, L), filterWeek(Rem, T).
filterDay([], []).
filterDay([H|Rem], [L|T]):- filterMeal(H, L), filterDay(Rem, T).
filterMeal([], []).
filterMeal([item(_, 0, _, _, _)|Rem], L):- filterMeal(Rem, L).
filterMeal([item(Name, Quantity, _, _, _)|Rem], [[Name, Quantity]|T]):-
	Quantity > 0, filterMeal(Rem, T).

lbl([]).
lbl([H|T]):- (
	(H = item(_, Quantity, _, _, _), label([Quantity]));
	(is_list(H), lbl(H))
	), lbl(T).

genDay(Meals, Fats, Proteins, TDE, Day):-
	length(Day, Meals), genMeals(1, Day),
	sumAll(Day, FatsEaten, ProteinEaten, CaloriesEaten),
	muliplyFactor(Factor),
	FatsEaten #>= Fats - 5 * Factor, FatsEaten #=< Fats + 5 * Factor,
		ProteinEaten #>= Proteins, ProteinEaten #=< Proteins + 30 * Factor,
	build(Build), checkTDE(Build, CaloriesEaten, TDE).

genMeals(_, []).
genMeals(N, [H|T]):- genItems(N, H), N1 is N + 1, genMeals(N1, T).

sumAll([], 0, 0, 0).
sumAll([H|T], Fats, Proteins, Calories):- sumMeal(H, Fat, Protein, Calorie),
	Fat + Protein + Calorie #> 0,
	sumAll(T, F, P, C),
	Fats #= F + Fat, Proteins #= P + Protein, Calories #= C + Calorie.

sumMeal([], 0, 0, 0).
sumMeal([item(_, _, Fat, Protein, Calorie)|T], Fats, Proteins, Calories):-
	sumMeal(T, F, P, C),
	Fats #= F + Fat, Proteins #= P + Protein, Calories #= C + Calorie.
sumMeal([item(Name, Quantity)|T], Fats, Proteins, Calories):-
	menus(Menus), member([Name, Pro, _, Fa, Ca], Menus), muliplyFactor(Factor),
	Fat is Fa * Quantity * Factor,
	Protein is Pro * Quantity * Factor, Calorie is Ca * Quantity * Factor,
	sumMeal(T, F, P, C), Fats is integer(F + Fat), Proteins is integer(P + Protein),
	Calories is integer(C + Calorie).

checkTDE(true, CaloriesEaten, TDE):- 
	muliplyFactor(Factor),
	CaloriesEaten #>= TDE - 100 * Factor, CaloriesEaten #=< TDE + 100 * Factor.
checkTDE(false, CaloriesEaten, TDE):- 
	CaloriesEaten >= TDE - 100 * Factor, CaloriesEaten #=< TDE * Factor.

genItems(N, Items):- menus(Menu), genItems(N, Menu, Items).
genItems(_, [], []).
genItems(N, [H|Rem], [item(Name, 0, 0, 0, 0)|T]):-
	nth0(0, H, Name), nth0(6, H, Nons), member(N, Nons),
	genItems(N, Rem, T).
%% genItems(N, [H|Rem], [item(Name, Quantity, Fats, Proteins, Calories)|T]):-
%% 	nth0(5, H, DOs), member(N, DOs),
%% 	nth0(7, H, LowerBound), nth0(8, H, UpperBound),
%% 	Quantity in LowerBound..UpperBound,
%% 	muliplyFactor(Factor),
%% 	nth0(0, H, Name), nth0(1, H, P), nth0(3, H, F), nth0(4, H, C),
%% 	Protein is integer(P * Factor), Fat is integer(F * Factor),
%% 	Calorie is integer(C * Factor),
%% 	Fats #= Quantity * Fat, Proteins #= Quantity * Protein,
%% 		Calories #= Quantity * Calorie,
%% 	genItems(N, Rem, T).
genItems(N, [H|Rem], [item(Name, Quantity, Fats, Proteins, Calories)|T]):-
	%% nth0(5, H, DOs),
	nth0(6, H, Nons),
	%% not(member(N, Nons)), not(member(N, DOs)),
	not(member(N, Nons)),
	nth0(7, H, LowerBound), nth0(8, H, UpperBound),
	Quantity in 0\/LowerBound..UpperBound,
	%% (
	%% 	(member(N, Nons), Quantity in 0\/LowerBound..UpperBound);
	%% 	(not(member(N, Nons)), (Quantity in LowerBound..UpperBound; Quantity in 0))
	%% ),
	muliplyFactor(Factor),
	nth0(0, H, Name), nth0(1, H, P), nth0(3, H, F), nth0(4, H, C),
	Protein is integer(P * Factor), Fat is integer(F * Factor),
	Calorie is integer(C * Factor),
	Fats #= Quantity * Fat, Proteins #= Quantity * Protein,
		Calories #= Quantity * Calorie,
	genItems(N, Rem, T).

getLBM(Weight, Fats, LBM):- LBM is (Weight * (100 - Fats)) / 100.

getBMR(LBM, BMR):- Temp is integer(21.6 * LBM * 10000), BMR is 370 * 10000 + Temp.

getTEE(BMR, Activity, TEE):- getActAvg(Activity, Avg), TEE #= BMR * Avg.

getActAvg(1, 12).
getActAvg(2, Avg):- Avg #>= 13, Avg #=< 14.
getActAvg(3, Avg):- Avg #>= 15, Avg #=< 16.
getActAvg(4, Avg):- Avg #>= 17, Avg #=< 18.
getActAvg(5, Avg):- Avg #>= 19, Avg #=< 22.

getReqFats(LBM, Fats):- kgToLbs(LBM, Lbs), Fats is 0.4 * Lbs.

getReqProtein(true, LBM, Protein):- kgToLbs(LBM, Lbs), Protein is 1.6 * Lbs.
getReqProtein(false, LBM, Protein):- kgToLbs(LBM, Lbs), Protein is 1.5 * Lbs.

kgToLbs(Kg, Lbs):- Lbs is (Kg * 2.2046).

calculateTarget(true, TEE, Target):-  Target #= TEE * (10 + 2).
calculateTarget(false, TEE, Target):-  Target #= TEE * (10 - 2).

different([],[]).
different([item(X, Y, _, _, _)|T1], [item(X, Z, _, _, _)|T2]):-
	different(T1, T2), Y*Z #= 0.
different([H1|T1], [H2|T2]):- 
	not((
		H1 = item(_, _, _, _, _),
		H2 = item(_, _, _, _, _)
	)), (different(H1, H2), different(T1, T2)).

same([], []).
same([item(X, Y, _, _, _)|T1], [item(X, Z, _, _, _)|T2]):-
	same(T1, T2), Y*Z #> 0.

isvar(L):- var(L), !.
isvar([H|T]):- isvar(H), ! ; isvar(T), !.
notvar(X):- not(isvar(X)).
%% BMR = 1428.4
%% TEE = 1714.0800000000002
%% Fats = 43.21016
%% Protein = 172.84064
%% TDE = 2056.896
%% [40.7, 199.6, 2,002]
%% build(true).
muliplyFactor(1000000).
ntrace :- notrace, nodebug.
menus(Food):-
	Food = [
	%% [FoodName, Protein, Carbs, Fats, Calories, Preference, nonPreference, LowerBound, UpperBound]
	%%0 Chicken Breast (Uncooked)
		[0, 21.2, 0, 2.5, 114, [3], [1], 1, 2],
	%%1 Lean Beef (Uncooked)
		[1, 20, 0, 6, 137, [3], [1], 1, 3],
	%%2 Cheddar Cheese
 		[2, 25, 1.3, 33, 402, [1,2,5], [], 1, 5],
	%%3 Gouda Cheese
		[3, 25, 2.2, 27, 356, [1,2,5], [], 1, 5],
	%%4 Swiss cheese
		[4, 27, 5, 28, 380, [1,2,5], [], 1, 5],
	%%5 Carrots
		[5, 0.9, 10, 0.2, 41, [], [], 1, 5],
	%%6 Broccoli
		[6, 2.8, 7, 0.4, 34, [], [], 1, 5],
	%%7 Spinach
		[7, 2.9, 3.6, 0.4, 23, [], [1], 1, 5],
	%%8 White Rice (Uncoooked)  
		[8, 7, 82, 0.6, 370, [], [], 1, 10],
	%%9 Potato (Uncooked)
		[9, 2, 17, 0.1, 77, [], [], 1, 10],
	%%10 Tomato
		[10, 0.9, 3.9, 0.2, 18, [], [], 1, 10],
	%%11 Whole Egg (Uncooked)
		[11, 13, 0.7, 10, 143, [1], [], 1, 5],
	%%12 Egg Whites (Uncooked)
		[12, 11, 0.7, 0.2, 52, [], [], 1, 5],
	%%13 Sweet Potato (Uncooked)
		[13, 1.6, 20, 0, 86, [], [], 1, 5],
	%%14 Milk full fat
		[14, 3.3, 4.6, 3.7, 64, [], [], 1, 5],
	%%15 Multi Grain Bread
		[15, 13, 43, 4.2, 265, [], [], 1, 5],
	%%16 Honey
		[16, 0.3, 82, 0, 304, [], [], 1, 5],
	%%17 Olive Oil
		[17, 0, 0, 100, 884, [], [], 1, 5],
	%%18 Pasta (Uncooked)
		[18, 13, 75, 1.5, 371, [3], [1], 1, 5],
	%%19 Salmon (Uncooked)
		[19, 20, 0, 13, 208, [3], [1], 1, 5],
	%%20 Fish
		[20, 19, 0, 6, 134, [3], [1], 1, 5],
	%%21 Shrimp (Uncooked)
		[21, 20, 0, 0.5, 85, [3], [1], 1, 5],
	%%22 Peanut butter
		[22, 25, 20, 50, 588, [], [], 1, 5],
	%%23 Skimmed Milk
		[23, 3.4, 5, 0.1, 34, [], [], 1, 5],
	%%24 Banana
		[24, 1.1, 23, 0.3, 89, [], [], 1, 5],
	%%25 Pear
		[25, 0.4, 15, 0.1, 57, [], [], 1, 5],
	%%26 Tuna (Brine)
		[26, 26, 0, 1, 116, [], [1], 1, 5],
	%%27 Whey Protein
		[27, 80, 10, 3.3, 400, [], [], 1, 3]
	].
