import React, {Component} from "react"
import MessageList from "./MessageList.jsx"

class Chat extends Component {
  constructor(props) {
    super(props);
    this.state = {
      numUsers: 0,
      currUser: '',
      messages: [],
    };
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
