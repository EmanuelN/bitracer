import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Racer from './Racer';
import Odds from './Odds';
import AudioPlayer from './AudioPlayer';
import Winner from './Winner';

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
    let winnerSent = false;
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
      if (payload.winner !== '' && winnerSent !== true) {
        this.channel.push('post_message', {
          username: 'System',
          content: `${this.state.names[winner]} won!`,
        });
        winnerSent = true;
      }
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
    if (!this.state.winner) {
      return (
        <div className="someDiv" >
          <center>
            <AudioPlayer src="https://www.dl-sounds.com/wp-content/uploads/edd/2017/04/Pim-Poy.mp3" autoPlay loop />
          </center>
          <Odds
            names={this.state.names}
            odds_a={`${Math.trunc(this.state.odds.a * 10) / 10}:1`}
            odds_b={`${Math.trunc(this.state.odds.b * 10) / 10}:1`}
            odds_c={`${Math.trunc(this.state.odds.c * 10) / 10}:1`}
            odds_d={`${Math.trunc(this.state.odds.d * 10) / 10}:1`}
            odds_e={`${Math.trunc(this.state.odds.e * 10) / 10}:1`}
          />

          <Racer racer={this.state.a} name={this.state.names.a} image="images/pikachu.gif" />
          <Racer racer={this.state.b} name={this.state.names.b} image="images/flareon.gif" />
          <Racer racer={this.state.c} name={this.state.names.c} image="images/crossfox.gif" />
          <Racer racer={this.state.c} name={this.state.names.d} image="images/zoroark.gif" />
          <Racer racer={this.state.c} name={this.state.names.e} image="images/homer.gif" />
        </div>
      );
    }
    return (
      <div className="someDiv" >
        <center>
          <AudioPlayer src="https://www.dl-sounds.com/wp-content/uploads/edd/2017/02/8-bit-Dancer2.mp3" autoPlay loop />
        </center>
        <Odds
          names={this.state.names}
          odds_a={`${Math.trunc(this.state.odds.a * 10) / 10}:1`}
          odds_b={`${Math.trunc(this.state.odds.b * 10) / 10}:1`}
          odds_c={`${Math.trunc(this.state.odds.c * 10) / 10}:1`}
          odds_d={`${Math.trunc(this.state.odds.d * 10) / 10}:1`}
          odds_e={`${Math.trunc(this.state.odds.e * 10) / 10}:1`}
        />

        <center>
          <div className="winner"><h1>{this.state.names[this.state.winner]} Won the Race!</h1></div>
        </center>
        <center>
          <Winner winner={this.state.winner} />
        </center>
      </div>
    );
  }
}

Game.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default Game;
