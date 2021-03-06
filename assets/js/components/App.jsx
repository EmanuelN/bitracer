import React from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Chat from './Chat';
import Game from './Game';
import Navbar from './Navbar';
import Footer from './Footer';

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

    <Footer />
  </div>
);

App.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
  user_chan: PropTypes.instanceOf(Channel).isRequired,
};
export default App;
