%! reverse
reverse_list([],[]).
reverse_list([Head|Tail], Reverse):-  naiverev(Tail,RevT),  append(RevT,[Head],Reverse).

%! sort
sorted([], []).
sorted([Head|Tail], Sort) :- sorted(Tail, Remainder), insort(Head, Remainder, Sort).

%! find smallest number in list
list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
    Min1 is min(L, Min0),
    list_min(Ls, Min1, Min).
