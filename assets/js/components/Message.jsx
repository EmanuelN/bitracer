import React, {Component} from "react";

class Message extends Component {
  render() {
    if (!this.props.message.font) {
      this.props.message.font = "normal"
    }
    let renderMessage = '';
    renderMessage = (
      <div className="message">
        <span className="message-username" style={{ color: `#${this.props.message.color}`, fontStyle: this.props.message.font }}>{this.props.message.username || 'Anonymous'}: </span>
        <span className="message-content" style={{ fontStyle: this.props.message.font }}>{this.props.message.content}</span>
      </div>
    );

    return renderMessage;
  }
}
export default Message;
