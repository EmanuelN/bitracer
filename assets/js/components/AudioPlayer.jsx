import React from 'react';
import PropTypes from 'prop-types';

const AudioPlayer = props => (
  <audio
    className="audioPlayer"
    src={props.src}
    autoPlay={props.autoPlay}
    loop={props.loop}
  />
);

AudioPlayer.propTypes = {
  autoPlay: PropTypes.bool.isRequired,
  loop: PropTypes.bool.isRequired,
  src: PropTypes.string.isRequired,
};

export default AudioPlayer;
