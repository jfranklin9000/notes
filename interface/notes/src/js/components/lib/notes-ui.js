import React, { Component } from 'react';

export class KeywordSearchBar extends Component {
  render() {
    const { props } = this;
    // console.log('props:', props);

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
