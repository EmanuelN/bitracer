import React from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Chat from './Chat';
import Navbar from './Navbar';
import Game from './Game';
import Odds from './Odds';

const App = props => (
  <div className="wrapper">

    <Navbar user_chan={props.user_chan} />

    <article className="content">
      <Game channel={props.channel} />
    </article>
    <aside className="side">
      <center><h3>Please place your bets</h3></center>
      <Chat channel={props.channel} />
    </aside>
    <footer className="foot">
      <center>
        <img src="images/sprite.gif" className="footer-pic" alt="icon" />
      </center>
      <center><span>copyright 2017 JES</span></center>
    </footer>
  </div>
);

App.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default App;
