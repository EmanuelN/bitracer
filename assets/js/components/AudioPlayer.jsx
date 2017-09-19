import React, { Component } from 'react';

class AudioPlayer extends Component {

  // componentDidMount() {
  //       console.info('[AudioPlayer] componentDidMount...');
  //       this.props.el = React.findDOMNode(this.refs.audio_tag);
  //       console.info('audio prop set', this.props.el);
  //   }

    render() {

        return (


            <audio className="audioPlayer" src="https://www.dl-sounds.com/wp-content/uploads/edd/2017/04/Pim-Poy.mp3" autoPlay loop>

            </audio>
        );
    }
};

export default AudioPlayer;