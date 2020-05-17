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
::  +get-keys-in: get keys in a that are in b
::
++  get-keys-in
  |=  [a=keys b=keys]
  ^-  keys
  (skim a |=(=key (key-match key b)))
::
::  +get-keys-not-in: get keys in a that are not in b
::
++  get-keys-not-in
  |=  [a=keys b=keys]
  ^-  keys
  (skip a |=(=key (key-match key b)))
::
::  +get-keys-in-not-in:
::
::    get cell of:
::      - keys in a that are in b
::      - keys in a that are not in b
::
++  get-keys-in-not-in
  |=  [a=keys b=keys]
  ^-  [keys keys]
  (skid a |=(=key (key-match key b)))
::
::  +get-keys-all: get all keys from notes (no duplicates)
::
++  get-keys-all
  |=  =notes
  ^-  keys
  %+  roll  notes
  =|  [=note =keys]
  |.  (weld keys (get-keys-not-in keys.note keys))
::
::  +get-notes-any: get notes matching any key
::
++  get-notes-any
  |=  [=keys =notes]
  ^-  ^notes
  (skim notes |=(=note (key-match-any keys keys.note)))
::
::  +get-notes-all: get notes matching all keys
::
++  get-notes-all
  |=  [=keys =notes]
  ^-  ^notes
  (skim notes |=(=note (key-match-all keys keys.note)))
::
::  +get-notes-all-not-all:
::
::    get cell of:
::      - notes matching all keys
::      - notes not matching all keys
::
++  get-notes-all-not-all
  |=  [=keys =notes]
  ^-  [^notes ^notes]
  (skid notes |=(=note (key-match-all keys keys.note)))
::
::  +get-note-index-from-id: XX
::
++  get-note-index-from-id
  |=  [id=@ud =notes]
  ^-  (unit @ud)
  =|  dex=@ud
  |-
    ?~  notes  ~
    ?:  =(id id.i.notes)  `dex
  $(dex +(dex), notes t.notes)
::
::  +get-note-from-id: XX
::
++  get-note-from-id
  |=  [id=@ud =notes]
  ^-  (unit note)
  =/  dux=(unit @ud)
    (get-note-index-from-id id notes)
  ?~  dux  ~
  `(snag u.dux notes)
::
::  +get-key-combos-n: get combos of n from keys
::
++  get-key-combos-n
  |=  [n=@ud =keys]
  ^-  combos
  =<  (comb n keys ~ ~)
  |%
  ++  comb  ::  internal
    ::
    ::  ref: https://stackoverflow.com/questions/127704/
    ::       algorithm-to-return-all-combinations
    ::       -of-k-elements-from-n
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
    |=  [n=@ud r=^keys s=^keys c=combos]
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
::    get combos of n=(lent keys), n-1, ... 1 from keys
::
++  get-key-combos-all
  |=  =keys
  ^-  combos
  =|  =combos
  =/  n=@ud  (lent keys)
  |-
    ?:  =(n 0)  combos
  $(n (dec n), combos (weld combos (get-key-combos-n n keys)))
::
::  +get-matches:
::
::    get matches from notes that match any key from keys,
::    more matches from keys appear earlier in matches,
::    if a note matches ~[%a %b] it won't then match
::    ~[%a] or ~[%b], don't add [combo ~] to matches
::
++  get-matches
  |=  [=keys =notes]
  ^-  matches
  =/  motes=mold
    $~((get-notes-any keys notes) ^notes)
  =/  acc
    ::  try all combos on motes to construct matches,
    ::  matches increases by matches of each combo,
    ::  motes decreases by matches of each combo,
    ::  don't add [combo ~] to matches,
    ::  motes should be ~ after all combos
    %+  roll  (get-key-combos-all keys)
    =|  [=combo =motes =matches]
    |.
    =/  ana  (get-notes-all-not-all combo (^notes motes))
    [+.ana ?~(-.ana matches (snoc matches [combo -.ana]))]
  ?>  =(-.acc ~)
  +.acc
::
::  +get-matches-no-keys:
::
::    get matches from notes that have no keys
::
++  get-matches-no-keys
  |=  =notes
  ^-  matches
  =/  nok=^notes  (skim notes |=(=note =(keys.note ~)))
  ?~  nok  ~
  ~[[~ nok]]
::
::  +get-search: XX
::
::    add note about all=keys
::    (it's for the ui)
::
++  get-search
  |=  [=keys all=keys =notes]
  ^-  search
  =/  keys-ini=[^keys ^keys]
    (get-keys-in-not-in keys all)
  :*  keys
      -.keys-ini
      +.keys-ini
      ?~  keys
        (get-matches-no-keys notes)
      ::  optimization:
      ::  use -.keys-ini instead of keys
      ::  note: all-keys and all-notes
      ::        must be consistent
      (get-matches -.keys-ini notes)
  ==
::
::  json encoding
::
::  +cord-to-keys: XX
::
::    add comment about cord to @tas
::    (look at +sane)
::
++  cord-to-keys
  |=  =cord
  ^-  keys
  =/  =tape  (trip cord)
  =|  =keys
  =|  key=^tape
  |-
    ?~  tape
      ?~  key
        keys
      (snoc keys (crip key))
    ?.  =(i.tape ' ')
      $(tape t.tape, key (snoc key i.tape))
    ?~  key
      $(tape t.tape)
  $(tape t.tape, key ~, keys (snoc keys (crip key)))
::
::  +keys-to-cord: XX
::
++  keys-to-cord
 |=  =keys
 ^-  cord
 (crip (zing (join " " (turn keys |=(=key (trip key))))))
::
::  +keys-to-json: XX
::
++  keys-to-json
  |=  =keys
  ^-  json
  a+(turn keys |=(=key s+key))
::
::  +note-to-json: XX
::
++  note-to-json
  |=  =note
  ^-  json
  %-  pairs:enjs:format
  :~  ['id' (numb:enjs:format id.note)]
      ['keys' (keys-to-json keys.note)]
      ['text' (tape:enjs:format text.note)]
  ==
::
::  +notes-to-json: XX
::
++  notes-to-json
  |=  =notes
  ^-  json
  a+(turn notes |=(=note (note-to-json note)))
::
::  +match-to-json: XX
::
++  match-to-json
  |=  =match
  ^-  json
  %-  pairs:enjs:format
  :~  ['keys' (keys-to-json keys.match)]
      ['notes' (notes-to-json notes.match)]
  ==
::
::  +matches-to-json: XX
::
++  matches-to-json
  |=  =matches
  ^-  json
  a+(turn matches |=(=match (match-to-json match)))
::
::  +search-to-json: XX
::
++  search-to-json
  |=  =search
  ^-  json
  %-  pairs:enjs:format
  :~  :-  'search'
          %-  pairs:enjs:format
          :~  :-  'keys'     (keys-to-json keys.search)
              :-  'keysIn'   (keys-to-json keys-in.search)
              :-  'keysNi'   (keys-to-json keys-ni.search)
              :-  'matches'  (matches-to-json matches.search)
  ==      ==
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
  |.  (weld keys (get-keys-not-in keys.note-0 keys))
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
