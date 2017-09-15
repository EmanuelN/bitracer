import React from 'react';
import PropTypes from 'prop-types';

const Winner = props => (
  <div className="winner">{props.winner}</div>
);

Odds.propTypes = {
  odds: PropTypes.number.isRequired,
};

export default Winner;