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
  }

  componentDidMount() {
    this.channel = socket.channel("room:lobby", {});
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    this.channel.on('incomingMessage', recieveData);
    this.channel.on('incomingNotification', recieveData);
  }

  recieveData(data) {
    const newMessage = JSON.parse(data.data);
    switch (newMessage.type) {
    case 'incomingNewUser':
      this.setState({ numUsers: newMessage.userNum });
    }
  }

  updateUser(username) {
    if (username !== this.state.currUser) {
      this.channel.push('postNotification', {
        content: `* *${this.state.currUser || 'Anonymous'}* changed their name to *${username}* *`,
      });
      this.setState({ currUser: username });
    }
  }

  sendMessage(message) {
    this.channel.push('postMessage', {
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
