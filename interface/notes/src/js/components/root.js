import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect } from 'react-router-dom';
import { HeaderBar } from './lib/header-bar.js'
import { KeywordsSearchNewNote, SearchResults } from './lib/notes-ui.js'
import { KeywordsSaveGoToSearch } from './lib/notes-ui.js'

export class Root extends Component {

  constructor(props) {
    // console.log('Root constructor()', props);
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
  }

  keysInput(event) {
    // console.log('Root keysInput()', event.target.value);
    this.setState({keys: event.target.value});
  }

  searchButton() {
    // console.log('Root searchButton()', this.state);
    api.action('notes', 'json',
      {action: 'search', keys: this.state.keys});
  }

  newNoteButton() {
    // console.log('Root newNoteButton()', this.state);
    api.action('notes', 'json',
      {action: 'new-note'});

// need a redirect here.. /~notes/note/42 (but we don't know 42..)
    // need a redirect to /~notes/note
    // could not get this to work XX
    // return <Redirect to='/~notes/note' />;
    // yeesh, probably not right, but it works
    window.location.replace('/~notes/note');
  }

  saveButton() {
    // console.log('Root saveButton()', this.state);

console.log('HELLO from saveButton()');
  }

  goToSearchButton() {
    // console.log('Root goToSearchButton()', this.state);

console.log('HELLO from goToSearchButton()');
  }

  textTextArea() {
    // console.log('Root textTextArea()', event.target.value);
    this.setState({text: event.target.value});
  }

  addButton() {
    // console.log('Root addButton()', this.state);
    api.action('notes', 'json',
      {action: 'add', id: 0, keys: this.state.keys, text: this.state.text});

    // need a redirect to /~notes/edit (/~notes for now)
    // could not get this to work XX
    // return <Redirect to='/~notes' />;
    // yeesh, probably not right, but it works
    window.location.replace('/~notes');
  }

  render() {
    const state = this.state;
    console.log('Root render()', state);

    return (
      <BrowserRouter>
        <div className='absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl'>
          <HeaderBar/>
          <Route exact path='/~notes' render={ () => {
            return (
              <div className='cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden'>
                <KeywordsSearchNewNote
                  keysInput={this.keysInput}
                  searchButton={this.searchButton}
                  newNoteButton={this.newNoteButton}
                />
                <SearchResults
                  search={state.search}
                />
              </div>
            )}}
          />

          <Route exact path='/~notes/note/:id?' render={ props => {
console.log(props.match.params); // get id from here, it may be undefined

            return (
              <div className='cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden'>
                <KeywordsSaveGoToSearch
                  keysInput={this.keysInput}
                  saveButton={this.saveButton}
                  goToSearchButton={this.goToSearchButton}
                />

                {/* do we want to set value here? */}
                <textarea
                  className='pa2 pre f6 mt3 ba b--gray4 lh-copy overflow-auto'
                  style={{flexBasis: '100%', resize: 'none'}}
                  value={state.text}
                  onChange={this.textTextArea.bind(this)}
                >
                </textarea>

              </div>
            )}}
          />

          <Route exact path='/~notes/add' render={ () => {
            return (
              <div className='cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden'>

                <p style={{fontSize: 1.0 + 'rem', color: 'lightgray'}}>
                  Add a note
                </p>

                {/* do we want to set value here? */}
                <input style={{ background: 'lightgray',
                                fontSize: 1.5 + 'rem',
                                marginTop: 0.5 + 'rem' }}
                       value={ state.keys }
                       onChange={ this.keysInput.bind(this) }
                />

                {/* do we want to set value here? */}
                <textarea className='br pa2 pre'
                          style={{ flexBasis: '50%', resize: 'none' }}
                          value={ state.text }
                          onChange={ this.textTextArea.bind(this) }
                >
                </textarea>

                <button className='mt3 fr f4'
                        style={{ color: 'lightgray', cursor: 'pointer' }}
                        onClick={ this.addButton.bind(this) }>
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
