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

// rename Search or SearchResults
export class Matches extends Component {
  matches() {
    // console.log('Root matches()', this.state);
    if (this.props.search === null)
      return '<p><i>no matches</i></p>';

    let matches = this.props.search.matches.map(function(match) {
      // console.log('match', match);

      // let keys = '<span>' + match.keys.join(' ') + '</span>';
      // console.log('keys', keys);

      let notes = match.notes.map(function(note) {
        return '<p>' + note.text + '</p>';
      });
      // console.log('notes', notes);

      // add Edit button XX
      return '<div>' + notes.join('<br>') + '</div>';
    });

    return matches.join('<br>');
  }

  render() {
    const { props } = this;
    // console.log('Matches render props:', props);

    return (
      <div
        dangerouslySetInnerHTML={{ __html: this.matches() }}
      >
      </div>
    );
  }
}
