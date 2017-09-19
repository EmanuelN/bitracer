import React, { Component } from 'react';
import PropTypes from 'prop-types';

class AudioPlayer extends Component {

    render() {

        return (


            <audio className="audioPlayer" src={this.props.src} autoPlay={this.props.autoPlay} loop={this.props.loop}>

            </audio>
        );
    }
};

AudioPlayer.propTypes = {
  autoPlay: PropTypes.bool,
  loop: PropTypes.bool,
  src: PropTypes.string,
};

export default AudioPlayer;