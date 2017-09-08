import React, {Component} from "react";

class Message extends Component {
  render() {
    let renderMessage = '';
    renderMessage = (
      <div className="message">
        <span className="message-username" style={{color: `#${this.props.message.color}`}}>{this.props.message.username || 'Anonymous'} Says: </span>
        <span className="message-content">{this.props.message.content}</span>
      </div>
    );

    return renderMessage;
  }
}
export default Message;
