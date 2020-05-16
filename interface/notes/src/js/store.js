// import { InitialReducer } from '/reducers/initial';
// import { ConfigReducer } from '/reducers/config';
// import { UpdateReducer } from '/reducers/update';

class Store {
    constructor() {
        // console.log('Store constructor()');
        this.state = {
            id: 0,
            keys: '',
            text: '',
            edited: false,
            search: {
              keysIn: [],
              keysNi: [],
              matches: []
            }
        };

        // this.initialReducer = new InitialReducer();
        // this.configReducer = new ConfigReducer();
        // this.updateReducer = new UpdateReducer();
        this.setState = () => { };
    }

    setStateHandler(setState) {
        // console.log('Store setStateHandler()', setState);
        this.setState = setState;
    }

    handleEvent(data) {
        // console.log('Store handleEvent()', data);
        let json = data.data;
        console.log('json', json);

        // this.initialReducer.reduce(json, this.state);
        // this.configReducer.reduce(json, this.state);
        // this.updateReducer.reduce(json, this.state);
        if (json.search !== undefined)
            this.state.search = json.search;
        this.setState(this.state);
    }
}

export let store = new Store();
window.store = store;
