import React, { Component } from 'react';

class Footer extends Component {

  render() {

    return (
      <footer className="foot">
        <div className="center">
          <span className="about"><a href="/root">About Us</a></span>
          <span className="about"><a href="/root">Game Rules</a></span>
          <span className="about"><a href="mailto:greatlakesracing@gmail.com?subject=Business%20Proposal">Contact Us</a></span>
        </div>
        <center><img src="images/sprite.gif" className="footer-pic" alt="icon" /></center>
      </footer>
    );

  }
}

export default Footer;