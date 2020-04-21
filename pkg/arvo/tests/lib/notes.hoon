::  ~dirwex-dosrev
::
::  > +test /lib/notes
::
/-  notes
/+  notes, *test
=,  notes
::
|%
++  test-key-match
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match %a ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match %z ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match %a ~)
  ==
::
++  test-key-match-any
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match-any ~[%a %z] ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any ~[%y %z] ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any ~[%a %z] ~)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-any ~ ~[%a %b %c])
  ==
::
++  test-key-match-all
  ;:  weld
    %+  expect-eq
      !>  %.y
      !>  (key-match-all ~[%a %b] ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all ~[%a %z] ~[%a %b %c])
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all ~[%a %b] ~)
  ::
    %+  expect-eq
      !>  %.n
      !>  (key-match-all ~ ~[%a %b %c])
  ==
::
++  test-get-keys-no-match
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-keys-no-match ~ ~[%a %b %e %f])
  ::
    %+  expect-eq
      !>  ~[%a %b %c %d]
      !>  (get-keys-no-match ~[%a %b %c %d] ~)
  ::
    %+  expect-eq
      !>  ~[%c %d]
      !>  (get-keys-no-match ~[%a %b %c %d] ~[%a %b %e %f])
  ::
    %+  expect-eq
      !>  ~[%a %b %c]
      !>  (get-keys-no-match ~[%a %b %c] ~[%d %e %f])
  ::
    %+  expect-eq
      !>  ~
      !>  (get-keys-no-match ~[%a %b %c] ~[%a %b %c])
  ==
::
++  abc  [~[%a %b %c] "abc"]
++  bcd  [~[%b %c %d] "bcd"]
++  cde  [~[%c %d %e] "cde"]
++  abz  [~[%a %b %z] "abz"]
::
++  some-notes  ~[abc bcd cde abz]
::
++  test-get-keys-all
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
  ;:  weld
    %+  expect-eq
      !>  ~[abz bcd abc]  ::  flopped
      !>  (get-notes-any ~[%a %b] some-notes)
  ==
::
++  test-get-notes-all
  ;:  weld
    %+  expect-eq
      !>  ~[abz abc]  ::  flopped
      !>  (get-notes-all ~[%a %b] some-notes)
  ==
::
++  test-get-notes-all-not-all
  ;:  weld
    %+  expect-eq
      !>  ::  all flopped, not-all not flopped
          [~[abz abc] ~[bcd cde]]  ::  [all not-all]
      !>  (get-notes-all-not-all ~[%a %b] some-notes)
  ==
::
++  test-get-key-combos-n
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 2 ~)
  ::
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 0 ~[%a %b %c])
  ::
    %+  expect-eq
      !>  ~[~[%a] ~[%b] ~[%c]]
      !>  (get-key-combos-n 1 ~[%a %b %c])
  ::
    %+  expect-eq
      !>  ~[~[%a %b] ~[%a %c] ~[%b %c]]
      !>  (get-key-combos-n 2 ~[%a %b %c])
  ::
    %+  expect-eq
      !>  ~[~[%a %b %c]]
      !>  (get-key-combos-n 3 ~[%a %b %c])
  ::
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-n 4 ~[%a %b %c])
  ==
::
++  test-get-key-combos-all
  ;:  weld
    %+  expect-eq
      !>  ~
      !>  (get-key-combos-all ~)
  ::
    %+  expect-eq
      !>  ~[~[%a]]
      !>  (get-key-combos-all ~[%a])
  ::
    %+  expect-eq
      !>  ~[~[%a %b] ~[%a] ~[%b]]
      !>  (get-key-combos-all ~[%a %b])
  ::
    %+  expect-eq
      !>  :~
          ~[%a %b %c]
          ~[%a %b]  ~[%a %c]  ~[%b %c]
          ~[%a]  ~[%b]  ~[%c]
          ==
      !>  (get-key-combos-all ~[%a %b %c])
  ==
::
++  amn  [~[%a %m %n] "amn"]
++  auv  [~[%a %u %v] "auv"]
++  axy  [~[%a %x %y] "axy"]
++  bmn  [~[%b %m %n] "bmn"]
++  buv  [~[%b %u %v] "buv"]
++  bxy  [~[%b %x %y] "bxy"]
++  cmn  [~[%c %m %n] "cmn"]
++  cuv  [~[%c %u %v] "cuv"]
++  cxy  [~[%c %x %y] "cxy"]
++  dmn  [~[%d %m %n] "dmn"]
++  duv  [~[%d %u %v] "duv"]
++  dxy  [~[%d %x %y] "dxy"]
::
++  flop-check-notes
  ~[amn auv axy bmn buv bxy cmn cuv cxy dmn duv dxy]
::
++  flop-check-search
  :~  [~[%a] ~[amn auv axy]]
      [~[%b] ~[bmn buv bxy]]
      [~[%c] ~[cmn cuv cxy]]
      [~[%d] ~[dmn duv dxy]]
  ==
::
++  test-search-notes
  ;:  weld
    %+  expect-eq
      !>  ~[[~[%a %b] ~[abc abz]] [~[%b] ~[bcd]]]
      !>  (search-notes ~[%a %b] some-notes)
  ::
    %+  expect-eq
      !>  flop-check-search
      !>  (search-notes ~[%a %b %c %d] flop-check-notes)
  ==
--
