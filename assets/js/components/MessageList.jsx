import React from 'react';
import PropTypes from 'prop-types';
import Message from './Message';

const MessageList = (props) => {
  const messages = props.messages.map(message => (
    <Message
      color={message.color}
      username={message.username}
      content={message.content}
      key={message.id}
    />
  ));
  return (
    <main className="messages">{messages}</main>
  );
};
MessageList.propTypes = {
  messages: PropTypes.object.isRequired,
};
export default MessageList;
