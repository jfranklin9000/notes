import React, { Component } from 'react';

export class KeywordSearchBar extends Component {
  render() {
    const { props } = this;
    // console.log('KeywordSearchBar render props:', props);

    let divC = 'f5';
    let spanC = 'gray3';
    let inputC = 'bg-gray4 black';
    let buttonC = 'ba b--green2 green2 br1 pointer';

    return (
      <div className={ divC }>
        <span className={ spanC }>Keywords</span>
        <input
          className={ inputC }
          onChange={ props.keysInput.bind(this) }
        />
        <button
          className={ buttonC }
          onClick={ props.searchButton.bind(this) }
        >
          Search
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
