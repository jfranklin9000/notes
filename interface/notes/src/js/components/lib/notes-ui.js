import React, { Component } from 'react'

export class KeywordsSearchNewNote extends Component {
  render() {
    const props = this.props
    const searchC = 'fl ml3 ba b--green2 green2 br1 pointer pt1'
    const newNoteC = 'fr ml3 ba b--green2 green2 br1 pointer pt1'
    // do we need/want value={props.keys}? XX (don't seem to need it)
    return (
      <div className={'f6'}>
        <span className={'fl mr3 gray3 pt1'}>
          Keywords
        </span>
        <input
          className={'fl w-50 bg-gray4 black pt1 pb1 pl2 pr2'}
          onChange={(e) => props.keysInputCB(e)}
        />
        <button
          className={searchC}
          onClick={(e) => props.searchButtonCB(e)}
        >
          Search
        </button>
        <button
          className={newNoteC}
          onClick={(e) => props.newNoteButtonCB(e)}
        >
          New Note
        </button>
      </div>
    )
  }
}

// export
class KeysNotIn extends Component {
  render() {
    const keys = this.props.keysNi
    if (keys == null || keys.length == 0)
      return null
    const message = keys.length == 1
      ? 'This keyword didn\'t match any notes'
      : 'These keywords didn\'t match any notes'
    const ks = keys.map((key, n) => {
      return (
        <span key={n} className={'f6 red2 ml1 mr1'}>
          {key}
        </span>
      )
    })
    return (
      <div className={'mt3'}>
        <p className={'f8 tc'}>{message}</p>
        <div className={'mb3 tc'}>{ks}</div>
      </div>
    )
  }
}

function formatKeys(keysIn, keys)
{
  keysIn = keysIn || []
  keys = keys || []
  let ks = keys.map((key, n) => {
    const color =
      keysIn.some((k) => {return k == key}) ? 'green2' : 'gray3'
    return (
      <span key={n} className={'ml1 mr1 ' + color}>
        {key}
      </span>
    )
  })
  if (ks.length == 0)
    ks = <span className={'gray3 i'}>no keywords</span>
  return (
    <div className={'f7 bt b--gray2 mt2 pt2 tc'}>{ks}</div>
  )
}

// export
class Matches extends Component {
  render() {
    const props = this.props
    const matches = props.matches
    const keysIn = props.keysIn
    // combine with below XX
    // factor out <p> classNames
    if (matches == null || matches.length == 0) {
      return (
        <p className={'f7 bt b--gray2 gray3 tc mt2 pt2 i'}>
          no matches
        </p>
      )
    }
    const ms = matches.map((match, n) => {
      let notes = match.notes.map((note, n) => {
        let text = note.text
        let pC = 'f7 bt b--gray4 mt2 pt2 pointer'
        if (text == '') {
          text = 'no text'
          pC += ' i tc'
        }
        return (
          <div key={n}>
            {formatKeys(keysIn, note.keys)}
            <p
              className={pC}
              onClick={(e) => props.matchClickCB(e)}
              id={note.id}
            >
              {text}
            </p>
          </div>
        )
      })
      return (
        <div key={n}>{notes}</div>
      )
    })
    return (
      <div className={'bb b--gray2 pb2'}>{ms}</div>
    )
  }
}

export class SearchResults extends Component {
  render() {
    const props = this.props
    const search = props.search
    return (
      <div className={'mt2'}>
        <KeysNotIn keysNi={search.keysNi} />
        <Matches
          matchClickCB={props.matchClickCB}
          matches={search.matches}
          keysIn={search.keysIn}
        />
      </div>
    )
  }
}

export class KeywordsSaveGoToSearch extends Component {
  render() {
    const props = this.props
    let saveC = 'fr ml3 ba br1 pt1'
    let goToSearchC = 'fr ml3 ba br1 pointer pt1'
    if (props.edited) {
      saveC += ' b-red2 red2 pointer'
      goToSearchC += ' b-yellow2 yellow2'
    } else {
      saveC += ' b-gray3 gray3 pointer-events-none'
      goToSearchC += ' b-green2 green2'
    }
    // do we need/want value={props.keys}? XX
    return (
      <div className={'f6'}>
        <span className={'fl mr3 gray3 pt1'}>
          Keywords
        </span>
        <input
          className={'fl w-50 bg-gray4 black pt1 pb1 pl2 pr2'}
          onChange={(e) => props.keysInputCB(e)}
          value={props.keys}
        />
        {/* swap button order because they're float:right */}
        <button
          className={goToSearchC}
          onClick={(e) => props.goToSearchButtonCB(e)}
        >
          Go To Search
        </button>
        <button
          className={saveC}
          onClick={(e) => props.saveButtonCB(e)}
        >
          Save
        </button>
      </div>
    )
  }
}

export class NoteText extends Component {
  render() {
    const props = this.props
    // do we need/want value={props.text}? XX
    return (
      <textarea
        className={
          'pa2 pre f7 mt3 ba b--gray4 lh-copy ' +
          'overflow-auto flex-basis-100 resize-none'
        }
        onChange={(e) => props.textTextAreaCB(e)}
        value={props.text}
      >
      </textarea>
    )
  }
}
