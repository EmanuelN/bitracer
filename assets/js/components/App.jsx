import React from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import Chat from './Chat';
import Game from './Game';

const App = props => (
  <div className="wrapper">
    <article className="content">
      <center><h5>Main game area</h5></center>
      <Game channel={props.channel} />
    </article>
    <aside className="side">
      <center><h5>Chat area</h5></center>
      <Chat channel={props.channel} />
    </aside>
    <footer className="foot">
      <center>
        <img src="images/horse.gif" className="footer-pic" alt="icon" />
        <h6>copyright 2017 JES</h6>
      </center>
    </footer>
  </div>
);

App.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default App;
