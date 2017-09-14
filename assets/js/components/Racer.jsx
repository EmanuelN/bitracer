import React from 'react';
import PropTypes from 'prop-types';

const Racer = props => (
  <div className="racer" style={{ position: 'relative', height: '40px', margin: '50px' }}>
    <img
      src="images/sprite.gif"
      className="sprite"
      style={{
        position: 'absolute',
        left: `${props.racer}px`,
      }}
      alt="run, boy, run!"
    />
  </div>
);

Racer.propTypes = {
  racer: PropTypes.number.isRequired,
};

export default Racer;
