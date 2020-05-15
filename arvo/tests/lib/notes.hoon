::  ~dirwex-dosrev
::
::  > +test /lib/notes
::
/-  notes
/+  notes, *test
=,  notes
::
|%
::
::  k-eys
::
++  k-a     ~[%a]
++  k-b     ~[%b]
++  k-c     ~[%c]
++  k-d     ~[%d]
++  k-ab    ~[%a %b]
++  k-ac    ~[%a %c]
++  k-az    ~[%a %z]
++  k-bc    ~[%b %c]
++  k-cd    ~[%c %d]
++  k-yz    ~[%y %z]
++  k-abc   ~[%a %b %c]
++  k-abz   ~[%a %b %z]
++  k-bcd   ~[%b %c %d]
++  k-cde   ~[%c %d %e]
++  k-def   ~[%d %e %f]
++  k-abcd  ~[%a %b %c %d]
++  k-abef  ~[%a %b %e %f]
::
++  test-key-match
  ::
  ::  is key in keys?
  ::
  ::  key=%a  keys=~[%a %b %c]  %.y
  ::  key=%z  keys=~[%a %b %c]  %.n
  ::  key=%a  keys=~            %.n
  ::
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match %a k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match %z k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match %a ~)
  ==
::
++  test-key-match-any
  ::
  ::  are any of a in b?
  ::
  ::  a=~[%a %z]  b=~[%a %b %c]  %.y
  ::  a=~[%y %z]  b=~[%a %b %c]  %.n
  ::  a=~[%a %z]  b=~            %.n
  ::  a=~         b=~[%a %b %c]  %.n
  ::
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match-any k-az k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any k-yz k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any k-az ~)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any ~ k-abc)
  ==
::
++  test-key-match-all
  ::
  ::  are all of a in b?
  ::
  ::  a=~[%a %b]  b=~[%a %b %c]  %.y
  ::  a=~[%a %z]  b=~[%a %b %c]  %.n
  ::  a=~[%a %b]  b=~            %.n
  ::  a=~         b=~[%a %b %c]  %.n
  ::
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match-all k-ab k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all k-az k-abc)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all k-ab ~)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all ~ k-abc)
  ==
::
++  test-get-keys-in
  ::
  ::  get keys in a that are in b
  ::
  ::  a=~               b=~               ~
  ::  a=~               b=~[%a %b %e %f]  ~
  ::  a=~[%a %b %c %d]  b=~               ~
  ::  a=~[%a %b %c %d]  b=~[%a %b %e %f]  ~[%a %b]
  ::  a=~[%a %b %c]     b=~[%d %e %f]     ~
  ::  a=~[%a %b %c]     b=~[%a %b %c]     ~[%a %b %c]
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-keys-in ~ ~)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-in ~ k-abef)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-in k-abcd ~)
  ::
    %+  expect-eq
      !>  k-ab
      !>  (get-keys-in k-abcd k-abef)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-in k-abc k-def)
  ::
    %+  expect-eq
      !>  k-abc
      !>  (get-keys-in k-abc k-abc)
  ==
::
++  test-get-keys-not-in
  ::
  ::  get keys in a that are not in b
  ::
  ::  a=~               b=~               ~
  ::  a=~               b=~[%a %b %e %f]  ~
  ::  a=~[%a %b %c %d]  b=~               ~[%a %b %c %d]
  ::  a=~[%a %b %c %d]  b=~[%a %b %e %f]  ~[%c %d]
  ::  a=~[%a %b %c]     b=~[%d %e %f]     ~[%a %b %c]
  ::  a=~[%a %b %c]     b=~[%a %b %c]     ~
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-keys-not-in ~ ~)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-not-in ~ k-abef)
  ::
    %+  expect-eq
      !>  k-abcd
      !>  (get-keys-not-in k-abcd ~)
  ::
    %+  expect-eq
      !>  k-cd
      !>  (get-keys-not-in k-abcd k-abef)
  ::
    %+  expect-eq
      !>  k-abc
      !>  (get-keys-not-in k-abc k-def)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-not-in k-abc k-abc)
  ==
::
++  test-get-keys-in-not-in
  ::
  ::  get cell of:
  ::    - keys in a that are in b
  ::    - keys in a that are not in b
  ::
  ::  a=~               b=~               [~ ~]
  ::  a=~               b=~[%a %b %e %f]  [~ ~]
  ::  a=~[%a %b %c %d]  b=~               [~ ~[%a %b %c %d]]
  ::  a=~[%a %b %c %d]  b=~[%a %b %e %f]  [~[%a %b] ~[%c %d]]
  ::  a=~[%a %b %c]     b=~[%d %e %f]     [~ ~[%a %b %c]]
  ::  a=~[%a %b %c]     b=~[%a %b %c]     [~[%a %b %c] ~]
  ::
  ;:  weld
    %+  expect-eq
      !>  [~ ~]
      !>  (get-keys-in-not-in ~ ~)
  ::
    %+  expect-eq
      !>  [~ ~]
      !>  (get-keys-in-not-in ~ k-abef)
  ::
    %+  expect-eq
      !>  [~ k-abcd]
      !>  (get-keys-in-not-in k-abcd ~)
  ::
    %+  expect-eq
      !>  [k-ab k-cd]
      !>  (get-keys-in-not-in k-abcd k-abef)
  ::
    %+  expect-eq
      !>  [~ k-abc]
      !>  (get-keys-in-not-in k-abc k-def)
  ::
    %+  expect-eq
      !>  [k-abc ~]
      !>  (get-keys-in-not-in k-abc k-abc)
  ==
::
::  we omit id.note in the comments
::
++  abc  [1 k-abc "abc"]
++  bcd  [3 k-bcd "bcd"]
++  cde  [5 k-cde "cde"]
++  abz  [7 k-abz "abz"]
++  n-1  [8 ~ "no keys 1"]
++  n-2  [9 ~ "no keys 2"]
::
++  some-notes  ~[abc bcd cde n-1 abz n-2]
::
++  test-get-keys-all
  ::
  ::  get all keys from notes (no duplicates)
  ::
  ::  notes=~                ~
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         ~[%a %b %c %d %e %z]
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-keys-all ~)
  ::
    %+  expect-eq
      !>  ~[%a %b %c %d %e %z]
      !>  (get-keys-all some-notes)
  ==
::
++  test-get-notes-any
  ::
  ::  get notes matching any key
  ::
  ::  keys=~[%a %b]
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         :~
  ::                         [~[%a %b %c] "abc"]
  ::                         [~[%b %c %d] "bcd"]
  ::                         [~[%a %b %z] "abz"]
  ::                         ==
  ::
  ;:  weld
    %+  expect-eq
      !>  ~[abc bcd abz]
      !>  (get-notes-any k-ab some-notes)
  ==
::
++  test-get-notes-all
  ::
  ::  get notes matching all keys
  ::
  ::  keys=~[%a %b]
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         :~
  ::                         [~[%a %b %c] "abc"]
  ::                         [~[%a %b %z] "abz"]
  ::                         ==
  ::
  ;:  weld
    %+  expect-eq
      !>  ~[abc abz]
      !>  (get-notes-all k-ab some-notes)
  ==
::
++  test-get-notes-all-not-all
  ::
  ::  get cell of:
  ::    - notes matching all keys
  ::    - notes not matching all keys
  ::
  ::  keys=~[%a %b]
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         :-
  ::                         :~
  ::                         [~[%a %b %c] "abc"]
  ::                         [~[%a %b %z] "abz"]
  ::                         ==
  ::                         :~
  ::                         [~[%b %c %d] "bcd"]
  ::                         [~[%c %d %e] "cde"]]
  ::                         [~ "no keys 1"]
  ::                         [~ "no keys 2"]
  ::                         ==
  ::
  ;:  weld
    %+  expect-eq
      !>  [~[abc abz] ~[bcd cde n-1 n-2]]
      !>  (get-notes-all-not-all k-ab some-notes)
  ==
::
++  test-get-key-combos-n
  ::
  ::  get combos of n from keys
  ::
  ::  n=2  keys=~            ~
  ::  n=0  keys=~[%a %b %c]  ~
  ::  n=1  keys=~[%a %b %c]  ~[~[%a] ~[%b] ~[%c]]
  ::  n=2  keys=~[%a %b %c]  ~[~[%a %b] ~[%a %c] ~[%b %c]]
  ::  n=3  keys=~[%a %b %c]  ~[~[%a %b %c]]
  ::  n=4  keys=~[%a %b %c]  ~
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 2 ~)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 0 k-abc)
  ::
    %+  expect-eq
      !>  ~[k-a k-b k-c]
      !>  (get-key-combos-n 1 k-abc)
  ::
    %+  expect-eq
      !>  ~[k-ab k-ac k-bc]
      !>  (get-key-combos-n 2 k-abc)
  ::
    %+  expect-eq
      !>  ~[k-abc]
      !>  (get-key-combos-n 3 k-abc)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 4 k-abc)
  ==
::
++  test-get-key-combos-all
  ::
  ::  get combos of n=(lent keys), n-1, ... 1 from keys
  ::
  ::  keys=~            ~
  ::  keys=~[%a]        ~[~[%a]]
  ::  keys=~[%a %b]     ~[~[%a %b] ~[%a] ~[%b]]
  ::  keys=~[%a %b %c]
  ::                    :~
  ::                    ~[%a %b %c]
  ::                    ~[%a %b]  ~[%a %c]  ~[%b %c]
  ::                    ~[%a]  ~[%b]  ~[%c]
  ::                    ==
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-all ~)
  ::
    %+  expect-eq
      !>  ~[k-a]
      !>  (get-key-combos-all k-a)
  ::
    %+  expect-eq
      !>  ~[k-ab k-a k-b]
      !>  (get-key-combos-all k-ab)
  ::
    %+  expect-eq
      !>  :~
          k-abc
          k-ab  k-ac  k-bc
          k-a  k-b  k-c
          ==
      !>  (get-key-combos-all k-abc)
  ==
::
++  amn  [10 ~[%a %m %n] "amn"]
++  auv  [11 ~[%a %u %v] "auv"]
++  axy  [12 ~[%a %x %y] "axy"]
++  bmn  [13 ~[%b %m %n] "bmn"]
++  buv  [14 ~[%b %u %v] "buv"]
++  bxy  [15 ~[%b %x %y] "bxy"]
++  cmn  [16 ~[%c %m %n] "cmn"]
++  cuv  [17 ~[%c %u %v] "cuv"]
++  cxy  [18 ~[%c %x %y] "cxy"]
++  dmn  [19 ~[%d %m %n] "dmn"]
++  duv  [20 ~[%d %u %v] "duv"]
++  dxy  [21 ~[%d %x %y] "dxy"]
::
++  flop-check-notes
  ~[amn auv axy bmn buv bxy cmn cuv cxy dmn duv dxy]
::
++  flop-check-matches
  :~  [k-a ~[amn auv axy]]
      [k-b ~[bmn buv bxy]]
      [k-c ~[cmn cuv cxy]]
      [k-d ~[dmn duv dxy]]
  ==
::
++  test-get-matches
  ::
  ::  get matches from notes that match any key from keys,
  ::  more matches from keys appear earlier in matches,
  ::  if a note matches ~[%a %b] it won't then match
  ::  ~[%a] or ~[%b], don't add [combo ~] to matches
  ::
  ::  keys=~[%a %b]
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         :~
  ::                         :-  ~[%a %b]
  ::                             :~
  ::                             [~[%a %b %c] "abc"]
  ::                             [~[%a %b %z] "abz"]
  ::                             ==
  ::                         :-  ~[%b]
  ::                             :~
  ::                             [~[%b %c %d] "bcd"]
  ::                             ==
  ::                         ==
  ::
  ;:  weld
    %+  expect-eq
      !>  ~[[k-ab ~[abc abz]] [k-b ~[bcd]]]
      !>  (get-matches k-ab some-notes)
  ::
    %+  expect-eq
      !>  flop-check-matches
      !>  (get-matches k-abcd flop-check-notes)
  ==
::
++  test-get-matches-no-keys
  ::
  ::  get matches from notes that have no keys
  ::
  ::  notes=
  ::    :~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~ "no keys 1"]
  ::    [~[%a %b %z] "abz"]
  ::    [~ "no keys 2"]
  ::    ==
  ::                         :~
  ::                         :-  ~
  ::                             :~
  ::                             [~ "no keys 1"]
  ::                             [~ "no keys 2"]
  ::                             ==
  ::                         ==
  ::
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-matches-no-keys ~)
    ::
    %+  expect-eq
      !>  ~
      !>  (get-matches-no-keys ~[abc bcd])
    ::
    %+  expect-eq
      !>  ~[[~ ~[n-1 n-2]]]
      !>  (get-matches-no-keys some-notes)
    ::
    ==
::
::  ++test-get-search       XX
::
::  ++test-cord-to-keys     XX
::  ++test-keys-to-cord     XX
::  ++test-key-to-json      XX  add this? XX
::  ++test-keys-to-json     XX
::  ++test-note-to-json     XX
::  ++test-notes-to-json    XX
::  ++test-match-to-json    XX
::  ++test-matches-to-json  XX
::  ++test-search-to-json   XX
::
--
