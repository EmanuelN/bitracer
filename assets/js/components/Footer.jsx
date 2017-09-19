import React, { Component } from 'react';

class Footer extends Component {
  render() {
    return (
      <footer className="foot">
        <div className="center">
          <span className="regular"><a href="/root"><i className="fa fa-info" aria-hidden="true" /> About Us</a></span>
          <span className="regular"><a href="/root"><i className="fa fa-question" aria-hidden="true" /> Game Rules</a></span>
          <span className="regular"><a href="mailto:greatlakesracing@gmail.com?subject=Business%20Proposal"><i className="fa fa-envelope" aria-hidden="true" /> Contact Us</a></span>
        </div>
        <center><img src="images/sprite.gif" className="footer-pic" alt="icon" /></center>
      </footer>
    );
  }
}

export default Footer;
