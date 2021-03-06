import React from 'react';
import PropTypes from 'prop-types';

const Racer = props => (
  <div className="racer">
    <img
      className="sprite"
      src={props.image}
      style={{
        position: 'absolute',
        left: `${props.racer - 5}%`,
      }}
      alt="run, boy, run!"
    />

    <span className="sprite-name">{props.name}</span>


    <img className="lighthouse" src="images/lighthouse.gif" />


  </div>
);

Racer.propTypes = {
  racer: PropTypes.number.isRequired,
  image: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
};

export default Racer;
