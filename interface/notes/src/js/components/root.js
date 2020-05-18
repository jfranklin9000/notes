import React, { Component } from 'react'
import { BrowserRouter, Route, Redirect } from 'react-router-dom'
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

  // not used yet XX
  searchKeysInput(event) {
    let state = this.state
    state.search.kews = event.target.value
    this.setState(state)
  }

  searchButton(event) {
    const keys = this.state.keys
    api.action('notes', 'json', {action: 'search', keys: keys})
  }

  newNoteButton(event) {
    api.action('notes', 'json', {action: 'new-note'})
  }

  matchClick(event, id) {
    api.action('notes', 'json', {action: 'get-note', id: id})
  }

  // note page

  keysInput(event) {
    this.setState({keys: event.target.value, edited: true})
  }

  saveButton(event) {
    const state = this.state
    const id = state.id
    const keys = state.keys
    const text = state.text
    api.action('notes', 'json',
      {action: 'save', id: id, keys: keys, text: text})
  }

  goToSearchButton(event) {
    // what about if note edited? XX
    const keys = this.state.keys
    api.action('notes', 'json', {action: 'search', keys: keys})
  }

  textTextArea(event) {
    this.setState({text: event.target.value, edited: true})
  }

  render() {
    const state = this.state
    // console.log('Root render()', state)

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
                    keysInputCB={(e) => this.keysInput(e)}
                    searchButtonCB={(e) => this.searchButton(e)}
                    newNoteButtonCB={(e) => this.newNoteButton(e)}
                    keys={state.keys}
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
                    keysInputCB={(e) => this.keysInput(e)}
                    saveButtonCB={(e) => this.saveButton(e)}
                    goToSearchButtonCB={(e) => this.goToSearchButton(e)}
                    keys={state.keys}
                    edited={state.edited}
                  />
                  <NoteText
                    textTextAreaCB={(e) => this.textTextArea(e)}
                    text={state.text}
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
