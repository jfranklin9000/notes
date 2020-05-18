// import { InitialReducer } from '/reducers/initial'
// import { ConfigReducer } from '/reducers/config'
// import { UpdateReducer } from '/reducers/update'

class Store {
  constructor() {
    this.state = {
      // id: =0 - search page, >0 - note page
      id: 0,
      // search page
      search: {
        keys: '',
        keysIn: [],
        keysNi: [],
        matches: []
      },
      // note page
      note: {
        keys: '',
        text: '',
        edited: false
      }
    }

    // this.initialReducer = new InitialReducer()
    // this.configReducer = new ConfigReducer()
    // this.updateReducer = new UpdateReducer()
    this.setState = () => { }
  }

  setStateHandler(setState) {
    this.setState = setState
  }

  handleEvent(data) {
    let state = this.state
    const json = data.data
    // console.log('json', json)

    // this.initialReducer.reduce(json, this.state)
    // this.configReducer.reduce(json, this.state)
    // this.updateReducer.reduce(json, this.state)

    if (json.search !== undefined) {
      const search = json.search
      state.id = 0
      state.search = search
      state.search.keys = search.keys.join(' ')
    }

    if (json.note !== undefined) {
      const note = json.note
      state.id = note.id
      state.note.keys = note.keys.join(' ')
      state.note.text = note.text
      state.note.edited = false
    }

    this.setState(state)
  }
}

export let store = new Store()
window.store = store
