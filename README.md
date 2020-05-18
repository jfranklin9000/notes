# :notes

Create notes and search by keywords

### Install

```
git clone https://github.com/jfranklin9000/notes.git
cd notes
```

The directory structure copies `urbit/pkg/`.

```
cd interface/notes
cp urbitrc-sample .urbitrc
```

Edit `.urbitrc` to point to the `%home` desk of your fakezod.

Make sure the `%home` desk has been `|mount`ed and is visible
in the native filesystem.  (Your fakezod does not need to be
running at this point.)

```
npm install
npm run build
```

Start your fakezod and run these commands:

```
|commit %home
|start %notes
```

Goto `localhost` (or `localhost:8080`, etc.) in your browser.
