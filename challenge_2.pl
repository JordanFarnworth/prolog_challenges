# reverse
reverse_list([],[]).
reverse_list([Head|Tail], Rerverse):-  naiverev(Tail; ,RevT),  append(RevT,[Head],Rerverse).

# sort
# I realize this is cheating a little but life is hard
naive_sort(List,Sorted):-perm(List,Sorted),is_sorted(Sorted).
is_sorted([]).
is_sorted)[_]).
is_sorted([X,Y|T]):-X=<Y,is_sorted([Y|T]).

# find smallest number in list
list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
    Min1 is min(L, Min0),
    list_min(Ls, Min1, Min).
