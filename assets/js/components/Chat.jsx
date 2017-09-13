import React, {Component} from "react"
import MessageList from "./MessageList.jsx"
import ChatBar from "./ChatBar.jsx"

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
      payload.username = 'System';
      const messages = this.state.messages.concat(payload);
      this.setState({ messages });
    });
  }

  sendMessage(message) {
    if (message.value[0] !== "/") {
      this.channel.push('post_message', {
        username: message.username,
        content: message.value,
      });
    } else {
      if (message.username && message.value[1] === "b"){
        const horse = message.value.split(/[ ,]+/)[1];
        const bet = message.value.split(/[ ,]+/)[2]
        if (isNaN(Number(bet))){
          this.channel.push("post_notification", {
            username: "System",
            content: "Bet amount must be a number"
          })
        } else {
          console.log(`${message.username} is betting ${bet}$ on ${horse}.`)
          this.channel.push('post_bet', {
            username: message.username,
            horse: horse,
            bet: bet
        })
        }

      }
    }

  }

  render() {
    return (
      <div className="sidebar">
        <MessageList messages={this.state.messages} />
        <ChatBar username={this.state.currUser} updateMessages={(...args) => this.sendMessage(...args)} />
      </div>
    )
  }
}
export default Chat;
