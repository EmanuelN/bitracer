import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';

function handleLogout() {
  const xhr = new XMLHttpRequest();
  xhr.open('DELETE', '/logout', false);
  xhr.setRequestHeader('X-CSRF-Token', document.head.querySelector('[name=csrf]').content);
  xhr.send(null);
}

class Navbar extends Component {
  constructor(props) {
    super(props);
    this.state = {
      username: document.getElementById('username').dataset.username,
      coins: 0,
    };
    this.user_chan = this.props.user_chan;
  }

  componentDidMount() {
    this.user_chan.on('new_coins', (payload) => {
      const coins = payload.coins;
      this.setState({ coins });
    });
  }

  render() {
    let navbar;
    if (this.state.username === '') {
      navbar = (
        <nav className="navbar">
          <center><span className="logo"><h2>BitRacer!</h2></span></center>
          <span><a href="/root">About Us</a></span>
          <span><a href="/root">Game Rules</a></span>
          <span className="user">
            <span className="login"><a href="/login">Login</a></span>
            <span className="register"><a href="/users/new">Register</a></span>
          </span>
        </nav>
      );
    } else {
      navbar = (
        <nav className="navbar">
          <center><span className="logo"><h2>BitRacer!</h2></span></center>
          <span><a href="/root">About Us</a></span>
          <span><a href="/root">Game Rules</a></span>
          <span className="user">
            <span className="currentuser">Currently Logged in as: {this.state.username}</span>
            <span>Remaining balance: {this.state.coins}</span>
            <span className="logout" onClick={handleLogout}><a href="/logout">Logout</a></span>
          </span>
        </nav>
      );
    }
    return navbar;
  }
}

Navbar.propTypes = {
  user_chan: PropTypes.instanceOf(Channel).isRequired,
};
export default Navbar;
