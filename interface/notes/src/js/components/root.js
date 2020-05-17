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

  keysInput(event) {
    // don't want to set edited if on search page? XX
    this.setState({keys: event.target.value, edited: true})
  }

  searchButton(event) {
    // on page reload this.state is null (not sure why), so
    // if you immediately click the Search button you get:
    // Uncaught TypeError: Cannot read property 'keys' of null
    // do something reasonable until i figure it out: XX
    // is this true with my new callback scheme? XX
    const keys = this.state ? this.state.keys : ''
    api.action('notes', 'json', {action: 'search', keys: keys})
  }

  newNoteButton(event) {
    api.action('notes', 'json', {action: 'new-note'})
  }

  matchClick(event) {
    const id = parseInt(event.target.getAttribute('id'))
    api.action('notes', 'json', {action: 'get-note', id: id})
  }

  saveButton(event) {
    // see searchButton note about page reload
    const state = this.state
    const id = state ? state.id : 0
    const keys = state ? state.keys : ''
    const text = state ? state.text : ''
    console.log('id', id, 'keys', keys, 'text', text)
    // fix this for new notes XX
    api.action('notes', 'json',
      {action: 'save', id: id, keys: keys, text: text})
  }

  goToSearchButton(event) {
    // console.log('Root goToSearchButton()', this.state)
    // what about if note edited? XX
    // yeesh, probably not right, but it works
    window.location.replace('/~notes')
  }

  textTextArea(event) {
    this.setState({text: event.target.value, edited: true})
  }

  render() {
    const state = this.state
    console.log('Root render()', state)

    return (
      <BrowserRouter>
        <div className='absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl'>
          <HeaderBar/>
          <Route exact path='/~notes' render={ () => {
            if (state.id) {
              // user clicked New Note button
              return (
                <Redirect to={'/~notes/note/' + state.id} />
              )
            }
            return (
              <div className='cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden'>
                <KeywordsSearchNewNote
                  keysInputCB={(e) => this.keysInput(e)}
                  searchButtonCB={(e) => this.searchButton(e)}
                  newNoteButtonCB={(e) => this.newNoteButton(e)}
                />
                <SearchResults
                  matchClickCB={(e) => this.matchClick(e)}
                  search={state.search}
                />
              </div>
            )}}
          />
          <Route exact path='/~notes/note/:id?' render={ props => {
            // get id from here, it may be undefined XX
            console.log(props.match.params)
            // do we need to send keys? KeywordsSearchNewNote doesn't XX
            return (
              <div className='cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden'>
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
            )}}
          />
        </div>
      </BrowserRouter>
    )
  }
}
