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
+$  state-1
  $:  all-notes=notes
      all-keys=keys
  ==
::
+$  state-versions
  $%  [%0 s=state-0]
      [%1 s=state-1]
  ==
::
+$  state  [%1 s=state-1]  ::  current
--
