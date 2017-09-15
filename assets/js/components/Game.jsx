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
    if (!this.state.winner) {

    return (

      <div className="someDiv" >

        <marquee direction="right" style={{ margin: '20px' }}>

          <span className="payouts">*payouts*</span>
          <span className="show-odds"><span style={{ color: 'black' }}>Horsie </span> <Odds odds={`${Math.trunc(this.state.odds.a * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Sonic </span> <Odds odds={`${Math.trunc(this.state.odds.b * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Pinky </span> <Odds odds={`${Math.trunc(this.state.odds.c * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Yoshi </span> <Odds odds={`${Math.trunc(this.state.odds.d * 10) / 10}:1`} /></span>
          <span className="show-odds"><span style={{ color: 'black' }}>Homer </span> <Odds odds={`${Math.trunc(this.state.odds.e * 10) / 10}:1`} /></span>
          <span className="payouts">*payouts*</span>

        </marquee>

        <center>
          <div className="winner"><h1>{this.state.winner} Won the Race!</h1></div>
        </center>

            <Racer racer={this.state.a} image="images/modernHorse.gif"/>

            <Racer racer={this.state.b} image="images/sonic.gif"/>

            <Racer racer={this.state.c} image="images/pinky.gif"/>

            <Racer racer={this.state.c} image="images/dino.gif"/>

            <Racer racer={this.state.c} image="images/homer.gif" />



        </div>
        );

        } else {
          return (

            <div className="someDiv" >

              <marquee direction="right" style={{margin: '30px'}}>

                <span className="payouts">*payouts*</span>
                <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.a} </span> <Odds odds={`${Math.trunc(this.state.odds.a * 10)/10}:1`} /></span>
                <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.b} </span> <Odds odds={`${Math.trunc(this.state.odds.b * 10)/10}:1`} /></span>
                <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.c} </span> <Odds odds={`${Math.trunc(this.state.odds.c * 10)/10}:1`} /></span>
                <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.d} </span> <Odds odds={`${Math.trunc(this.state.odds.d * 10)/10}:1`} /></span>
                <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.e} </span> <Odds odds={`${Math.trunc(this.state.odds.e * 10)/10}:1`} /></span>
                <span className="payouts">*payouts*</span>

              </marquee>

              <center>
                <div className="winner"><h1>{this.state.winner} Won the Race!</h1></div>
              </center>

              <center>

                <img className="sprite" src="images/horse.gif"/>


            <img className="sprite" src="images/horse.gif" />

            <img className="sprite" src="images/sonic.gif" />

            <img className="sprite" src="images/pinky.gif" />

            <img className="sprite" src="images/dino.gif" />

            <img className="sprite" src="images/homer.gif" />

          </center>

        </div>

      );
    }
  }
}

Game.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default Game;
