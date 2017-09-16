import React from 'react';
import PropTypes from 'prop-types';

const Odds = props => (
  <marquee direction="right" style={{ margin: '20px' }}>
    <span className="payouts">*payouts*</span>
    <span className="show-odds">
      <span style={{ color: 'black' }}>{props.names.a}</span>
      <span className="odds" >{props.odds_a}</span>
    </span>
    <span className="show-odds">
      <span style={{ color: 'black' }}>{props.names.b}</span>
      <span className="odds" >{props.odds_b}</span>
    </span>
    <span className="show-odds">
      <span style={{ color: 'black' }}>{props.names.c}</span>
      <span className="odds" >{props.odds_c}</span>
    </span>
    <span className="show-odds">
      <span style={{ color: 'black' }}>{props.names.d}</span>
      <span className="odds" >{props.odds_d}</span>
    </span>
    <span className="show-odds">
      <span style={{ color: 'black' }}>{props.names.e}</span>
      <span className="odds" >{props.odds_e}</span>
    </span>
    <span className="payouts">*payouts*</span>
  </marquee>
);

Odds.propTypes = {
  names: PropTypes.object.isRequired,
  odds_a: PropTypes.string.isRequired,
  odds_b: PropTypes.string.isRequired,
  odds_c: PropTypes.string.isRequired,
  odds_d: PropTypes.string.isRequired,
  odds_e: PropTypes.string.isRequired,
};

export default Odds;
