import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect } from 'react-router-dom';
import { HeaderBar } from './lib/header-bar.js'
import { KeywordSearchBar } from './lib/notes-ui.js'

export class Root extends Component {

  constructor(props) {
    // console.log('Root constructor()', props);
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
  }

  keysInput(event) {
    // console.log('Root keysInput()', event.target.value);
    this.setState({ keys: event.target.value });
  }

  searchButton() {
    // console.log('Root searchButton()', this.state);
    api.action('notes', 'json',
      { action: 'search', keys: this.state.keys });
  }

  text() {
    // console.log('Root text()', event.target.value);
    this.setState({ text: event.target.value });
  }

  add() {
    // console.log('Root add()', this.state);
    api.action('notes', 'json',
      { action: 'add', id: 0, keys: this.state.keys, text: this.state.text });

    // need a redirect to /~notes/edit (/~notes for now)
    // could not get this to work XX
    // return <Redirect to='/~notes' />;
    // yeesh, probably not right, but it works
    window.location.replace("/~notes");
  }

  // should be a Component? FIXME
  matches() {
    // console.log('Root matches()', this.state);
    if (this.state.matches === null)
      return '<p><i>no matches</i></p>';

    let matches = this.state.matches.map(function(match) {
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
    const { props, state } = this; // need props?

    console.log('Root render()', state, props);

    // need a New Note button on main page XX

    return (
      <BrowserRouter>
        <div className="absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl">
          <HeaderBar/>
          <Route exact path="/~notes" render={ () => {
            return (
              <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden">
                <KeywordSearchBar
                  keysInput={ this.keysInput }
                  searchButton={ this.searchButton }
                />
                <div
                  dangerouslySetInnerHTML={{ __html: this.matches() }}>
                </div>
              </div>
            )}}
          />

          <Route exact path="/~notes/add" render={ () => {
            return (
              <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden">

                <p style={{ fontSize: 1.0 + 'rem', color: 'lightgray' }}>
                  Add a note
                </p>

                {/* do we want to set value here? */}
                <input style={{ background: 'lightgray',
                                fontSize: 1.5 + 'rem',
                                marginTop: 0.5 + 'rem' }}
                       value={ state.keys }
                       onChange={ this.keys.bind(this) }
                />

                {/* do we want to set value here? */}
                <textarea className="br pa2 pre"
                          style={{ flexBasis: '50%', resize: 'none' }}
                          value={ state.text }
                          onChange={ this.text.bind(this) }
                >
                </textarea>

                <button className="mt3 fr f4"
                        style={{ color: 'lightgray', cursor: 'pointer' }}
                        onClick={ this.add.bind(this) }>
                  Add
                </button>

              </div>
            )}}
          />
        </div>
      </BrowserRouter>
    )
  }
}
