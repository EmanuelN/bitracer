import React, {Component} from "react"
import MessageList from "./MessageList.jsx"
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
  }

  render() {
    return (
      <div>
        <MessageList messages={this.state.messages} />
      </div>
    )
  }
}
export default Chat;
