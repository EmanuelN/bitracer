import React from 'react';
import PropTypes from 'prop-types';

const Odds = props => (
  <div className="marquee">
    <div>
      <span className="payouts">*payouts*</span>
      <span className="show-odds">
        <span className="black">{props.names.a}:&nbsp;</span>
        {props.odds_a}
      </span>
      <span className="show-odds">
        <span className="black">{props.names.b}:&nbsp;</span>
        {props.odds_b}
      </span>
      <span className="show-odds">
        <span className="black">{props.names.c}:&nbsp;</span>
        {props.odds_c}
      </span>
      <span className="show-odds">
        <span className="black">{props.names.d}:&nbsp;</span>
        {props.odds_d}
      </span>
      <span className="show-odds">
        <span className="black">{props.names.e}:&nbsp;</span>
        {props.odds_e}
      </span>
      <span className="payouts">*payouts*</span>
    </div>
  </div>
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
