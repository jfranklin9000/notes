import React, { Component } from 'react'
import { BrowserRouter, Route } from 'react-router-dom'
import { HeaderBar } from './lib/header-bar.js'
import { KeywordsSearchNewNote, SearchResults,
         KeywordsSaveGoToSearch, NoteText } from './lib/notes-ui.js'

export class Root extends Component {

  constructor(props) {
    super(props)
    this.state = store.state
    store.setStateHandler(this.setState.bind(this))
  }

  // search page

  searchKeysInput(event) {
    let state = this.state
    state.search.keys = event.target.value
    this.setState(state)
  }

  searchButton(event) {
    const keys = this.state.search.keys
    api.action('notes', 'json', {action: 'search', keys: keys})
  }

  newNoteButton(event) {
    api.action('notes', 'json', {action: 'new-note'})
  }

  matchClick(event, id) {
    api.action('notes', 'json', {action: 'get-note', id: id})
  }

  // note page

  noteKeysInput(event) {
    let state = this.state
    state.note.keys = event.target.value
    state.note.edited = true
    this.setState(state)
  }

  saveButton(event) {
    const state = this.state
    const id = state.id
    const keys = state.note.keys
    const text = state.note.text
    api.action('notes', 'json',
      {action: 'save', id: id, keys: keys, text: text})
  }

  goToSearchButton(event) {
    const state = this.state
    let keys = state.note.keys
    if (state.note.edited) {
      if (confirm('Your edits will be lost.  Are you sure?'))
        keys = state.search.keys
      else
        return
    }
    api.action('notes', 'json', {action: 'search', keys: keys})
  }

  textTextArea(event) {
    let state = this.state
    state.note.text = event.target.value
    state.note.edited = true
    this.setState(state)
  }

  render() {
    const state = this.state
    console.log('Root render()', state)

    return (
      <BrowserRouter>
        <div className='absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl'>
          <HeaderBar/>
          <Route exact path='/~notes' render={() => {
            const containerC =
              'cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 f9 overflow-x-hidden ' +
              'h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl white-d'
            if (state.id == 0) {
              // search page
              return (
                <div className={containerC}>
                  <KeywordsSearchNewNote
                    keysInputCB={(e) => this.searchKeysInput(e)}
                    searchButtonCB={(e) => this.searchButton(e)}
                    newNoteButtonCB={(e) => this.newNoteButton(e)}
                    keys={state.search.keys}
                  />
                  <SearchResults
                    matchClickCB={(e, id) => this.matchClick(e, id)}
                    search={state.search}
                  />
                </div>
              )
            } else {
              // note page
              return (
                <div className={containerC}>
                  <KeywordsSaveGoToSearch
                    keysInputCB={(e) => this.noteKeysInput(e)}
                    saveButtonCB={(e) => this.saveButton(e)}
                    goToSearchButtonCB={(e) => this.goToSearchButton(e)}
                    keys={state.note.keys}
                    edited={state.note.edited}
                  />
                  <NoteText
                    textTextAreaCB={(e) => this.textTextArea(e)}
                    text={state.note.text}
                  />
                </div>
              )
            }}}
          />
        </div>
      </BrowserRouter>
    )
  }
}
