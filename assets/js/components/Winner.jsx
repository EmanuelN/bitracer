import React, { Component } from 'react';

class Winner extends Component {
  constructor(props) {
    super(props);
    this.state = {
      winner: this.props.winner,
    };
  }
  render() {
    if (this.state.winner === 'a') {
      return (
        <div>
          <img className="sprite" alt="racer1" src="images/pikachu.gif" />
        </div>
      );
    } else if (this.state.winner === 'b') {
      return (
        <div>
          <img className="sprite" alt="racer2" src="images/flareon.gif" />
        </div>
      );
    } else if (this.state.winner === 'c') {
      return (
        <div>
          <img className="sprite" alt="racer3" src="images/crossfox.gif" />
        </div>
      );
    } else if (this.state.winner === 'd') {
      return (
        <div>
          <img className="sprite" alt="racer4" src="images/zoroark.gif" />
        </div>
      );
    }
    return (
      <div>
        <img className="sprite" alt="racer5" src="images/homer.gif" />
      </div>
    );
  }
}
export default Winner;
