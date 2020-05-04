::  ~dirwex-dosrev
::
|%
+$  key     term
+$  keys    (list key)
+$  combos  (list keys)
+$  note    [id=@ud =keys text=tape]
+$  notes   (list note)
+$  match   [=keys =notes]  ::  all keys matched all notes
+$  search  (list match)
::
+$  all-not-all  [all=notes not-all=notes]  ::  internal
::
+$  command
  $%  [%add =note]
      [%search =keys]
      [%dump ~]
  ==
::
::  previous types (only use in +prepare-state)
::
+$  note-0   [=keys text=tape]
+$  notes-0  (list note-0)
::
+$  note-1   note-0
+$  notes-1  notes-0
::
+$  note-2   note    ::  changed from %1
+$  notes-2  notes
::
::  state definitions
::
+$  state-0
  $:  all-notes=notes-0
  ==
::
+$  state-1
  $:  all-notes=notes-1
      all-keys=keys
  ==
::
+$  state-2
  $:  ::  when a new note is added note-id is incremented
      ::  and used for the note id; the note id cannot be
      ::  used for +snag because of note deletions (and
      ::  note re-ordering, if that becomes a thing)
      note-id=@ud
      all-notes=notes
      all-keys=keys
  ==
::
+$  state-versions
  $%  [%0 s=state-0]
      [%1 s=state-1]
      [%2 s=state-2]
  ==
::
+$  state  [%2 s=state-2]  ::  current
--
