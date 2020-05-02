// import { InitialReducer } from '/reducers/initial';
// import { ConfigReducer } from '/reducers/config';
// import { UpdateReducer } from '/reducers/update';

class Store {
    constructor() {
        // console.log('Store constructor()');
        this.state = {
            // udonedit, toss
            source: '',    // udon
            object: '',    // html
            edited: false,  // source and object are consistent
            // notes
            keys: ''
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
        console.log('Store handleEvent()', data);
        let json = data.data;

        // this.initialReducer.reduce(json, this.state);
        // this.configReducer.reduce(json, this.state);
        // this.updateReducer.reduce(json, this.state);
        // udonedit, toss
        this.state.source = json.state.source;
        this.state.object = json.state.object;
        this.state.edited = false;
        // notes
        this.state.keys = json.state.keys;  // we already have these?
        this.setState(this.state);
    }
}

export let store = new Store();
window.store = store;
