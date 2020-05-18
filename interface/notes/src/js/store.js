// import { InitialReducer } from '/reducers/initial'
// import { ConfigReducer } from '/reducers/config'
// import { UpdateReducer } from '/reducers/update'

class Store {
  constructor() {
    this.state = {
      id: 0,
      keys: '',
      text: '',
      edited: false,
      //
      search: {
        keysIn: [],
        keysNi: [],
        matches: []
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
    console.log('json', json)

    // this.initialReducer.reduce(json, this.state)
    // this.configReducer.reduce(json, this.state)
    // this.updateReducer.reduce(json, this.state)

    if (json.search !== undefined) {
      const search = json.search
      state.search = search
      state.keys = search.keys.join(' ')
      state.id = 0
    }

    if (json.note !== undefined) {
      const note = json.note
      state.id = note.id
      state.keys = note.keys.join(' ')
      state.text = note.text
    }

    this.setState(state)
  }
}

export let store = new Store()
window.store = store
