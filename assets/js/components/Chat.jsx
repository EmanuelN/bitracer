import React, {Component} from "react"
import MessageList from "./MessageList.jsx"
import ChatBar from "./ChatBar.jsx"
import socket from "../socket"

class Chat extends Component {
  constructor(props) {
    super(props);
    this.state = {
      numUsers: 0,
      currUser: '',
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
      payload.username = 'System';
      const messages = this.state.messages.concat(payload);
      this.setState({ messages });
    });
  }

  updateUser(username) {
    if (username !== this.state.currUser) {
      this.channel.push('post_notification', {
        content: `* *${this.state.currUser || 'Anonymous'}* changed their name to *${username}* *`,
      });
      this.setState({ currUser: username });
    }
  }

  sendMessage(message) {
    this.channel.push('post_message', {
      username: message.username,
      content: message.value,
    });
  }  

  render() {
    return (
      <div>
        <MessageList messages={this.state.messages} />
        <ChatBar username={this.state.currUser} userCallback={(...args) => this.updateUser(...args)} updateMessages={(...args) => this.sendMessage(...args)} />
      </div>
    )
  }
}
export default Chat;
