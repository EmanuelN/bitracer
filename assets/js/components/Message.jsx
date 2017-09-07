import React, {Component} from "react";

class Message extends Component {
  render() {
    let renderMessage = '';
    renderMessage = (
      <div className="message">
        <span className="message-username" style={{color: `#${this.props.message.color}`}}>{this.props.message.username || 'Anonymous'}</span>
        <span className="message-content">{parsed}</span>
      </div>
    );

    return renderMessage;
  }
}
export default Message;
