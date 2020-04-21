::  ~dirwex-dosrev
::
|%
+$  key     term
+$  keys    (list key)
+$  combos  (list keys)
+$  note    [=keys text=tape]
+$  notes   (list note)
+$  match   [=keys =notes]  ::  all keys matched all notes
+$  search  (list match)
::
+$  all-not-all  [all=notes not-all=notes]  ::  internal
::
+$  command
  $%  [%dump ~]
      [%add =note]
      [%search =keys]
  ==
::
::  state definitions
::
+$  state-0
  $:  all-notes=notes
  ==
::
+$  state-versions
  $%  [%0 s=state-0]
  ==
::
+$  state  [%0 s=state-0]  ::  current
--
