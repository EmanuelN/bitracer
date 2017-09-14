import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Racer from './Racer';

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      a: 0,
      b: 0,
      c: 0,
      d: 0,
      e: 0,
      winner: '',
    };
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('game_data', (payload) => {
      const a = payload.state.a / 6;
      const b = payload.state.b / 6;
      const c = payload.state.c / 6;
      const d = payload.state.d / 6;
      const e = payload.state.e / 6;
      this.setState({ a, b, c, d, e });
    });
    this.channel.on('winner_data', (payload) => {
      const winner = payload.winner;
      this.setState({ winner });
    });
  }

  render() {
    return (
      <div className="game" >
        <ul className="start">
          <li>
            <Racer racer={this.state.a} />
            <span>
              Lane1-------------------------------------------------------------------------
              ----------------------Finish!
            </span>
          </li>
          <li>
            <Racer racer={this.state.b} />
            <span>
              Lane2-------------------------------------------------------------------------
              ----------------------Finish!
            </span>
          </li>
          <li>
            <Racer racer={this.state.c} />
            <span>
              Lane3-------------------------------------------------------------------------
              ----------------------Finish!
            </span>
          </li>
          <li>
            <Racer racer={this.state.d} />
            <span>
              Lane4-------------------------------------------------------------------------
              ----------------------Finish!
            </span>
          </li>
          <li>
            <Racer racer={this.state.e} />
            <span>
              Lane5-------------------------------------------------------------------------
              ----------------------Finish!
            </span>
          </li>
        </ul>
      </div>
    );
  }
}
Game.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default Game;
