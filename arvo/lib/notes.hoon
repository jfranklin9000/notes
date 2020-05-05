::  ~dirwex-dosrev
::
/-  notes
=,  notes
::
|%
::
::  +key-match: is key in keys?
::
++  key-match
  |=  [=key =keys]
  ^-  ?
  (lien keys |=(k=^key =(k key)))
::
::  +key-match-any: are any of a in b?
::
++  key-match-any
  |=  [a=keys b=keys]
  ^-  ?
  ?~  a  |
  (lien `keys`a |=(=key (key-match key b)))
::
::  +key-match-all: are all of a in b?
::
++  key-match-all
  |=  [a=keys b=keys]
  ^-  ?
  ?~  a  |
  (levy `keys`a |=(=key (key-match key b)))
::
::  +get-keys-no-match: get keys in a that aren't in b
::
++  get-keys-no-match
  |=  [a=keys b=keys]
  ^-  keys
  =|  =keys
  (skip a |=(=key (key-match key b)))
::
::  +get-keys-all: get all keys from notes (no duplicates)
::
++  get-keys-all
  |=  =notes
  ^-  keys
  %+  roll  notes
  =|  [=note =keys]
  |.  (weld keys (get-keys-no-match keys.note keys))
::
::  +get-notes-any: get notes matching any of keys
::
++  get-notes-any  ::  rewrite FIXME
  |=  [z=keys n=notes]
  ^-  notes
  =|  m=notes
  |-  ?~  n  m  ::  flopped
    ?.  (key-match-any z keys.i.n)
      $(n t.n)
  $(n t.n, m [i=i.n t=m])  ::  flop
::
::  +get-notes-all: get notes matching all of keys
::
++  get-notes-all  ::  rewrite FIXME
  |=  [z=keys n=notes]
  ^-  notes
  =|  m=notes
  |-  ?~  n  m  ::  flopped
    ?.  (key-match-all z keys.i.n)
      $(n t.n)
  $(n t.n, m [i=i.n t=m])  ::  flop
::
::  +get-notes-all-not-all: FIX ME
::
++  get-notes-all-not-all  ::  rewrite FIXME (use skid)
  ::  get cell of:
  ::  - notes matching all keys
  ::  - notes not matching all keys
  ::  z=~[%a %b]
  ::  n=:~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~[%a %b %z] "abz"]
  ::    ==
  ::  a=:-  ::  all flopped, not-all not flopped
  ::    ~[[~[%a %b %z] "abz"] [~[%a %b %c] "abc"]]  ::  all
  ::    ~[[~[%b %c %d] "bcd"] [~[%c %d %e] "cde"]]  ::  not-all
  |=  [z=keys n=notes]
  ^-  all-not-all
  =|  a=all-not-all
  |-  ?~  n  a  ::  all flopped, not-all not flopped
    ?:  (key-match-all z keys.i.n)
      $(n t.n, all.a [i=i.n t=all.a])       ::  flop
  $(n t.n, not-all.a (snoc not-all.a i.n))  ::  no flop
::
::  +get-key-combos-n:
::
++  get-key-combos-n
  ::  get combinations of n from z
  ::  n=2  z=~            ~
  ::  n=0  z=~[%a %b %c]  ~
  ::  n=1  z=~[%a %b %c]  ~[~[%a] ~[%b] ~[%c]]
  ::  n=2  z=~[%a %b %c]  ~[~[%a %b] ~[%a %c] ~[%b %c]]
  ::  n=3  z=~[%a %b %c]  ~[~[%a %b %c]]
  ::  n=4  z=~[%a %b %c]  ~
  |=  [n=@ud z=keys]
  ^-  combos
  =<  (comb n z ~ ~)
  |%
  ++  comb  ::  internal
    ::
    ::  ref: https://stackoverflow.com/questions/127704/
    ::       algorithm-to-return-all-combinations
    ::       -of-k-elements-from-n
    ::       (Rick Giuly answer, Python)
    ::
    ::  def comb(sofar, rest, n):
    ::      if n == 0:
    ::          print sofar
    ::      else:
    ::          for i in range(len(rest)):
    ::              comb(sofar + rest[i], rest[i+1:], n-1)
    ::
    ::  comb("", "abcde", 3)
    ::
    ::  output: (on separate lines)
    ::  abc abd abe acd ace ade bcd bce bde cde
    ::
    |=  [n=@ud r=keys s=keys c=combos]
    ::  n = n, r = rest, s = sofar (note order reversal)
    ::  c = combos (running result)
    ^-  combos
    ::  this check also special cases top level
    ::  call with n=0 (top level call has s=~)
    ?:  =(n 0)  ?~  s  ~  (snoc c s)
    =/  i=@ud  0
    =/  l=@ud  (lent r)
    |-
      ?:  =(i l)  c
      =.  c  (comb (dec n) (slag +(i) r) (snoc s (snag i r)) c)
    $(i +(i))
  --
::
::  +get-key-combos-all:
::
++  get-key-combos-all
  ::  get combinations of n=(lent z), n-1, ... 1 from z
  ::  z=~            ~
  ::  z=~[%a]        ~[~[%a]]
  ::  z=~[%a %b]     ~[~[%a %b] ~[%a] ~[%b]]
  ::  z=~[%a %b %c]  :~
  ::                 ~[%a %b %c]
  ::                 ~[%a %b]  ~[%a %c]  ~[%b %c]
  ::                 ~[%a]  ~[%b]  ~[%c]
  ::                 ==
  |=  z=keys
  ^-  combos
  =/  n=@ud  (lent z)
  =|  c=combos
  |-
    ?:  =(n 0)  c
  $(n (dec n), c (weld c (get-key-combos-n n z)))
::
::  +search-notes
::
++  search-notes
  ::  get all notes from n that match any of z,
  ::  more matches from z appear earlier in s,
  ::  if a note matches ~[%a %b] it won't then
  ::  match ~[%a] or ~[%b], don't add all.a to
  ::  s if it's ~
  ::  z=~[%a %b]
  ::  n=:~
  ::    [~[%a %b %c] "abc"]
  ::    [~[%b %c %d] "bcd"]
  ::    [~[%c %d %e] "cde"]
  ::    [~[%a %b %z] "abz"]
  ::    ==
  ::  s=:~
  ::    [~[%a %b] ~[[~[%a %b %c] "abc"] [~[%a %b %z] "abz"]]]
  ::    [~[%a] ~]
  ::    [~[%b] ~[[~[%b %c %d] "bcd"]]]
  ::    ==
  |=  [z=keys n=notes]
  ^-  search
  ::  flop analysis: ++get-notes-any and
  ::  ++get-notes-all-not-all both flop
  ::  so they cancel each other out
  =.  n         (get-notes-any z n)
  =/  c=combos  (get-key-combos-all z)
  =|  s=search
  ::  try all c on n to construct s
  ::  s increases by matches of each c
  ::  n decreases by matches of each c
  ::  n should be ~ after all c
  |-  ?~  c  ?~  n  s  ~&  [%n-not-sig n=n]  !!
    =/  a=all-not-all  (get-notes-all-not-all i.c n)
    ?~  all.a
      $(n not-all.a, c t.c)
  $(s (snoc s [i.c all.a]), n not-all.a, c t.c)
::
::  state preparation and update
::
++  prepare-state
  |=  =vase
  ::  saved's type is a union of all state
  ::  definitions, not a specific one
  =/  saved  !<(state-versions vase)
  =?  saved  ?=(%0 -.saved)
    (state-0-to-1 s.saved)
  =?  saved  ?=(%1 -.saved)
    (state-1-to-2 s.saved)
  ?>  ?=(%2 -.saved)
  ::  manually build product of a specific
  ::  state definition, not the union one
  [%2 s=s.saved]
::
++  get-keys-all-0
  |=  =notes-0
  ^-  keys
  %+  roll  notes-0
  =|  [=note-0 =keys]
  |.  (weld keys (get-keys-no-match keys.note-0 keys))
::
++  state-0-to-1
  ~&  %state-0-to-1
  |=  =state-0
  =|  =state-1
  =.  all-notes.state-1  all-notes.state-0
  =.  all-keys.state-1   (get-keys-all-0 all-notes.state-0)
  [%1 s=state-1]
::
++  state-1-to-2
  ~&  %state-1-to-2
  |=  =state-1
  =|  =state-2
  =/  with-id=[notes-2 @ud]
    %^  spin  all-notes.state-1  0
    |=  [=note-1 id=@ud]
    ^-  [note-2 @ud]
    =.  id  +(id)
    :_  id  [id keys.note-1 text.note-1]
  =.  note-id.state-2    +.with-id
  =.  all-notes.state-2  -.with-id
  =.  all-keys.state-2   all-keys.state-1
  [%2 s=state-2]
::
--
