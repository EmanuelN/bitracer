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
// var style = {
//   height: "100px",
//   width: "100px",
//   top: this.state.x,
//   position: "absolute",
//   src: "/images/sprite.gif",
//   backgroundColor: "red"
// }
// componentDidMount() {
//   Loop(function(tick) {
//     // animation code here
//     this.setState({
//       x: this.state.x + (this.props.racer * tick)
//     })
//   }.bind(this))

// }
