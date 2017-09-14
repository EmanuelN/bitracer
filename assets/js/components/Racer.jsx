import React from 'react';
import PropTypes from 'prop-types';

const Racer = props => (
  <div className="racer" >
    <img
      src="images/sprite.gif"
      className="sprite"
      style={{
        position: 'absolute',
        left: `${props.racer - 8}%`,
      }}
      alt="run, boy, run!"
    />
  </div>
);

Racer.propTypes = {
  racer: PropTypes.number.isRequired,
};

export default Racer;
