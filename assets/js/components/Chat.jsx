import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Channel } from 'phoenix';
import MessageList from './MessageList';
import ChatBar from './ChatBar';

class Chat extends Component {
  constructor(props) {
    super(props);
    this.state = {
      numUsers: 0,
      currUser: document.getElementById('username').dataset.username,
      messages: [],
    };
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('incoming_message', (payload) => {
      const messages = this.state.messages.concat(payload);
      this.setState({ messages });
    });
    this.channel.on('incoming_notification', (payload) => {
      const message = payload;
      message.username = 'System';
      const messages = this.state.messages.concat(payload);
      this.setState({ messages });
    });
    this.channel.on('incoming_whisper', (payload) => {
      if (payload.target === this.state.currUser || payload.sender === this.state.currUser) {
        const message = payload;
        message.username = payload.sender;
        message.font = 'italic';
        const messages = this.state.messages.concat(message);
        this.setState({ messages });
      }
    });
  }

  sendMessage(message) {
    if (message.value[0] !== '/') {
      this.channel.push('post_message', {
        username: message.username,
        content: message.value,
      });
    } else if (message.username && message.value[1] === 'b') {
      const horse = message.value.split(/[ ,]+/)[1];
      const bet = message.value.split(/[ ,]+/)[2];
      if (isNaN(Number(bet))) {
        this.channel.push('post_whisper', {
          target: this.state.currUser,
          content: 'Bet amount must be a number',
          sender: 'System',
        });
      } else {
        console.log(`${message.username} is betting ${bet}$ on ${horse}.`);
        this.channel.push('post_bet', {
          username: message.username,
          horse,
          bet,
        });
      }
    } else if (message.value[1] === 'w') {
      const target = message.value.split(/[ ,]+/)[1];
      let content = '';
      for (let i = 2; i < message.value.split(/[ ,]+/).length; i += 1) {
        content += ` ${message.value.split(/[ ,]+/)[i]}`;
      }
      this.channel.push('post_whisper', {
        sender: this.state.currUser,
        target,
        content,
      });
    }
  }

  render() {
    return (
      <div className="sidebar">
        <MessageList messages={this.state.messages} />
        <ChatBar
          username={this.state.currUser}
          updateMessages={(...args) => this.sendMessage(...args)}
        />
      </div>
    );
  }
}
Chat.propTypes = {
  channel: PropTypes.instanceOf(Channel).isRequired,
};
export default Chat;
