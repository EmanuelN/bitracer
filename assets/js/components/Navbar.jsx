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
          <div className="logo"></div>
          <span className="center">
            <span className="regular"><a href="/"><i className="fa fa-home" aria-hidden="true"></i> Home</a></span>
            <span className="header">BitRacer!</span>
            <span className="regular"><a href="/login"><i className="fa fa-check-square-o" aria-hidden="true"></i> Login/Register</a></span>
          </span>

        </nav>
      );
    } else {
      navbar = (
        <nav className="navbar">
          <span className="logo"><center><span className="newheader">BitRacer!</span></center></span>
          <span className="center">
            <span className="regular"><a href="/"><i className="fa fa-home" aria-hidden="true"></i> Home</a></span>
            <span className="regular"><i className="fa fa-user-circle" aria-hidden="true"></i> Currently Logged in as: {this.state.username}</span>
            <span className="regular"><i className="fa fa-usd" aria-hidden="true"></i> Remaining balance: {this.state.coins}</span>
            <span className="regular" onClick={handleLogout}><a href="/logout"><i className="fa fa-check-square-o" aria-hidden="true"></i> Logout</a></span>
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
