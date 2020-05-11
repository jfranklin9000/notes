::  ~dirwex-dosrev
::
/-  notes
/+  notes, *server, default-agent, verb
::
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/notes/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/notes/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/notes/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/notes/css/index
  /|  /css/
      /~  ~
  ==
/=  notes-png
  /^  (map knot @)
  /:  /===/app/notes/img  /_  /png/
::
=,  notes
::
!:  ::  enable debug
::
|%
+$  card  card:agent:gall
--
::
^-  agent:gall
=|  =state
=<
  |_  =bowl:gall
  +*  this  .
      nc    ~(. +> bowl)
      def   ~(. (default-agent this %|) bowl)
      ::
      note-id    note-id.s.state
      all-notes  all-notes.s.state
      all-keys   all-keys.s.state
  ::
  ++  on-init
    ~&  >  %notes-on-init
    ^-  (quip card _this)
    =/  launcha
      [%launch-action !>([%add %notes / '/~notes/js/tile.js'])]
    :_  this
    :~  [%pass / %arvo %e %connect [~ /'~notes'] %notes]
        [%pass /notes %agent [our.bowl %launch] %poke launcha]
    ==
  ::
  ++  on-save
    ~&  >  %notes-on-save
    !>(state)
  ::
  ++  on-load
    ~&  >  %notes-on-load
    |=  =vase
    `this(state (prepare-state vase))
  ::
  ++  on-poke
    ::  ~&  >  %notes-on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bowl src.bowl)
    ?+    mark  (on-poke:def mark vase)
    ::
    ::  XX
    ::
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      :_  this
      %+  give-simple-payload:app  eyre-id
      %+  require-authorization:app  inbound-request
      poke-handle-http-request:nc
    ::
    ::  browser actions
    ::
        %json
      =/  put  ((om:dejs:format same) !<(json vase))
      =/  act  (so:dejs:format (~(got by put) %action))
      ::
      ?:  =(act 'add')
        =.  note-id  +(note-id)
        =/  =note  :+  ::  handle like search below? XX
          note-id
          %-  cord-to-keys
            (so:dejs:format (~(got by put) %keys))
          %-  trip
            (so:dejs:format (~(got by put) %text))
        =.  all-notes  (snoc all-notes note)
        =.  all-keys  %+  weld  all-keys
          (get-keys-not-in keys.note all-keys)
        `this  ::  FIXME?
      ::
      ?:  =(act 'search')
        =|  =search
        =/  =keys  %-  cord-to-keys
          (so:dejs:format (~(got by put) %keys))
        =/  keys-ini=[^keys ^keys]
          (get-keys-in-not-in keys all-keys)
        =.  search
          %=  search
            keys     keys
            keys-in  -.keys-ini
            keys-ni  +.keys-ini
            ::  optimization: use -.keys-ini instead of keys
            matches  (search-notes -.keys-ini all-notes)
          ==
        =/  =json  (search-to-json search)
        :_  this
        [%give %fact ~[/primary] %json !>(json)]~
      ::
      ~&  >>  [%notes-unknown-action act]
      `this
    ::
    ::  dojo commands
    ::
        %noun
      =+  !<(com=command vase)
      ?-    -.com
      ::
          %add
        =.  note-id  +(note-id)
        =.  id.note.com  note-id  ::  overwrite
        =.  all-notes  (snoc all-notes note.com)
        =.  all-keys  %+  weld  all-keys
          (get-keys-not-in keys.note.com all-keys)
        `this
      ::
          %search
        =|  =search
        =/  keys-ini=[keys keys]
          (get-keys-in-not-in keys.com all-keys)
        =.  search
          %=  search
            keys     keys.com
            keys-in  -.keys-ini
            keys-ni  +.keys-ini
            ::  optimization: use -.keys-ini instead of keys.com
            matches  (search-notes -.keys-ini all-notes)
          ==
        ~&  search=search
        `this
      ::
          %dump
        ~&  state=state
        `this
      ==
    ==
  ::
  ++  on-watch
    ::  ~&  >  %notes-on-watch
    |=  =path
    ^-  (quip card _this)
    ?:  ?=([%http-response *] path)
      `this
    ?.  =(/primary path)
      (on-watch:def path)
    `this  ::  FIXME
  ::
  ++  on-arvo
    ~&  >  %notes-on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    `this
  ::
  ++  on-leave  ~&  >  %notes-on-leave  on-leave:def
  ++  on-peek   ~&  >  %notes-on-peek   on-peek:def
  ++  on-agent  ~&  >  %notes-on-agent  on-agent:def
  ++  on-fail   ~&  >  %notes-on-fail   on-fail:def
  --
::
::
|_  =bowl:gall
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~notes' %css %index ~]  (css-response:gen style)
      [%'~notes' %js %tile ~]    (js-response:gen tile-js)
      [%'~notes' %js %index ~]   (js-response:gen script)
  ::
      [%'~notes' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by notes-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~notes' *]  (html-response:gen index)
  ==
::
--
