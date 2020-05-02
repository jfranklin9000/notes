import React, { Component } from 'react';
import { BrowserRouter, Route } from 'react-router-dom';
import { HeaderBar } from './lib/header-bar.js'

export class Root extends Component {

  constructor(props) {
    // console.log('Root constructor()', props);
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
  }

  keys(event) {
    // console.log('Root keys()', event.target.value);
    this.setState({ keys: event.target.value });
  }

  search() {
    // console.log('Root search()', this.state);
    api.action('notes', 'json',
      { action: 'search', keys: this.state.keys });
  }

  render() {

    console.log('Root render()', this.state);

    return (
      <BrowserRouter>
        <div className="absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl">
          <HeaderBar/>
          <Route exact path="/~notes" render={ () => {
            return (
              <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden">

                <p style={{ fontSize: 1.0 + 'rem', color: 'lightgray' }}>
                  Search notes with keywords
                </p>

                {/* do we want to set value here? */}
                <input style={{ background: 'lightgray',
                                fontSize: 1.5 + 'rem',
                                marginTop: 0.5 + 'rem' }}
                       value={ this.state.keys }
                       onChange={ this.keys.bind(this) }
                />

                <button className="mt3 fr f4"
                        style={{ color: 'lightgray', cursor: 'pointer' }}
                        onClick={ this.search.bind(this) }>
                  Search
                </button>

              </div>
            )}}
          />
        </div>
      </BrowserRouter>
    )
  }
}
