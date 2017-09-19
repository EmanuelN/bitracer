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
      messages: [{
        content: 'Welcome to the game, place bets using "/b id amount". Just make sure you\'re logged in first!',
        username: 'Admin',
      }],
      pos: 0,
      names: {},
    };
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('incoming_message', (payload) => {
      const messages = this.state.messages.concat(payload);
      this.setState({ messages });
    });
    this.channel.on('pos', (payload) => {
      const pos = payload.pos;
      this.setState({ pos });
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
    this.channel.on('names', (payload) => {
      this.setState({ names: payload });
    });
  }

  sendMessage(message) {
    const parseHorse = (horse) => {
      let lCaseHorse = horse.toLowerCase();
      const arr = ['a', 'b', 'c', 'd', 'e'];
      const horsenames = [
        this.state.names.a,
        this.state.names.b,
        this.state.names.c,
        this.state.names.d,
        this.state.names.e,
      ];
      for (let i = 0; i < horsenames.length; i++) {
        horsenames[i] = horsenames[i].toLowerCase();
      }
      if (isNaN(lCaseHorse)) {
        for (let i = 0; i < 5; i += 1) {
          if (lCaseHorse === arr[i]) {
            return lCaseHorse;
          }
          if (lCaseHorse === horsenames[i]) {
            return arr[i];
          }
        }
        return 'error';
      }
      lCaseHorse = parseInt(lCaseHorse, 10);
      if (lCaseHorse > 0 && lCaseHorse <= 5) {
        return arr[lCaseHorse - 1];
      }
      return 'error';
    };

    if (message.value[0] !== '/') {
      this.channel.push('post_message', {
        username: message.username,
        content: message.value,
      });
    } else if (message.username && message.value[1] === 'b') {
      const horse = parseHorse(message.value.split(/[ ,]+/)[1]);
      const bet = message.value.split(/[ ,]+/)[2];
      if (horse === 'error') {
        this.channel.push('post_whisper', {
          target: this.state.currUser,
          content: 'Invalid horse, use horse name, number or assigned letter',
          sender: 'System',
        });
      } else if (isNaN(Number(bet))) {
        this.channel.push('post_whisper', {
          target: this.state.currUser,
          content: 'Bet amount must be a number',
          sender: 'System',
        });
      } else if (this.state.pos >= 300) {
        this.channel.push('post_whisper', {
          target: this.state.currUser,
          content: 'It\'s too late to bet now.',
          sender: 'System',
        });
      } else {
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
      <div className="talk-area">
        <MessageList messages={this.state.messages} />
        <ChatBar
          className="input-field"
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
