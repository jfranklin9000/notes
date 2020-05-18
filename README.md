# notes

Create notes and search by keywords

## Install

### Method 1

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

Go to `localhost` (or `localhost:8080`, etc.) in your browser.

### Method 2

I don't always commit `arvo/app/notes/css/index.css`,
`arvo/app/notes/js/index.js`, and `arvo/app/notes/js/tile.js`
so Method 1 is the surefire way to get these files.

I added a `hackathon` tag that has correct versions of
these files in relation to the other files.  Clone from
that tag and you don't have to run npm.

```
git clone -b hackathon https://github.com/jfranklin9000/notes.git
cd notes
```

Create a shell variable with the path to the `%home` desk of your fakezod.

```
# adjust as necessary
export ZODHOME=/PATH/TO/zod/home
```

Copy the files into your fakezod.

```
cp -r arvo/app/notes $ZODHOME/app
cp arvo/app/notes.hoon $ZODHOME/app
cp arvo/lib/notes.hoon $ZODHOME/lib
cp arvo/sur/notes.hoon $ZODHOME/sur
cp arvo/tests/lib/notes.hoon $ZODHOME/tests/lib
```

Start your fakezod and run these commands:

```
|commit %home
|start %notes
```

Go to `localhost` (or `localhost:8080`, etc.) in your browser.
