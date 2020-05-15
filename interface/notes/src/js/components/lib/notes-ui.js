import React, { Component } from 'react';

export class KeywordsSearchNewNote extends Component {
  render() {
    const props = this.props;
    // these are good for centered display without New Note button:
    // const divC = 'flex flex-row justify-center items-baseline f5';
    // const spanC = 'mr3 gray3';
    // const inputC = 'w-50 bg-gray4 black tc';
    // const buttonC = 'ml3 ba b--green2 green2 br1 pointer';
    // instead we will put the New Note button here:
    // (no flex here..)
    const divC = 'f6';
    const spanC = 'fl mr3 gray3 pt1';
    const inputC = 'fl w-50 bg-gray4 black pt1 pb1 pl2 pr2';
    const searchC = 'fl ml3 ba b--green2 green2 br1 pointer pt1';
    const newNoteC = 'fr ml3 ba b--green2 green2 br1 pointer pt1';
    return (
      <div className={divC}>
        <span className={spanC}>
          Keywords
        </span>
        <input className={inputC}
          onChange={props.keysInput.bind(this)}
        />
        <button className={searchC}
          onClick={props.searchButton.bind(this)}
        >
          Search
        </button>
        <button className={newNoteC}
          onClick={props.newNoteButton.bind(this)}
        >
          New Note
        </button>
      </div>
    );
  }
}

// export
class KeysNotIn extends Component {
  render() {
    const keys = this.props.keysNi;
    if (keys == null || keys.length == 0)
      return null;
    const message = keys.length == 1
      ? 'This keyword didn\'t match any notes'
      : 'These keywords didn\'t match any notes';
    const ks = keys.map((key, n) => {
      return (
        <span key={n} className={'f6 red2 ml1 mr1'}>
          {key}
        </span>
      );
    });
    return (
      <div className={'mt3'}>
        <p className={'f8 tc'}>{message}</p>
        <div className={'mt1 tc'}>{ks}</div>
      </div>
    );
  }
}

function keyMatch(key, keys)
{
  // what about keys==null? XX
  return keys.some((k) => { return k == key; });
}

function formatKeys(keysIn, keys)
{
  // check keys for null XX (need actual note with no keywords to test this)
  // (or could just hack to return no keys)
  const ks = keys.map((key, n) => {
    const color = keyMatch(key, keysIn) ? 'green2' : 'gray3';
    return (
      <span key={n} className={'ml1 mr1 ' + color}>
        {key}
      </span>
    );
  });
  return (
    <div className={'f7 bt b--gray2 mt2 pt2 tc'}>{ks}</div>
  );
}

// export
class Matches extends Component {
  render() {
    const matches = this.props.matches;
    const keysIn = this.props.keysIn;
    if (matches == null || matches.length == 0)
      return (
        <p className={'f7 gray3 tc mt7 i'}>
          no matches
        </p>
      );
    const ms = matches.map((match, n) => {
      // do something with match.keys FIXME
      let notes = match.notes.map((note, n) => {
        return (
          <div key={n}>
            {formatKeys(keysIn, note.keys)}
            <p className={'f7 bt b--gray4 mt2 pt2'}>  {/* don't need key={n} here? correct */}
              {note.text}
            </p>
          </div>
        );
      });
      return (
        <div key={n}>{notes}</div>
      );
    });
    return (
      <div className={'bb b--gray2 pb2'}>{ms}</div>
    );
  }
}

export class SearchResults extends Component {
  render() {
    const search = this.props.search;
    return (
      <div>
        <KeysNotIn keysNi={search.keysNi} />
        <Matches matches={search.matches} keysIn={search.keysIn} />
      </div>
    );
  }
}

export class KeywordsSaveGoToSearch extends Component {
  render() {
    const props = this.props;
// this should be gray if up-to-date XX
//  const saveC = 'fr ml3 ba b--green2 green2 br1 pointer pt1';
    let saveC = 'fr ml3 ba br1 pt1';
// this could be yellow if not up-to-date XX
//  const goToSearchC = 'fr ml3 ba b--green2 green2 br1 pointer pt1';
    let goToSearchC = 'fr ml3 ba br1 pointer pt1';
    const edited = false;
    if (edited) {
      saveC += ' b-red2 red2 pointer';
      goToSearchC += ' b-yellow2 yellow2';
    } else {
      saveC += ' b-gray3 gray3 pointer-events-none';
      goToSearchC += ' b-green2 green2';
    }
    return (
      <div className={'f6'}>
        <span className={'fl mr3 gray3 pt1'}>
          Keywords
        </span>
        <input className={'fl w-50 bg-gray4 black pt1 pb1 pl2 pr2'}
          onChange={props.keysInput.bind(this)}
        />
        {/* swap button order because they're float:right */}
        <button className={goToSearchC}
          onClick={props.goToSearchButton.bind(this)}
        >
          Go To Search
        </button>
        <button className={saveC}
          onClick={props.saveButton.bind(this)}
        >
          Save
        </button>
      </div>
    );
  }
}
