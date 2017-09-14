import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Racer from './Racer';
import Odds from './Odds';

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
      odds: {},
      names: {},
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
    this.channel.on('odds', (payload) => {
      this.setState({ odds: payload });
    });
    this.channel.on('names', (payload) => {
      this.setState({ names: payload });
    });
  }

  render() {
    return (

      <div className="someDiv" >

        <div className="ticker" style={{ textAlign: 'center' }}>
          <span className="payouts">*payouts*</span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horse A </span> <Odds odds={`${Math.trunc(this.state.odds.a * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horse B </span> <Odds odds={`${Math.trunc(this.state.odds.b * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horse C </span> <Odds odds={`${Math.trunc(this.state.odds.c * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horse D </span> <Odds odds={`${Math.trunc(this.state.odds.d * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horse E </span> <Odds odds={`${Math.trunc(this.state.odds.e * 10) / 10}:1`} /></span>
          <span className="payouts">*payouts*</span>
        </div>


        <ul className="start">
          <li>
            <Racer racer={this.state.a} />
          </li>
          <li>
            <Racer racer={this.state.b} />
          </li>
          <li>
            <Racer racer={this.state.c} />
          </li>
          <li>
            <Racer racer={this.state.d} />
          </li>
          <li>
            <Racer racer={this.state.e} />
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
