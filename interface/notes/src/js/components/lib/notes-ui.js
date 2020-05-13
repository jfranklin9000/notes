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

/**
function keyMatch(key, keys)
{
  // use lodash?
  for (let i = 0; i < keys.length; i++)
    if (key == keys[i])
      return true;

  return false;
}
**/

// export
class KeysInNotIn extends Component {
  render() {
    const keysIn = this.props.keysIn.map((key, n) => {
      return <span key={n} style={{color:'green'}}>{key}</span>;
    });
    const keysNi = this.props.keysNi.map((key, n) => {
      return <span key={n} style={{color:'red'}}>{key}</span>;
    });
    return (
      <div>
        {keysIn}
        {keysNi}
      </div>
    );
  }
}

// export
class Matches extends Component {
  render() {
    const matches = this.props.matches.map((match, n) => {
      // do something with match.keys FIXME
      let notes = match.notes.map((note, n) => {
        return <p key={n}>{note.text}</p>;
      });
      return <div key={n}>{notes}</div>
    });
    return <div>{matches}</div>;
  }
}

export class SearchResults extends Component {
  render() {
    const search = this.props.search;
    return (
      <div>
        <KeysInNotIn
          keysIn={search.keysIn}
          keysNi={search.keysNi}
        />
        <Matches
          matches={search.matches}
        />
      </div>
    );
  }
}

export class KeywordsSaveGoToSearch extends Component {
  render() {
    const props = this.props;
    const divC = 'f6';
    const spanC = 'fl mr3 gray3 pt1';
    const inputC = 'fl w-50 bg-gray4 black pt1 pb1 pl2 pr2';
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
      <div className={divC}>
        <span className={spanC}>
          Keywords
        </span>
        <input className={inputC}
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
