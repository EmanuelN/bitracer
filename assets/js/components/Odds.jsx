import React from 'react';
import PropTypes from 'prop-types';

const Odds = props => (
  <span className="odds" >{props.odds}</span>
);

Odds.propTypes = {
  odds: PropTypes.number.isRequired,
};

export default Odds;
