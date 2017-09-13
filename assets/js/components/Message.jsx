import React from 'react';
import PropTypes from 'prop-types';

const Message = props => (
  <div className="message">
    <span className="message-username" style={{ color: `#${props.color}`, fontStyle: props.font }}>
      {props.username || 'Anonymous'}: 
    </span>
    <span className="message-content" style={{ fontStyle: props.font }}>{props.content}</span>
  </div>
);

Message.propTypes = {
  username: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  color: PropTypes.string,
  font: PropTypes.string,
};
Message.defaultProps = {
  color: '000',
  font: 'normal',
};
export default Message;
