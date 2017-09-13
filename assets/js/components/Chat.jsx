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
    this.channel.on('incoming_whisper', (payload) => {
      if (payload.target == this.state.currUser){
        console.log(payload)
        payload.username = payload.sender
        const messages = this.state.messages.concat(payload)
        this.setState({ messages })
        console.log(this.state.messages)
      }
    })
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
      } else if (message.value[1] === "w"){
        const target = message.value.split(/[ ,]+/)[1];
        let content = ""
        for (let i = 2; i < message.value.split(/[ ,]+/).length; i++){
          content += " " + message.value.split(/[ ,]+/)[i];
        }
        this.channel.push('post_whisper', {
          sender: this.state.currUser,
          target: target,
          content: content
        })
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
