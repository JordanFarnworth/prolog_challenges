%! 6x6 sudoku

sudoku6(Puzzle, Solution) :-
  Solution = Puzzle,

  Puzzle = [S11, S12, S13, S14, S15, S16,
            S21, S22, S23, S24, S25, S26,
            S31, S32, S33, S34, S35, S36,
            S41, S42, S43, S44, S45, S46,
            S51, S52, S53, S54, S55, S56,
            S61, S62, S63, S64, S65, S66],

  fd_domain(Solution, 1, 6),

  Row1 = [S11, S12, S13, S14, S15, S16],
  Row2 = [S21, S22, S23, S24, S25, S26],
  Row3 = [S31, S32, S33, S34, S35, S36],
  Row4 = [S41, S42, S43, S44, S45, S46],
  Row5 = [S51, S52, S53, S54, S55, S56],
  Row6 = [S61, S62, S63, S64, S65, S66],

  Col1 = [S11, S21, S31, S41, S51, S61],
  Col2 = [S12, S22, S32, S42, S52, S62],
  Col3 = [S13, S23, S33, S43, S53, S63],
  Col4 = [S14, S24, S34, S44, S54, S64],
  Col5 = [S15, S25, S35, S45, S55, S65],
  Col6 = [S16, S26, S36, S46, S56, S66],

  Square1 = [S11, S12, S13, S21, S22, S23],
  Square2 = [S14, S15, S16, S24, S25, S26],
  Square3 = [S31, S32, S33, S41, S42, S43],
  Square4 = [S34, S35, S36, S44, S45, S46],
  Square5 = [S51, S52, S53, S61, S62, S63],
  Square6 = [S54, S55, S56, S64, S65, S66],

  valid([Row1, Row2, Row3, Row4, Row5, Row6,
         Col1, Col2, Col3, Col4, Col5, Col6,
         Square1, Square2, Square3, Square4, Square5, Square6]),

  pretty_print([Row1, Row2, Row3, Row4, Row5, Row6]).

valid([]).
valid([Head | Tail]) :- fd_all_different(Head), valid(Tail).

pretty_print([Head | Tail]) :-
 print(Head),
 print('\n'),
 pretty_print(Tail).

%! 9x9 sudoku

 sudoku(Puzzle, Solution) :-
  length(Puzzle, L),
  Size is floor(sqrt(L)),

  Solution = Puzzle,
  fd_domain(Solution, 1, Size),

  slice(Puzzle, Rows, Size, 'row'),
  slice(Puzzle, Cols, Size, 'col'),
  slice(Puzzle, Squares, Size, 'square'),

  valid(Rows),
  valid(Cols),
  valid(Squares),

  pretty_print(Rows).

valid([]).
valid([Head | Tail]) :- fd_all_different(Head), valid(Tail).

sublist_length([], _).
sublist_length([Head | Tail], Length) :- length(Head, Length), sublist_length(Tail, Length).

nth0(I, List, Out) :- I1 is I + 1, nth(I1, List, Out).

insert_into_slice(Item, Values, X, Y) :-
  nth0(X, Values, Bucket),
  nth0(Y, Bucket, Item).

slice_position('row', Size, I, X, Y) :-
  X is I // Size,
  Y is I mod Size.

slice_position('col', Size, I, X, Y) :-
  X is I mod Size,
  Y is I // Size.

slice_position('square', Size, I, X, Y) :-
  Size_Sqrt is floor(sqrt(Size)),
  X is (I mod Size // Size_Sqrt) + (Size_Sqrt * (I // (Size * Size_Sqrt))),
  Y is (I mod Size_Sqrt) + (Size_Sqrt * ((I mod (Size * Size_Sqrt)) // Size)).

slice(Puzzle, Slice, Size, Type) :- slice(Puzzle, Slice, Size, Type, 0).
slice(_, Slice, Size, _, I) :- I is Size * Size, length(Slice, Size), sublist_length(Slice, Size).
slice([Head | Tail], Slice, Size, Type, I) :-
  slice_position(Type, Size, I, X, Y),
  insert_into_slice(Head, Slice, X, Y),
  I1 is I + 1,
  slice(Tail, Slice, Size, Type, I1).

pretty_print([Head | Tail]) :-
  print(Head),
  print('\n'),
  pretty_print(Tail).
