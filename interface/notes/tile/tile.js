import React, { Component } from 'react';
// import classnames from 'classnames';
// import _ from 'lodash';

export default class udoneditTile extends Component {

  // constructor(props) {
  //   super(props);
  //   // console.log('notesTile.constructor()', props);
  // }

  render() {
    return (
      <div className={"w-100 h-100 relative bg-white bg-gray0-d " +
      "ba b--black b--gray1-d"}>
        <a className="w-100 h-100 db no-underline" href="/~notes">
          <p className="black white-d f9 absolute" style={{ left: 8, top: 8 }}>
            Notes
          </p>
          <p className="relative w-100 flex-col f9"
          style={{ top: 50, textAlign: 'center' }}>
            Create notes and search by keywords
          </p>
        </a>
      </div>
    );
  }

}

window.udoneditTile = udoneditTile;
