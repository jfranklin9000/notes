::  ~dirwex-dosrev
::
/-  notes
/+  notes, default-agent, verb
=,  notes
::
!:  :: enable debug
::
^-  agent:gall
=|  =state
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    ::
    all-notes  all-notes.s.state
::
++  on-init
  ~&  >  %notes-on-init
  `this
::
++  on-save
  !>(state)
::
++  on-load
  |=  =vase
  `this(state (prepare-state vase))
::
++  on-poke
  |=  [=mark =vase]
  ::  ~&  [mark=mark vase=vase]
  =/  =command  !<(command vase)
  ?-  -.command
    %dump
      ~&  state
      `this
    %add
      =.  all-notes  (snoc all-notes note.command)
      `this
    %search
      ~&  (search-notes keys.command all-notes)
      `this
  ==
::
++  on-watch  ~&  >  %notes-on-watch  on-watch:def
++  on-leave  ~&  >  %notes-on-leave  on-leave:def
++  on-peek   ~&  >  %notes-on-peek   on-peek:def
++  on-agent  ~&  >  %notes-on-agent  on-agent:def
++  on-arvo   ~&  >  %notes-on-arvo   on-arvo:def
++  on-fail   ~&  >  %notes-on-fail   on-fail:def
--
