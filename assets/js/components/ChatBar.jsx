import React, { Component } from 'react';
import PropTypes from 'prop-types';

class ChatBar extends Component {
  constructor(props) {
    super(props);
    this.state = {
      value: '',
    };
  }

  handleMessChange(e) {
    this.setState({ value: e.target.value });
  }

  handleKeyPress(e) {
    if (e.key === 'Enter') {
      this.props.updateMessages({
        username: this.props.username,
        value: this.state.value,
      });
      this.setState({ value: '' });
    }
  }

  render() {
    // uses inline functions to change the context of this
    return (

        <input
          className="chatbar-message"
          placeholder="Message"
          value={this.state.value}
          onChange={(...arg) => this.handleMessChange(...arg)}
          onKeyPress={(...arg) => this.handleKeyPress(...arg)}
        />

    );
  }
}
ChatBar.propTypes = {
  username: PropTypes.string.isRequired,
  updateMessages: PropTypes.func.isRequired,
};
export default ChatBar;
