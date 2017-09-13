import React from 'react';
import PropTypes from 'prop-types';

const Message = props => (
  <div className="message">
    <span className="message-username" style={{ color: `#${props.color}` }}>
      {props.username || 'Anonymous'}:
    </span>
    <span className="message-content">{props.content}</span>
  </div>
);

Message.propTypes = {
  username: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  color: PropTypes.string,
};
Message.defaultProps = {
  color: '000',
};
export default Message;
