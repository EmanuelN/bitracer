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


  getWinner = (names) => {

    var getWinnerName = '';

    for (var key in names) {
      if (key == this.state.winner) {
        getWinnerName = names[key];

      }
    }
    return getWinnerName;
  }

  render() {
    if (!this.state.winner) {
      return (


      <div className="someDiv" >

        <audio controls>
          <source src="audio/pim.wav" type="audio/wav" />
          <p>Your browser doesn't support HTML5 audio. Here is a <a href="viper.mp3">link to the audio</a> instead.</p>
        </audio>

        <marquee direction="right" style={{margin: '20px'}}>

              <span className="payouts">*payouts*</span>
              <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.a} </span> <Odds odds={`${Math.trunc(this.state.odds.a * 10)/10}:1`} /></span>
              <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.b} </span> <Odds odds={`${Math.trunc(this.state.odds.b * 10)/10}:1`} /></span>
              <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.c} </span> <Odds odds={`${Math.trunc(this.state.odds.c * 10)/10}:1`} /></span>
              <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.d} </span> <Odds odds={`${Math.trunc(this.state.odds.d * 10)/10}:1`} /></span>
              <span className="show-odds"><span style={{color: 'black'}}>{this.state.names.e} </span> <Odds odds={`${Math.trunc(this.state.odds.e * 10)/10}:1`} /></span>
              <span className="payouts">*payouts*</span>

        </marquee>


            <Racer racer={this.state.a}  name={this.state.names.a}   image="images/crossfox.gif"/>

            <Racer racer={this.state.b}  name={this.state.names.b}   image="images/flareon.gif"/>

            <Racer racer={this.state.c}   name={this.state.names.c}  image="images/pikachu.gif"/>

            <Racer racer={this.state.c}   name={this.state.names.d}  image="images/zoroark.gif"/>

            <Racer racer={this.state.c}   name={this.state.names.e}  image="images/homer.gif" />



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
              <div className="winner"><h1>{this.getWinner(this.state.names)} Won the Race!</h1></div>
            </center>

            <center>

              <img className="sprite" src="images/crossfox.gif"/>

              <img className="sprite" src="images/flareon.gif"/>

              <img className="sprite" src="images/pikachu.gif"/>

              <img className="sprite" src="images/zoroark.gif"/>

              <img className="sprite" src="images/homer.gif"/>

              <img className="sprite" src="images/lighthouse.gif"  />

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
